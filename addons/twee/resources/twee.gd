@tool
class_name Twee extends Resource

const Tokenizer := preload("../builder/twee_tokenizer.gd")
const Token := preload("../builder/twee_tokens.gd")
const Parser := preload("../builder/twee_parser.gd")
const ClassWriter := preload("../builder/twee_class_writer.gd")

@export_custom(PROPERTY_HINT_EXPRESSION, "") var code: String:
	set(t):
		code = t
		changed.emit()

@export_group("Defaults", "default_")
var _properties: Dictionary[StringName, Dictionary]

func get_property_type(node: Node, prop: StringName) -> int:
	if not prop in _properties:
		for p in node.get_property_list():
			if p.name == prop:
				_properties[prop] = p.type
				return p.type
	return _properties.get(prop, TYPE_NIL)

#region Access Tween

func _get_meta_key(node: Node) -> StringName:
	# For debug purposes, we'll use node id and resource id to create a meta key.
	# Resource instance id's are negative, and meta fields can't take a "-", so we remove it.
	var tween_prop := StringName("twee_%s_%s" % [node.get_instance_id(), str(get_instance_id()).substr(1)])
	return tween_prop

func get_tween(node: Node) -> Tween:
	var mk := _get_meta_key(node)
	if node.has_meta(mk):
		return node.get_meta(mk)
	return null

func is_running(node: Node) -> bool:
	var twn := get_tween(node)
	return twn and twn.is_running()

func kill(node: Node):
	var mk := _get_meta_key(node)
	if node.has_meta(mk):
		node.get_meta(mk).kill()
		node.set_meta(mk, null)

func play(node: Node):
	var twn := get_tween(node)
	if twn: twn.play()

func pause(node: Node):
	var twn := get_tween(node)
	if twn: twn.pause()

#endregion

func reload(root: Node, for_child_node: Node = null):
	if not code.strip_edges():
		push_warning("Code was empty.")
		return
	
	if not for_child_node:
		for_child_node = root
	
	var tween_prop := _get_meta_key(root)
	_properties = {}
	
	var toks := Tokenizer.tokenize(code)
	var pars := Parser.parse(toks)
	var print_source := false
	var twee_class := ClassWriter.new()
	_create_class(twee_class, pars)
	var scr := twee_class.create({  }, print_source)
	set_twee_script(root, scr)
	var twn := _create_tween(root, tween_prop, pars, root, scr, for_child_node)
	return twn

func set_twee_script(node: Node, script: GDScript):
	var id := "tweescript_%s_%s" % [node.get_instance_id(), abs(get_instance_id())]
	node.set_meta(id, script)

func get_twee_script(node: Node) -> GDScript:
	var id := "tweescript_%s_%s" % [node.get_instance_id(), abs(get_instance_id())]
	return node.get_meta(id)

static func prnt_tokens(cd: String):
	var toks := Tokenizer.tokenize(cd)
	print(toks)

static func prnt_parsed(cd: String):
	var toks := Tokenizer.tokenize(cd)
	var pars := Parser.parse(toks)
	print(JSON.stringify(pars, "\t", false))

static func prnt_source_code(cd: String):
	var toks := Tokenizer.tokenize(cd)
	var pars := Parser.parse(toks)
	var class_writer := ClassWriter.new()
	_create_class(class_writer, pars)
	var script_class := class_writer.create({})
	print(script_class.source_code)

