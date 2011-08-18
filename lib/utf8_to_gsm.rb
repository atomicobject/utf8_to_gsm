#Encoding: UTF-8
require "utf8_to_gsm/version"
require 'rubygems'
require 'unidecoder'

module Utf8ToGsm
	# Mapping of GSM default alphabet to Unicode code points
	# This is only the default GSM alphabet, and does not feature
	# single shift or locking shift tables. Only values which differ
  # between GSM and Unicode are provided.
  # Mapping of values courtesy of Unicode, Inc.
  # http://unicode.org/Public/MAPPINGS/ETSI/GSM0338.TXT
  
	GSM_TO_UNICODE = [
	0x00,	0x40,	 # COMMERCIAL AT	@
	0x01,	0xA3,	 # POUND SIGN	£
	0x02,	0x24,	 # DOLLAR SIGN	$
	0x03,	0xA5,	 # YEN SIGN	¥
	0x04,	0xE8,	 # LATIN SMALL LETTER E WITH GRAVE	è
	0x05,	0xE9,	 # LATIN SMALL LETTER E WITH ACUTE	é
	0x06,	0xF9,	 # LATIN SMALL LETTER U WITH GRAVE	ù
	0x07,	0xEC,	 # LATIN SMALL LETTER I WITH GRAVE	ì
	0x08,	0xF2,	 # LATIN SMALL LETTER O WITH GRAVE	ò
	0x09,	0xE7,	 # LATIN CAPITAL LETTER C WITH CEDILLA	Ç
	0x0B,	0xD8,	 # LATIN CAPITAL LETTER O WITH STROKE	Ø
	0x0C,	0xF8,	 # LATIN SMALL LETTER O WITH STROKE	ø
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
	0x24,	0xA4,	 # CURRENCY SIGN	¤
	0x40,	0xA1,	 # INVERTED EXCLAMATION MARK	¡
	0x5B,	0xC4,	 # LATIN CAPITAL LETTER A WITH DIAERESIS	Ä
	0x5C,	0xD6,	 # LATIN CAPITAL LETTER O WITH DIAERESIS	Ö
	0x5D,	0xD1,	 # LATIN CAPITAL LETTER N WITH TILDE	Ñ
	0x5E,	0xDC,	 # LATIN CAPITAL LETTER U WITH DIAERESIS	Ü
	0x5F,	0xA7,	 # SECTION SIGN	§
	0x60,	0xBF,	 # INVERTED QUESTION MARK	¿
	0x7B,	0xE4,	 # LATIN SMALL LETTER A WITH DIAERESIS	ä
	0x7C,	0xF6,	 # LATIN SMALL LETTER O WITH DIAERESIS	ö
	0x7D,	0xF1,	 # LATIN SMALL LETTER N WITH TILDE	ñ
	0x7E,	0xFC,	 # LATIN SMALL LETTER U WITH DIAERESIS	ü
	0x7F,	0xE0,	 # LATIN SMALL LETTER A WITH GRAVE	à
	]

  # These are for transliterations which are broken or mangled in our transliteration library
  ASCII_TO_UNICODE = [
  [0x3C,0x3C], 0xAB,    # Left Chevron Transliteration is broken in Unidecoder 1.1.1, comment out to use Unidecoder version
  [0x54,0x4D], 0x2122,  # Trademark Transliteration is broken in Unidecoder 1.1.1, comment out to use Unidecoder version
  [0x3F], 0xAF,         # Macron Transliteration is broken in Unidecoder 1.1.1, comment out to use Unidecoder version
  ]

  # Create new hash to hold mappings
	@unicode_to_gsm = {}
  @unicode_to_ascii = {}

  # Place the Unicode to GSM mapping in a hash to make lookup easy
	GSM_TO_UNICODE.each_slice(2){|gsm,unicode|@unicode_to_gsm[unicode] = gsm}
  # Place the Unicode to ASCII mapping in a hash to make lookup easy
  ASCII_TO_UNICODE.each_slice(2){|ascii,unicode|@unicode_to_ascii[unicode] = ascii}

  # Array of the 1-to-1 Unicode to GSM Mappings for fast/easy pass-through without hash lookup
  ONE_TO_ONE = ((0x61..0x7A).to_a + (0x41..0x5A).to_a + (0x25..0x3F).to_a + (0x20..0x23).to_a + [0x1B,0x0A,0x0D])

	def self.to_gsm string 
    # Unpack the string (presumed to be UTF-8) to it's binary value
		string.unpack('U*').collect{|unicode|
      if ONE_TO_ONE.include?(unicode)
        # Check if the binary value for the character is in 'identical' Unicode to GSM ranges
        unicode
      elsif @unicode_to_gsm[unicode].nil?
        # If the Unicode char is not in the GSM mapping, proceed to transliteration

        # Check if the binary value for the character is in the Unicode to ASCII mapping
        # If not, transliterate the given character to ASCII using Unicoder
        # Else, use the ASCII binary value found in the mapping
        ascii = (@unicode_to_ascii[unicode].nil?) ? (Unidecoder.decode([unicode].pack('U*')).unpack('U*')) : (@unicode_to_ascii[unicode])

        # Now that we have the ASCII binary value, try converting it to GSM again (all ASCII maps to GSM)
        gsm = to_gsm(ascii.pack('U*')).unpack('c*')
      else
        # Else, use the GSM binary value found in the mapping
        @unicode_to_gsm[unicode]
      end
    # Take all the binary values, and pack them back up
		}.flatten.pack('c*')
	end
end
