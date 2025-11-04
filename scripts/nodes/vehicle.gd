class_name Vehicle extends Pawn

var brake := false ## 
var move := Vector2.ZERO ## X=throttle (forward/backward), Y=steering (left/right)
var throttle: float:
	get: return move.y
	set(t): move.y = t
var steering: float:
	get: return move.x
	set(s): move.x = s