static func _create_class(class_writer: ClassWriter, steps: Array[Dictionary]):
	for step in steps:
		match step.type:
			Token.FOR:
				match step.args[0]:
					Token.CHILD: _create_class(class_writer, step.children)
			Token.ON:
				for signal_id in step.args:
					_create_class(class_writer, step.children)
			Token.PARALLEL:
				_create_class(class_writer, step.children)
			Token.BLOCK:
				_create_class(class_writer, step.children)
			"METH":
				# Mutate
				step.meth = class_writer.add_static_func(step.meth, false)
			Token.LOOP: pass
			Token.WAIT: pass
			Token.STRING: pass
			Token.PROPERTIES_TWEENED:
				# Mutate
				for prop in step.props:
					var prop_info: Dictionary = step.props[prop]
					if not "mutated" in prop_info:
						prop_info.mutated = true
						prop_info.val = class_writer.add_static_func(prop_info.val)
			Token.PROPERTIES:
				# Mutate
				for prop in step.props:
					var prop_info: Dictionary = step.props[prop]
					if not "mutated" in prop_info:
						prop_info.mutated = true
						prop_info.val = class_writer.add_static_func(prop_info.val)

func _create_tween(node: Node, tween_prop: Variant, steps: Array[Dictionary], root: Node, scr: GDScript, for_child_node: Node) -> Tween:
	var twn: Tween = null
	for step in steps:
		match step.type:
			Token.FOR:
				match step.args[0]:
					Token.CHILD:
						for subnode in for_child_node.get_children():
							_create_tween(subnode, tween_prop, step.children, root, scr, for_child_node)
					Token.GROUP:
						for subnode in node.get_tree().get_nodes_in_group(step.args[1]):
							_create_tween(subnode, tween_prop, step.children, root, scr, for_child_node)
					Token.PROP:
						for subnode in for_child_node[step.args[1]]:
							if subnode:
								_create_tween(subnode, tween_prop, step.children, root, scr, for_child_node)
					Token.FIND:
						for subnode in for_child_node.find_children(step.args[1], step.args[2]):
							_create_tween(subnode, tween_prop, step.children, root, scr, for_child_node)
			Token.ON:
				for signal_id in step.args:
					node[signal_id].connect(func(...args):
						var sig_info := get_signal_info(node, signal_id)
						for i in args.size():
							if i < sig_info.args.size():
								var arg_info = sig_info.args[i]
								scr.signal_args[arg_info.name] = args[i]
						_create_tween(node, tween_prop, step.children, root, scr, for_child_node)
						)
			Token.PARALLEL:
				if not twn: twn = _tween(node, tween_prop)
				twn.set_parallel()
				_create_tween(node, twn, step.children, node, scr, for_child_node)
			Token.BLOCK:
				if not twn: twn = _tween(node, tween_prop)
				_create_tween(node, twn, step.children, node, scr, for_child_node)
			"METH":
				if not twn: twn = _tween(node, tween_prop)
				twn.tween_callback(scr.call.bind(step.meth, root, node))
			Token.LOOP:
				if twn:
					twn.set_loops(step.loop)
				else:
					push_error("No tween to repeat.")
			Token.WAIT:
				if not twn: twn = _tween(node, tween_prop)
				twn.tween_interval(step.wait)
			Token.STRING:
				# Call signal.
				if root.has_signal(&"_event"):
					if not twn: twn = _tween(node, tween_prop)
					twn.tween_callback(root[&"_event"].emit.bind(step.value))
				# Call method.
				elif root.has_method(&"_event"):
					if not twn: twn = _tween(node, tween_prop)
					twn.tween_callback(root[&"_event"].bind(step.value))
				else:
					push_warning("No event signal to emit.")
			Token.PROPERTIES_TWEENED:
				if not twn: twn = _tween(node, tween_prop)
				var duration: float = step.duration
				var sub := node.create_tween()
				sub.set_parallel()
				for prop in step.props:
					var prop_info: Dictionary = step.props[prop]
					var pt: Tweener
					var vars := {}
					var op := get_object_and_property(node, prop)
					var true_object: Object = op[0]
					var true_prop: String = op[1]
					var value: Variant = true_object.get_indexed(true_prop)
					vars[prop + "_a"] = value
					vars[prop + "_b"] = value
					if not node in scr.initial_state: scr.initial_state[node] = {}
					if not prop in scr.initial_state[node]: scr.initial_state[node][prop] = value
					sub.tween_callback(func():
						var a := true_object.get_indexed(true_prop)
						var b := scr.call(prop_info.val, root, node)
						vars[prop + "_a"] = a
						vars[prop + "_b"] = b if b != null else a)
					pt = sub.tween_method(func(t: float):
						var a: Variant = vars[prop + "_a"]
						var b: Variant = vars[prop + "_b"]
						true_object.set_indexed(true_prop, lerp(a, type_convert(b, typeof(a)), t)), 0.0, 1.0, duration)
					var mode: StringName = step.get(&"mode", &"LINEAR")
					if mode != &"LINEAR" and mode != &"L":
						var parts := mode.split("_", true, 1)
						match parts[0]:
							"EASE", "E": pt.set_trans(Tween.TRANS_SINE)
							"EASEIN", "EI": pt.set_ease(Tween.EASE_IN)
							"EASEOUT", "EO": pt.set_ease(Tween.EASE_OUT)
							"EASEOUTIN", "EOI": pt.set_ease(Tween.EASE_OUT_IN)
						if parts.size() == 1:
							pt.set_trans(Tween.TRANS_SINE)
						else:
							match parts[1]:
								#"SINE": pt.set_trans(Tween.TRANS_SINE)
								"QUINT": pt.set_trans(Tween.TRANS_QUINT)
								"QUART": pt.set_trans(Tween.TRANS_QUART)
								"QUAD": pt.set_trans(Tween.TRANS_QUAD)
								"EXPO": pt.set_trans(Tween.TRANS_EXPO)
								"ELASTIC": pt.set_trans(Tween.TRANS_ELASTIC)
								"CUBIC": pt.set_trans(Tween.TRANS_CUBIC)
								"CIRC": pt.set_trans(Tween.TRANS_CIRC)
								"BOUNCE": pt.set_trans(Tween.TRANS_BOUNCE)
								"BACK": pt.set_trans(Tween.TRANS_BACK)
								"SPRING": pt.set_trans(Tween.TRANS_SPRING)
				twn.tween_subtween(sub)
			Token.PROPERTIES:
				for prop in step.props:
					var prop_info: Dictionary = step.props[prop]
					if not node in scr.initial_state: scr.initial_state[node] = {}
					if not prop in scr.initial_state[node]:
						var op := get_object_and_property(node, prop)
						var true_object: Object = op[0]
						var true_prop: String = op[1]
						scr.initial_state[node][prop] = true_object.get_indexed(true_prop)
				if not twn: twn = _tween(node, tween_prop)
				twn.tween_callback(func():
					for prop in step.props:
						var prop_info: Dictionary = step.props[prop]
						var op := get_object_and_property(node, prop)
						var true_object: Object = op[0]
						var true_prop: String = op[1]
						var result: Variant = scr[prop_info.val].call(root, node)
						true_object.set_indexed(true_prop, result)
						)
	return twn

static func get_object_and_property(node: Node, prop: String) -> Array:
	if prop.begins_with("%"):
		var parts := prop.split(":", true, 1)
		node = node.get_node_or_null(parts[0])
		prop = parts[1]
	var node_and_resource := node.get_node_and_resource(prop)
	var n: Node = node_and_resource[0]
	var r: Resource = node_and_resource[1]
	var p: NodePath = node_and_resource[2]
	return [r if r else n if n else node, p if p else prop]

static func get_signal_info(node: Node, signame: StringName) -> Dictionary:
	for sig in node.get_signal_list():
		if sig.name == signame:
			return sig
	return {}

static func _tween(node: Node, tween_prop: Variant) -> Tween:
	if tween_prop is StringName:
		if node.has_meta(tween_prop):
			node.get_meta(tween_prop).kill()
		var twn := node.create_tween()
		node.set_meta(tween_prop, twn)
		twn.finished.connect(node.set_meta.bind(tween_prop, null))
		return twn
	elif tween_prop is Tween:
		var twn: Tween = node.create_tween()
		(tween_prop as Tween).tween_subtween(twn)
		return twn
	return null
