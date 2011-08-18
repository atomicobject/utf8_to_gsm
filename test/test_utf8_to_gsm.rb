#Encoding: UTF-8
require 'test/unit'
require 'utf8_to_gsm'

class Utf8ToGsmTest < Test::Unit::TestCase
	def test_direct_utf8_to_gsm_mappings
		gsm_to_unicode_codepoints= [
			0x00,	0x40,	 # COMMERCIAL AT	@
			0x01,	0xA3,	 # POUND SIGN	£
			0x02,	0x24,	 # DOLLAR SIGN	$
			0x03,	0xA5,	 # YEN SIGN	¥
			0x04,	0xE8,	 # LATIN SMALL LETTER E WITH GRAVE	è
			0x05,	0xE9,	 # LATIN SMALL LETTER E WITH ACUTE	é
			0x06,	0xF9,	 # LATIN SMALL LETTER U WITH GRAVE	ù
			0x07,	0xEC,	 # LATIN SMALL LETTER I WITH GRAVE	ì
			0x08,	0xF2,	 # LATIN SMALL LETTER O WITH GRAVE	ò
			0x09,	0xE7,	 # LATIN SMALL LETTER C WITH CEDILLA	Ç
			0x0A,	0x0A,	 # LINE FEED	
			0x0B,	0xD8,	 # LATIN CAPITAL LETTER O WITH STROKE	Ø
			0x0C,	0xF8,	 # LATIN SMALL LETTER O WITH STROKE	ø
			0x0D,	0x0D,	 # CARRIAGE RETURN	
			0x0E,	0xC5,	 # LATIN CAPITAL LETTER A WITH RING ABOVE	Å
			0x0F,	0xE5,	 # LATIN SMALL LETTER A WITH RING ABOVE	å
			0x10,	0x0394,	 # GREEK CAPITAL LETTER DELTA	Δ
			0x11,	0x5F,	 # LOW LINE	_
			0x12,	0x03A6,	 # GREEK CAPITAL LETTER PHI	Φ
			0x13,	0x0393,	 # GREEK CAPITAL LETTER GAMMA	Γ
			0x14,	0x039B,	 # GREEK CAPITAL LETTER LAMBDA	Λ
			0x15,	0x03A9,	 # GREEK CAPITAL LETTER OMEGA	Ω
			0x16,	0x03A0,	 # GREEK CAPITAL LETTER PI	Π
			0x17,	0x03A8,	 # GREEK CAPITAL LETTER PSI	Ψ
			0x18,	0x03A3,	 # GREEK CAPITAL LETTER SIGMA	Σ
			0x19,	0x0398,	 # GREEK CAPITAL LETTER THETA	Θ
			0x1A,	0x039E,	 # GREEK CAPITAL LETTER XI	Ξ
			0x1B,	0x1B,	 # ESCAPE TO EXTENSION TABLE	
			[0x1B, 0x0A],	0x0C,	 # FORM FEED	
			[0x1B, 0x14],	0x5E,	 # CIRCUMFLEX ACCENT	^
			[0x1B, 0x28],	0x7B,	 # LEFT CURLY BRACKET	{
			[0x1B, 0x29],	0x7D,	 # RIGHT CURLY BRACKET	}
			[0x1B, 0x2F],	0x5C,	 # REVERSE SOLIDUS (BACKSLASH)	\
			[0x1B, 0x3C],	0x5B,	 # LEFT SQUARE BRACKET	[
			[0x1B, 0x3D],	0x7E,	 # TILDE	~
			[0x1B, 0x3E],	0x5D,	 # RIGHT SQUARE BRACKET	]
			[0x1B, 0x40],	0x7C,	 # VERTICAL BAR	|
			[0x1B, 0x65],	0x20AC,	 # EURO SIGN	€
			0x1C,	0xC6,	 # LATIN CAPITAL LETTER AE	Æ
			0x1D,	0xE6,	 # LATIN SMALL LETTER AE	æ
			0x1E,	0xDF,	 # LATIN SMALL LETTER SHARP S	ß
			0x1F,	0xC9,	 # LATIN CAPITAL LETTER E WITH ACUTE	É
			0x20,	0x20,	 # SPACE	
			0x21,	0x21,	 # EXCLAMATION MARK	!
			0x22,	0x22,	 # QUOTATION MARK	"
			0x23,	0x23,	 # NUMBER SIGN	#
			0x24,	0xA4,	 # CURRENCY SIGN	¤
			0x25,	0x25,	 # PERCENT SIGN	%
			0x26,	0x26,	 # AMPERSAND	&
			0x27,	0x27,	 # APOSTROPHE	'
			0x28,	0x28,	 # LEFT PARENTHESIS	(
			0x29,	0x29,	 # RIGHT PARENTHESIS	)
			0x2A,	0x2A,	 # ASTERISK	*
			0x2B,	0x2B,	 # PLUS SIGN	+
			0x2C,	0x2C,	 # COMMA	,
			0x2D,	0x2D,	 # HYPHEN-MINUS	-
			0x2E,	0x2E,	 # FULL STOP	.
			0x2F,	0x2F,	 # SOLIDUS (SLASH)	/
			0x30,	0x30,	 # DIGIT ZERO	0
			0x31,	0x31,	 # DIGIT ONE	1
			0x32,	0x32,	 # DIGIT TWO	2
			0x33,	0x33,	 # DIGIT THREE	3
			0x34,	0x34,	 # DIGIT FOUR	4
			0x35,	0x35,	 # DIGIT FIVE	5
			0x36,	0x36,	 # DIGIT SIX	6
			0x37,	0x37,	 # DIGIT SEVEN	7
			0x38,	0x38,	 # DIGIT EIGHT	8
			0x39,	0x39,	 # DIGIT NINE	9
			0x3A,	0x3A,	 # COLON	:
			0x3B,	0x3B,	 # SEMICOLON	;
			0x3C,	0x3C,	 # LESS-THAN SIGN	<
			0x3D,	0x3D,	 # EQUALS SIGN	=
			0x3E,	0x3E,	 # GREATER-THAN SIGN	>
			0x3F,	0x3F,	 # QUESTION MARK	?
			0x40,	0xA1,	 # INVERTED EXCLAMATION MARK	¡
			0x41,	0x41,	 # LATIN CAPITAL LETTER A	A
			0x42,	0x42,	 # LATIN CAPITAL LETTER B	B
			0x43,	0x43,	 # LATIN CAPITAL LETTER C	C
			0x44,	0x44,	 # LATIN CAPITAL LETTER D	D
			0x45,	0x45,	 # LATIN CAPITAL LETTER E	E
			0x46,	0x46,	 # LATIN CAPITAL LETTER F	F
			0x47,	0x47,	 # LATIN CAPITAL LETTER G	G
			0x48,	0x48,	 # LATIN CAPITAL LETTER H	H
			0x49,	0x49,	 # LATIN CAPITAL LETTER I	I
			0x4A,	0x4A,	 # LATIN CAPITAL LETTER J	J
			0x4B,	0x4B,	 # LATIN CAPITAL LETTER K	K
			0x4C,	0x4C,	 # LATIN CAPITAL LETTER L	L
			0x4D,	0x4D,	 # LATIN CAPITAL LETTER M	M
			0x4E,	0x4E,	 # LATIN CAPITAL LETTER N	N
			0x4F,	0x4F,	 # LATIN CAPITAL LETTER O	O
			0x50,	0x50,	 # LATIN CAPITAL LETTER P	P
			0x51,	0x51,	 # LATIN CAPITAL LETTER Q	Q
			0x52,	0x52,	 # LATIN CAPITAL LETTER R	R
			0x53,	0x53,	 # LATIN CAPITAL LETTER S	S
			0x54,	0x54,	 # LATIN CAPITAL LETTER T	T
			0x55,	0x55,	 # LATIN CAPITAL LETTER U	U
			0x56,	0x56,	 # LATIN CAPITAL LETTER V	V
			0x57,	0x57,	 # LATIN CAPITAL LETTER W	W
			0x58,	0x58,	 # LATIN CAPITAL LETTER X	X
			0x59,	0x59,	 # LATIN CAPITAL LETTER Y	Y
			0x5A,	0x5A,	 # LATIN CAPITAL LETTER Z	Z
			0x5B,	0xC4,	 # LATIN CAPITAL LETTER A WITH DIAERESIS	Ä
			0x5C,	0xD6,	 # LATIN CAPITAL LETTER O WITH DIAERESIS	Ö
			0x5D,	0xD1,	 # LATIN CAPITAL LETTER N WITH TILDE	Ñ
			0x5E,	0xDC,	 # LATIN CAPITAL LETTER U WITH DIAERESIS	Ü
			0x5F,	0xA7,	 # SECTION SIGN	§
			0x60,	0xBF,	 # INVERTED QUESTION MARK	¿
			0x61,	0x61,	 # LATIN SMALL LETTER A	a
			0x62,	0x62,	 # LATIN SMALL LETTER B	b
			0x63,	0x63,	 # LATIN SMALL LETTER C	c
			0x64,	0x64,	 # LATIN SMALL LETTER D	d
			0x65,	0x65,	 # LATIN SMALL LETTER E	e
			0x66,	0x66,	 # LATIN SMALL LETTER F	f
			0x67,	0x67,	 # LATIN SMALL LETTER G	g
			0x68,	0x68,	 # LATIN SMALL LETTER H	h
			0x69,	0x69,	 # LATIN SMALL LETTER I	i
			0x6A,	0x6A,	 # LATIN SMALL LETTER J	j
			0x6B,	0x6B,	 # LATIN SMALL LETTER K	k
			0x6C,	0x6C,	 # LATIN SMALL LETTER L	l
			0x6D,	0x6D,	 # LATIN SMALL LETTER M	m
			0x6E,	0x6E,	 # LATIN SMALL LETTER N	n
			0x6F,	0x6F,	 # LATIN SMALL LETTER O	o
			0x70,	0x70,	 # LATIN SMALL LETTER P	p
			0x71,	0x71,	 # LATIN SMALL LETTER Q	q
			0x72,	0x72,	 # LATIN SMALL LETTER R	r
			0x73,	0x73,	 # LATIN SMALL LETTER S	s
			0x74,	0x74,	 # LATIN SMALL LETTER T	t
			0x75,	0x75,	 # LATIN SMALL LETTER U	u
			0x76,	0x76,	 # LATIN SMALL LETTER V	v
			0x77,	0x77,	 # LATIN SMALL LETTER W	w
			0x78,	0x78,	 # LATIN SMALL LETTER X	x
			0x79,	0x79,	 # LATIN SMALL LETTER Y	y
			0x7A,	0x7A,	 # LATIN SMALL LETTER Z	z
			0x7B,	0xE4,	 # LATIN SMALL LETTER A WITH DIAERESIS	ä
			0x7C,	0xF6,	 # LATIN SMALL LETTER O WITH DIAERESIS	ö
			0x7D,	0xF1,	 # LATIN SMALL LETTER N WITH TILDE	ñ
			0x7E,	0xFC,	 # LATIN SMALL LETTER U WITH DIAERESIS	ü
			0x7F,	0xE0,	 # LATIN SMALL LETTER A WITH GRAVE	à
		]
		@unicode_to_gsm = {}
		gsm_to_unicode_codepoints.each_slice(2){|gsm,unicode|@unicode_to_gsm[unicode] = gsm}
		@unicode_to_gsm.each_pair do |utf,gsm|
			assert_equal [gsm].flatten.pack('c*'),Utf8ToGsm.to_gsm([utf].flatten.pack('U*'))
		end
	end

	def test_portuguese_characters
    # Make sure our Portuguese specific characters work
		transliterations = [
			"Á", 0x41,
			"Â", 0x41,
			"Ã", 0x41,
			"À", 0x41,
			"Ç", 0x43,
			"É", 0x1F,
			"Ê", 0x45,
			"Í", 0x49,
			"Ó", 0x4F,
			"Ô", 0x4F,
			"Õ", 0x4F,
			"Ú", 0x55,
			"á", 0x61,
			"â", 0x61,
			"ã", 0x61,
			"à", 0x7F,
			"ç", 0x09,
			"é", 0x05,
			"ê", 0x65,
			"í", 0x69,
			"ó", 0x6F,
			"ô", 0x6F,
			"õ", 0x6F,
			"ú", 0x75,
			"º", 0x6F,
			"ª", 0x61,
			"«", [0x3C,0x3C],
			"»", [0x3E,0x3E],
			"€", [0x1B, 0x65],
		]
		transliterations.each_slice(2) do |utf,gsm|
			assert_equal [gsm].flatten, Utf8ToGsm.to_gsm(utf).unpack("c*")
		end
	end

	def test_spanish_characters
    # Make sure our Spanish specific characters work
		transliterations = [
			"Á", 0x41,
			"É", 0x1F,
			"Í", 0x49,
			"Ó", 0x4F,
			"Ú", 0x55,
			"Ñ", 0x5D,
			"Ü", 0x5E,
			"á", 0x61,
			"é", 0x05,
			"í", 0x69,
			"ó", 0x6F,
			"ú", 0x75,
			"ñ", 0x7D,
			"ü", 0x7E,
			"¿", 0x60,
			"¡", 0x40,
			"º", 0x6F,
			"ª", 0x61,
			"«", [0x3C,0x3C], 
			"»", [0x3E,0x3E],
			"‹", 0x3C,
			"›", 0x3E,
			"€", [0x1B, 0x65],
		]
		transliterations.each_slice(2) do |utf,gsm|
			assert_equal [gsm].flatten, Utf8ToGsm.to_gsm(utf).unpack("c*")
		end
	end

	def test_french_characters
    # Make sure our French specific characters work
		transliterations = [
			"À", 0x41,
			"Â", 0x41,
			"Ä", 0x5B,
			"È", 0x45,
			"É", 0x1F,
			"Ê", 0x45,
			"Ë", 0x45,
			"Î", 0x49,
			"Ï", 0x49,
			"Ô", 0x4F,
			"Œ", [0x4F,0x45],
			"Ù", 0x55,
			"Û", 0x55,
			"Ü", 0x5E,
			"Ÿ", 0x59,
			"à", 0x7F,
			"â", 0x61,
			"ä", 0x7B,
			"è", 0x04,
			"é", 0x05,
			"ê", 0x65,
			"ë", 0x65,
			"î", 0x69,
			"ï", 0x69,
			"ô", 0x6F,
			"œ", [0x6F,0x65],
			"ù", 0x06,
			"û", 0x75,
			"ü", 0x7E,
			"ÿ", 0x79,
			"Ç", 0x43,
			"ç", 0x09,
			"«", [0x3C,0x3C],
			"»", [0x3E,0x3E],
			"€", [0x1B, 0x65],
		]
		transliterations.each_slice(2) do |utf,gsm|
			assert_equal [gsm].flatten, Utf8ToGsm.to_gsm(utf).unpack("c*")
		end
	end

	def test_punctuation_characters
    # Make sure our punctuation characters work
		transliterations = [
			"!", 0x21,
			"@", 0x00,
			"#", 0x23,
			"$", 0x02,
			"%", 0x25,
			"^", [0x1B,0x14],
			"&", 0x26,
			"*", 0x2A,
			"(", 0x28,
			")", 0x29,
			"-", 0x2D,
			"_", 0x11,
			"=", 0x3d,
			"+", 0x2b,
			"[", [0x1B,0x3C],
			"{", [0x1B,0x28],
			"]", [0x1B,0x3E],
			"}", [0x1B,0x29],
			"\\", [0x1B,0x2F], # Escape the escape character
			"|", [0x1b,0x40],
			";", 0x3B,
			":", 0x3A,
			"'", 0x27,
			'"', 0x22,
			",", 0x2C,
			"<", 0x3C,
			".", 0x2E,
			">", 0x3E,
			"/", 0x2F,
			"?", 0x3F,
		]
		transliterations.each_slice(2) do |utf,gsm|
			assert_equal [gsm].flatten, Utf8ToGsm.to_gsm(utf).unpack("c*")
		end
	end

  def test_other_utf8_characters
    # Make sure a host of other UTF-8 characters work
    transliterations = [
      "¡", 0x40,
      "¢", [0x43,0x2F],
      "£", 0x01,
      "¤", 0x24,
      "¥", 0x03,
      "¦", [0x1B,0x40],
      "§", 0x5F,
      "¨", 0x22,
      "©", [0x28,0x63,0x29],
      "ª", 0x61,
      "«", [0x3C,0x3C], 
      "¬", 0x21,
      "®", [0x28,0x72,0x29],
      "¯", 0x3F,
      "°", [0x64,0x65,0x67],
      "±", [0x2B,0x2D],
      "²", 0x32,
      "³", 0x33,
      "´", 0x27,
      "µ", 0x75,
      "¶", 0x50,
      "·", 0x3B,
      "¸", 0x2C,
      "¹", 0x31,
      "º", 0x6F,
      "»", [0x3E,0x3E],
      "¼", [0x31,0x2F,0x34],
      "½", [0x31,0x2F,0x32],
      "¾", [0x33,0x2F,0x34],
      "¿", 0x60,
      "À", 0x41,
      "Á", 0x41,
      "Â", 0x41,
      "Ã", 0x41,
      "Ä", 0x5B,
      "Å", 0x0E,
      "Æ", 0x1C,
      "Ç", 0x43,
      "È", 0x45,
      "É", 0x1F,
      "Ê", 0x45,
      "Ë", 0x45,
      "Ì", 0x49,
      "Í", 0x49,
      "Î", 0x49,
      "Ï", 0x49,
      "Ð", 0x44,
      "Ñ", 0x5D,
      "Ò", 0x4F,
      "Ó", 0x4F,
      "Ô", 0x4F,
      "Õ", 0x4F,
      "Ö", 0x5C,
      "×", 0x78,
      "Ø", 0x0B,
      "Ù", 0x55,
      "Ú", 0x55,
      "Û", 0x55,
      "Ü", 0x5E,
      "Ý", 0x59,
      "Þ", [0x54,0x68],
      "ß", 0x1E,
      "à", 0x7F,
      "á", 0x61,
      "â", 0x61,
      "ã", 0x61,
      "ä", 0x7B,
      "å", 0x0F,
      "æ", 0x1D,
      "ç", 0x09,
      "è", 0x04,
      "é", 0x05,
      "ê", 0x65,
      "ë", 0x65,
      "ì", 0x07,
      "í", 0x69,
      "î", 0x69,
      "ï", 0x69,
      "ð", 0x64,
      "ñ", 0x7D,
      "ò", 0x08,
      "ó", 0x6F,
      "ô", 0x6F,
      "õ", 0x6F,
      "ö", 0x7C,
      "÷", 0x2F,
      "ø", 0x0C,
      "ù", 0x06,
      "ú", 0x75,
      "û", 0x75,
      "ü", 0x7E,
      "ý", 0x79,
      "þ", [0x74,0x68],
      "ÿ", 0x79,
      "™", [0x54,0x4D],
    ]
		transliterations.each_slice(2) do |utf,gsm|
			assert_equal [gsm].flatten, Utf8ToGsm.to_gsm(utf).unpack("c*")
		end
  end
end
