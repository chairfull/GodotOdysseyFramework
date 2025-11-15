class_name Astrology extends RefCounted

enum Planet { SUN, MOON, MARS, MERCURY, JUPITER, VENUS, SATURN }
enum Horoscope { ARIES, TAURUS, GEMINI, CANCER, LEO, VIRGO, LIBRA, SCORPIUS, SAGITARIUS, CAPRICORN, AQUARIUS, PISCES, OPHIUCHUS }
enum Zodiac { RAT, OX, TIGER, RABBIT, DRAGON, SNAKE, HORSE, GOAT, MONKEY, ROOSTER, DOG, PIG }

const HOROSCOPE_UNICODE := [0x2648, 0x2649, 0x264A, 0x264B, 0x264C, 0x264D, 0x264E, 0x264F, 0x2650, 0x2651, 0x2652, 0x2653, 0x26CE]
const ANIMAL_UNICODE := ["子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"]
const ANIMAL_EMOJI := "🐀🐂🐅🐇🐉🐍🐎🐐🐒🐓🐕🐖"

static func get_horoscope(month: DateTime.Month, day: int) -> Horoscope:
	const c := [[9, 19, 10], [10, 18, 11], [11, 20, 0], [0, 19, 1], [1, 20, 2], [2, 20, 3], [3, 22, 4], [4, 22, 5], [5, 22, 6], [6, 22, 7], [7, 21, 8], [8, 21, 9]]
	var h = c[month]
	return h[0] if day <= h[1] else h[2]

static func get_horoscope_unicode(month: DateTime.Month, day: int) -> String:
	return char(HOROSCOPE_UNICODE[get_horoscope(month, day)])

static func get_horoscope_name(month: DateTime.Month, day: int) -> String:
	return Horoscope.keys()[get_horoscope(month, day)]

static func get_zodiac(year: int) -> Zodiac:
	return wrapi(year - 4, 0, 12)

static func get_zodiac_name(year: int) -> String:
	return Zodiac.keys()[get_zodiac(year)]

static func get_zodiac_unicode(year: int) -> String:
	return ANIMAL_UNICODE[get_zodiac(year)]

static func get_zodiac_emoji(year: int) -> String:
	return ANIMAL_EMOJI[get_zodiac(year)]
