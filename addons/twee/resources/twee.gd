@tool
@icon("res://addons/twee/icon.svg")
class_name Twee extends Resource

const Tokenizer := preload("../builder/twee_tokenizer.gd")
const Token := preload("../builder/twee_tokens.gd")
const Parser := preload("../builder/twee_parser.gd")
const ClassWriter := preload("../builder/twee_class_writer.gd")
const Util := preload("../resources/twee_util.gd")

@export_custom(PROPERTY_HINT_EXPRESSION, "") var code: String:
	set(t):
		code = t
		changed.emit()

@export var target_property: NodePath
@export_storage var _script: ClassWriter
@export_group("Defaults", "default_")

static func is_target_array(root: Node, prop: NodePath) -> bool:
	return prop and typeof(root.get_indexed(prop)) == TYPE_ARRAY

#func get_property_type(node: Node, prop: StringName) -> int:
	#if not prop in _properties:
		#for p in node.get_property_list():
			#if p.name == prop:
				#_properties[prop] = p.type
				#return p.type
	#return _properties.get(prop, TYPE_NIL)

#region Access Tween

static func get_meta_key(node: Node, twee: Twee) -> StringName:
	# For debug purposes, we'll use node id and resource id to create a meta key.
	# Resource instance id's are negative, and meta fields can't take a "-", so we remove it.
	var tween_prop := StringName("twee_%s_%s" % [node.get_instance_id(), str(twee.get_instance_id()).substr(1)])
	return tween_prop

func get_tween(node: Node) -> Tween:
	var mk := get_meta_key(node, self)
	if node.has_meta(mk):
		return node.get_meta(mk)
	return null

func is_running(node: Node) -> bool:
	var twn := get_tween(node)
	return twn and twn.is_running()

func kill(node: Node):
	var mk := get_meta_key(node, self)
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
	
	var tween_prop := get_meta_key(root, self)
	var toks := Tokenizer.tokenize(code)
	var pars := Parser.parse(toks)
	var print_source := false
	_script = ClassWriter.new()
	var twn := _create_tween(root, tween_prop, pars, root, target_property, _script, for_child_node)
	var scr := _script.finish(print_source)
	set_twee_script(root, scr)
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

static func prnt_source_code(twee: Twee, root: Node = null):
	var toks := Tokenizer.tokenize(twee.code)
	var pars := Parser.parse(toks)
	var print_source := false
	var writer := ClassWriter.new()
	var tween_prop := get_meta_key(root, twee)
	var twn := twee._create_tween(root, tween_prop, pars, root, twee.target_property, writer, null)
	var scr := writer.finish(true)
	twee.kill(root)

