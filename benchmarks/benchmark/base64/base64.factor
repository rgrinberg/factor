! Copyright (C) 2008 Slava Pestov.
! See http://factorcode.org/license.txt for BSD license.
USING: math sequences kernel base64 ;
in: benchmark.base64

: base64-benchmark ( -- )
    65535 iota [ 255 bitand ] "" map-as
    20 [ >base64 base64> ] times
    drop ;

main: base64-benchmark
