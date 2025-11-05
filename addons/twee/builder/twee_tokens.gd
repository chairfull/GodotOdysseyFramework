extends RefCounted

const TRANS_NAMES: PackedStringArray = [
	"LINEAR", "L",
	"EASE", "E",
	"EASE_IN", "EI",
	"EASE_OUT", "EO",
	"EASE_OUT_IN", "EOI",
	
	"EASE_BACK", "E_BACK", "EI_BACK", "EO_BACK", "EOI_BACK",
	# TODO
]

const INDENT := "INDENT"
const DEDENT := "DEDENT"
const NEWLINE := "NEWLINE"
const COLON := ":"
const LOOP := "LOOP"
const WAIT := "WAIT"
const STRING := "STR"
const BLOCK := "BLOCK"
const PARALLEL := "PARALLEL"
const PARALLEL_SHORT := "PLL"
const ON := "ON"
const PROPERTIES_TWEENED := "PROPS_TWEENED"
const PROPERTIES := "PROPS"
#const REL := "+"
#const REL_NEG := "-"
#const REL_RUNTIME := "!"
const SPACE := "SPACE"
const PASS := "PASS"
const CHOICE := "CHOICE" # TODO
const WARP := "WARP" # TODO

const FOR := &"FOR"		# Beginning of a loop for nodes.
const CHILD := &"CHILD"	# 
const GROUP := &"GROUP"
const FIND := &"FIND"
const PROP := &"PROP"

#const T_INDENT := &"INDENT"
#const T_DEDENT := &"DEDENT"
#const T_NEWLINE := &"NEWLINE"
#const T_COLON := &":"
#const T_LOOP := &"LOOP"
#const T_WAIT := &"WAIT"
#const T_STRING := &"STR"
#const T_BLOCK := &"BLOCK"
#const T_PARALLEL := &"PARALLEL"
#const T_PARALLEL_SHORT := &"PLL"
#const T_ON := &"ON"
#const T_PROPERTIES_TWEENED := &"PROPS_TWEENED"
#const T_PROPERTIES := &"PROPS"
#const T_REL := &"+"
#const T_REL_NEG := &"-"
#const T_REL_RUNTIME := &"!"
#const T_SPACE := &"SPACE"
#
#const T_PASS := &"PASS" # TODO:
#const T_CHOICE := &"CHOICE" # TODO:
#const T_WARP := &"WARP" # TODO:
