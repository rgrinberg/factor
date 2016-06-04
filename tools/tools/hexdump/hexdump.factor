! Copyright (C) 2008 Doug Coleman.
! See http://factorcode.org/license.txt for BSD license.
USING: arrays ascii byte-arrays byte-vectors command-line
grouping io io.encodings.binary io.files io.streams.string
kernel math math.parser namespaces sequences splitting strings ;
in: tools.hexdump

<PRIVATE

: write-header ( len -- )
    "Length: " write
    [ number>string write ", " write ]
    [ >hex write "h" write nl ] bi ;

: write-offset ( lineno -- )
    16 * >hex 8 char: 0 pad-head write "h: " write ;

: >hex-digit ( digit -- str )
    >hex 2 char: 0 pad-head ;

: >hex-digits ( bytes -- str )
    [ >hex-digit " " append ] { } map-as concat
    48 char: \s pad-tail ;

: >ascii ( bytes -- str )
    [ [ printable? ] keep char: . ? ] "" map-as ;

: write-hex-line ( bytes lineno -- )
    write-offset [ >hex-digits write ] [ >ascii write ] bi nl ;

: hexdump-bytes ( bytes -- )
    [ length write-header ]
    [ 16 <groups> [ write-hex-line ] each-index ] bi ;

PRIVATE>

GENERIC: hexdump. ( byte-array -- ) ;

M: byte-array hexdump. hexdump-bytes ;

M: byte-vector hexdump. hexdump-bytes ;

: hexdump ( byte-array -- str )
    [ hexdump. ] with-string-writer ;

: hexdump-file ( path -- )
    binary file-contents hexdump. ;

: hexdump-main ( -- )
    command-line get [ hexdump-file ] each ;

main: hexdump-main
