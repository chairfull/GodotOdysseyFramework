class_name UStr extends RefCounted

static func get_similar_str(key: String, list: Array, threshold := 0.5, msg := " Did you mean %s?") -> String:
	var sim := get_similar(key, list, threshold)
	return "" if not sim else msg % ", ".join(sim)

static func get_similar(key: String, list: Array, threshold := 0.5) -> Array:
	var out := []
	for item: String in list:
		var sim := key.similarity(item)
		if sim >= threshold:
			out.append([item, sim])
	out.sort_custom(func(a, b): return a[1] > b[1])
	return out.map(func(a): return a[0])

static func from_json(variant: Variant) -> String:
	return JSON.stringify(variant, "\t", false)

static func print_json(variant: Variant):
	print(from_json(variant))

static func print_yaml(variant: Variant):
	print(YAML.stringify(variant))

static func number_with_commas(number: float) -> String:
	var num_str := str(int(number))
	var result := ""
	var count := 0
	for i in range(num_str.length() - 1, -1, -1):
		result = num_str[i] + result
		count += 1
		if count % 3 == 0 and i != 0:
			result = "," + result
	return result

static func number_abbreviated(number: float, commas := true) -> String:
	const ABREVS := {
		1_000_000_000.0: "B",
		1_000_000.0: "M",
		1_000.0: "K"
	}
	var abs_n := absf(number)
	var sign_char := "-" if number < 0 else ""
	for amnt in ABREVS:
		if abs_n >= amnt:
			return "%s%.1f%s" % [sign_char, str(abs_n / amnt).rstrip("0").rstrip("."), ABREVS[amnt]]
	if commas:
		return number_with_commas(number)
	return "%s%d" % [sign_char, int(abs_n)]
