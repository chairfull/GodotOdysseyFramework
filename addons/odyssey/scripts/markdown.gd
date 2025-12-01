class_name Markdown extends RefCounted

enum Element {
	FRONTMATTER,
	HEADER,
	CODE,
	PARAGRAPH,
	LIST_ITEM,
	QUOTE
}

static func to_bbcode(elements: Array[Dictionary]) -> String:
	var out: PackedStringArray
	for item in elements:
		match item.type:
			Element.HEADER:
				out.append("# " + item.head)
			Element.PARAGRAPH:
				out.append(item.text)
			Element.CODE:
				out.append(item.code)
	return "\n".join(out)

## Parse a Markdown file path, returning structured dict with unified "elements" array.
static func parse_file(path: String) -> Dictionary:
	return parse_string(FileAccess.get_file_as_string(path), path)

## Parse raw Markdown content string.
static func parse_string(content: String, path: String = "") -> Dictionary:
	var frontmatter: Dictionary[StringName, Variant]
	var tags: Array[StringName]
	var elements: Array[Dictionary]
	var i := 0
	var lines := content.split("\n")
	while i < lines.size():
		var line := lines[i]
		if line.begins_with("---"):
			var j := i+1
			var fm := []
			while j < lines.size() and not lines[j].begins_with("---"):
				fm.append(lines[j])
				j += 1
			var yaml_result := YAML.parse("\n".join(fm))
			if not yaml_result.has_error():
				frontmatter.assign(yaml_result.get_data())
			i = j
		elif line.begins_with("#"):
			var deep := 1
			while deep < line.length() and line[deep] == "#":
				deep += 1
			var token := line.substr(deep).strip_edges()
			# Header?
			if deep > 1 or line[deep] == " ":
				elements.append({ type=Element.HEADER, head=token, deep=deep })
			# Tag?
			else:
				tags.append(token)
		elif line.begins_with("```"):
			var j := i+1
			var lang := lines[i].trim_prefix("```")
			var code := []
			while j < lines.size() and not lines[j].begins_with("```"):
				code.append(lines[j])
				j += 1
			elements.append({ type=Element.CODE, lang=lang, code="\n".join(code) })
			i = j
		elif line.begins_with("> "):
			var j := i+1
			var quote := [lines[i]]
			while j < lines.size() and lines[j].begins_with("> "):
				quote.append(lines[j].trim_prefix("> "))
				j += 1
			elements.append({ type=Element.QUOTE, quote="\n".join(quote) })
			i = j
		else:
			if not elements.is_empty() and elements[-1].type == Element.PARAGRAPH:
				elements[-1].text += "\n" + line
			else:
				elements.append({ type=Element.PARAGRAPH, text=line })
		
		i += 1
	
	return { path=path, frontmatter=frontmatter, tags=tags, elements=elements }
