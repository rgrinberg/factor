! Copyright (C) 2009 Daniel Ehrenberg.
! See http://factorcode.org/license.txt for BSD license.
USING: kernel tools.test io.encodings.utf32 arrays sbufs
io.streams.byte-array sequences io.encodings io strings
io.encodings.string alien.c-types alien.strings accessors classes ;
in: io.encodings.utf32.tests

{ { char: x } } [ B{ 0 0 0 char: x } utf32be decode >array ] unit-test
{ { 0x1D11E } } [ B{ 0 1 0xD1 0x1E } utf32be decode >array ] unit-test
{ { char: replacement-character } } [ B{ 0 1 0xD1 } utf32be decode >array ] unit-test
{ { char: replacement-character } } [ B{ 0 1 } utf32be decode >array ] unit-test
{ { char: replacement-character } } [ B{ 0 } utf32be decode >array ] unit-test
{ { } } [ { } utf32be decode >array ] unit-test

{ B{ 0 0 0 char: x 0 1 0xD1 0x1E } } [ { char: x 0x1d11e } >string utf32be encode ] unit-test

{ { char: x } } [ B{ char: x 0 0 0 } utf32le decode >array ] unit-test
{ { 0x1d11e } } [ B{ 0x1e 0xd1 1 0 } utf32le decode >array ] unit-test
{ { char: replacement-character } } [ B{ 0x1e 0xd1 1 } utf32le decode >array ] unit-test
{ { char: replacement-character } } [ B{ 0x1e 0xd1 } utf32le decode >array ] unit-test
{ { char: replacement-character } } [ B{ 0x1e } utf32le decode >array ] unit-test
{ { } } [ { } utf32le decode >array ] unit-test

{ B{ 120 0 0 0 0x1e 0xd1 1 0 } } [ { char: x 0x1d11e } >string utf32le encode ] unit-test

{ { char: x } } [ B{ 0xff 0xfe 0 0 char: x 0 0 0 } utf32 decode >array ] unit-test
{ { char: x } } [ B{ 0 0 0xfe 0xff 0 0 0 char: x } utf32 decode >array ] unit-test

{ B{ 0xff 0xfe 0 0 120 0 0 0 0x1e 0xd1 1 0 } } [ { char: x 0x1d11e } >string utf32 encode ] unit-test
