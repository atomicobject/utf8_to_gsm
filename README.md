Description
===========
`Utf8ToGsm.to_gsm` provides functionality to convert UTF-8 characters (in a string) to their GSM equivalents for sending SMS messages via SMPP.

Examples
--------

    require 'utf8_to_gsm'
    Utf8ToGsm.to_gsm('Convert to GSM: !@#$%^&*()')
    => "Convert to GSM: !\x00#\x02%\e\x14&*()" 

Usage
-----

Provide `Utf8ToGsm.to_gsm` a UTF-8 string that you would like to convert into a GSM-compatible string.

`Utf8ToGsm` will go through each character in the string:
* If the character has an exact GSM equivalent, it will be used.
* Otherwise, the UTF-8 character is transliterated to ASCII.
* If no suitable character(s) is available in ASCII, a replacement symbol (question mark: ?) will be used.
* Once transliterated to ASCII, the character(s) will be converted to its GSM equivalent. (All ASCII characters are represented in GSM.)

Implementation
--------------
Any given UTF-8 character(s) that does not exist in the GSM alphabet is transliterated with the help of `unidecoder` to ASCII.

`unidecoder` is used so that `Utf8ToGsm` can work with Ruby 1.8.7. Much of the functionality of `unidecoder` is provided by Ruby 1.9.2.  However... the need at the time of writing was Ruby 1.8.7.

Motivation
----------

* `Utf8ToGsm` may be useful for people who need to send SMS messages via SMPP directly to an SMSC using the GSM-7 encoding ("Default SMSC Alphabet"), data_coding = 0x00.
* Transliteration used by this library is meant to provide the best possible ASCII replacement that is available for the given UTF-8 characters. It may be helpful to review the readme from [unicoder](https://github.com/norman/unidecoder/blob/master/README.md).
* Clearly, transliteration is not ideal.  However, the GSM-7 default alphabet ("Default SMSC Alphabet") only allows a total of 127 characters, and so a very limited character repertoire is available.
* It is presumed that providing the closest possible replacement is better than providing nothing at all.
* For example, if a user tries to send an SMS message via SMPP containing the character "À", there is a problem.  "À" does not exist in the GSM-7 default alphabet. Sending "A" as a replacement instead of "?" is probably more helpful to the recipient.
* For a truly accurate representation, UTF-16 or UCS-2 should generally be used for transmitting the payload of an SMPP PDU to the SMSC when non-GSM characters are being communicated.  However, not all telcos or SMSC's support UTF-16/UCS-16.
* Theoretically, GSM locking shift tables and GSM single shift tables should be usable to represent characters outside of the GSM-7 default alphabet.  However, it seems that telco support for this (especially via SMPP) is very limited.

Authors
=======
* Justin Kulesza (kulesza@atomicobject.com)

© 2011 [Atomic Object](http://www.atomicobject.com/)

More Atomic Object [open source](http://www.atomicobject.com/pages/Software+Commons) projects
