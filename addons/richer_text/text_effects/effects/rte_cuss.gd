@tool
extends RTxtEffect
## "Censors" a word by replacing vowels with symbols.

## Syntax: [cuss][]
const bbcode = "cuss"

const VOWELS := "aeiouAEIOU"
const CUSS_CHARS := "&$!@*#%"
const IGNORE := " !?.,;\""

func _update() -> bool:
	# Never censor first letter.
	if index != 0:
		# Always censor vowels.
		if chr in VOWELS:
			chr = CUSS_CHARS[int(rnd_smooth(5.0) * len(CUSS_CHARS))]
			color = Color.RED
		# Don't censor last letter.
		elif absolute_index + 1 < len(text) and not text[absolute_index + 1] in IGNORE:
			# Sometimes censor other letters.
			if rnd_time() > TAU * 0.75:
				chr = CUSS_CHARS[int(rnd_smooth(5.0) * len(CUSS_CHARS))]
				color = Color.RED
	return true