static func _create_tween(node: Node, tween_prop: Variant, steps: Array[Dictionary], root: Node, root_prop: NodePath, writer: ClassWriter, for_child_node: Node) -> Tween:
	var twn: Tween = null
	for step in steps:
		match step.type:
			Token.FOR:
				match step.args[0]:
					Token.CHILD:
						for subnode in for_child_node.get_children():
							_create_tween(subnode, tween_prop, step.children, root, root_prop, writer, for_child_node)
					Token.GROUP:
						for subnode in node.get_tree().get_nodes_in_group(step.args[1]):
							_create_tween(subnode, tween_prop, step.children, root, root_prop, writer, for_child_node)
					Token.PROP:
						for subnode in for_child_node[step.args[1]]:
							if subnode:
								_create_tween(subnode, tween_prop, step.children, root, root_prop, writer, for_child_node)
					Token.FIND:
						for subnode in for_child_node.find_children(step.args[1], step.args[2]):
							_create_tween(subnode, tween_prop, step.children, root, root_prop, writer, for_child_node)
			Token.ON:
				for signal_id in step.args:
					# Force create it, even though this will get replaced.
					# Currently the first signal designed will be run... Maybe call stop()?
					_create_tween(node, tween_prop, step.children, root, root_prop, writer, for_child_node)
					if not node.has_signal(signal_id):
						push_warning("[Twee] %s has no signal %s." % [node, signal_id])
						continue
					var sig_info := get_signal_info(node, signal_id)
					node[signal_id].connect(func(...args):
						for i in args.size():
							if i < sig_info.args.size():
								var arg_info = sig_info.args[i]
								writer.scr.signal_args[arg_info.name] = args[i]
						_create_tween(node, tween_prop, step.children, root, root_prop, writer, for_child_node)
						)
			Token.PARALLEL:
				if not twn: twn = _tween(node, tween_prop)
				twn.set_parallel()
				_create_tween(node, twn, step.children, root, root_prop, writer, for_child_node)
			Token.BLOCK:
				if not twn: twn = _tween(node, tween_prop)
				_create_tween(node, twn, step.children, root, root_prop, writer, for_child_node)
			Token.METH:
				if not twn: twn = _tween(node, tween_prop)
				if is_target_array(root, root_prop):
					var root_list: Array = root.get_indexed(root_prop)
					for item in root_list:
						var meth := writer.add_static_func(root, item, step.meth, false)
						twn.tween_callback(writer.scr.call.bind(meth, root, item))
				else:
					var meth := writer.add_static_func(root, node, step.meth, false)
					twn.tween_callback(writer.scr.call.bind(meth, root, node))
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
				var sub := node.create_tween()
				sub.set_parallel()
				_add_sub(sub, step, root, root_prop, node, writer)
				twn.tween_subtween(sub)
			Token.PROPERTIES:
				if not twn: twn = _tween(node, tween_prop)
				var states: Array
				if is_target_array(root, root_prop):
					var root_array: Array = root.get_indexed(root_prop)
					for item in root_array:
						for prop in step.props:
							states.append(writer.add_property(root, item, prop, step.props[prop].val))
				else:
					for prop in step.props:
						states.append(writer.add_property(root, node, prop, step.props[prop].val))
				twn.tween_callback(func():
					for state in states:
						_set_from_scr(writer.scr, root, state))
	return twn

static func _set_from_scr(scr: GDScript, root: Node, state: Array) -> void:
	var targ: Object = state[0]
	var prop: StringName = state[1]
	var meth: StringName = state[2]
	var result: Variant = scr.call(meth, root, targ)
	targ.set(prop, result)

static func _add_sub(sub: Tween, step: Dictionary, root: Node, root_prop: NodePath, obj: Object, writer: ClassWriter, array_item := false) -> void:
	if not array_item and is_target_array(root, root_prop):
		var root_array: Array = root.get_indexed(root_prop)
		for i in root_array.size():
			var root_array_item: Variant = root_array[i]
			_add_sub(sub, step, root, root_prop, root_array_item, writer, true)
	else:
		var duration: float = step.duration
		var scr := writer.scr
		for prop in step.props:
			var prop_info: Dictionary = step.props[prop]
			var pt: Tweener
			var vars := {}
			var state := writer.add_property(root, obj, prop, prop_info.val)
			var targ: Object = state[0]
			var true_prop: StringName = state[1]
			var meth: StringName = state[2]
			sub.tween_callback(func():
				var a := targ.get(true_prop)
				var b := scr.call(meth, root, targ)
				vars[prop + "_a"] = a
				vars[prop + "_b"] = b if b != null else a)
			pt = sub.tween_method(
				func(t: float):
					var a: Variant = vars[prop + "_a"]
					var b: Variant = vars[prop + "_b"]
					var mixed := lerp(a, type_convert(b, typeof(a)), t)
					targ.set(true_prop, mixed),
				0.0, 1.0, duration)
			var mode: StringName = step.get(&"mode", &"LINEAR")
			if mode != &"LINEAR" and mode != &"L":
				var parts := mode.split("_", true, 1)
				pt.set_ease(Util.EASING.get(parts[0], Tween.EASE_IN_OUT))
				if parts.size() == 1:
					pt.set_trans(Tween.TRANS_SINE)
				else:
					pt.set_trans(Util.TRANSING.get(parts[1], Tween.TRANS_SINE))

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
