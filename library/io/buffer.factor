! Copyright (C) 2004, 2005 Mackenzie Straight.
! See http://factor.sf.net/license.txt for BSD license.
IN: io-internals
USING: alien errors kernel kernel-internals math strings ;

TUPLE: buffer size ptr fill pos ;

: imalloc ( size -- address )
    "int" "libc" "malloc" [ "ulong" ] alien-invoke ;

: ifree ( address -- )
    "void" "libc" "free" [ "ulong" ] alien-invoke ;

: irealloc ( address size -- address )
    "int" "libc" "realloc" [ "ulong" "ulong" ] alien-invoke ;

: imemcpy ( dst src size -- )
    "void" "libc" "memcpy" [ "ulong" "ulong" "ulong" ] alien-invoke ;

C: buffer ( size -- buffer )
    2dup set-buffer-size
    swap imalloc swap [ set-buffer-ptr ] keep
    0 swap [ set-buffer-fill ] keep
    0 swap [ set-buffer-pos ] keep ;

: buffer-free ( buffer -- )
    #! Frees the C memory associated with the buffer.
    dup buffer-ptr ifree  0 swap set-buffer-ptr ;

: buffer-contents ( buffer -- string )
    #! Returns the current contents of the buffer.
    dup buffer-ptr over buffer-pos +
    over buffer-fill rot buffer-pos - memory>string ;

: buffer-reset ( count buffer -- )
    #! Reset the position to 0 and the fill pointer to count.
    [ set-buffer-fill ] keep 0 swap set-buffer-pos ;

: buffer-consume ( count buffer -- )
    #! Consume count characters from the beginning of the buffer.
    [ buffer-pos + ] keep
    [ buffer-fill min ] keep
    [ set-buffer-pos ] keep
    dup buffer-pos over buffer-fill = [
        [ 0 swap set-buffer-pos ] keep
        [ 0 swap set-buffer-fill ] keep
    ] when drop ;

: buffer@ ( buffer -- int ) dup buffer-ptr swap buffer-pos + ;

: buffer-first-n ( count buffer -- string )
    [ dup buffer-fill swap buffer-pos - min ] keep
    buffer@ swap memory>string ;

: buffer> ( count buffer -- string )
    [ buffer-first-n ] 2keep buffer-consume ;

: buffer>> ( buffer -- string )
    [ buffer-contents ] keep 0 swap buffer-reset ;

: buffer-length ( buffer -- length )
    #! Returns the amount of unconsumed input in the buffer.
    dup buffer-fill swap buffer-pos - ;

: buffer-capacity ( buffer -- int )
    #! Returns the amount of data that may be added to the buffer.
    dup buffer-size swap buffer-fill - ;

: check-overflow ( string buffer -- )
    buffer-capacity swap string-length < [
        "Buffer overflow" throw
    ] when ;

: >buffer ( string buffer -- )
    2dup check-overflow
    [ dup buffer-ptr swap buffer-fill + string>memory ] 2keep
    [ buffer-fill swap string-length + ] keep set-buffer-fill ;

: buffer-extend ( length buffer -- )
    #! Increases the size of the buffer by length.
    [ buffer-size + dup ] keep [ buffer-ptr swap ] keep
    >r irealloc r>
    [ set-buffer-ptr ] keep set-buffer-size ;

: n>buffer ( count buffer -- )
    #! Increases the fill pointer by count.
    [ buffer-fill + ] keep set-buffer-fill ;

: buffer-end ( buffer -- int ) dup buffer-ptr swap buffer-fill + ;

: buffer-pop ( buffer -- char )
    [ buffer@ <alien> 0 alien-unsigned-1  1 ] keep
    buffer-consume ;

: buffer-append ( buffer buffer -- )
    #! Append first buffer to second buffer.
    2dup buffer-end over buffer-ptr rot buffer-fill imemcpy
    >r buffer-fill r> n>buffer ;

: buffer-set ( string buffer -- )
    2dup buffer-ptr string>memory
    >r string-length r> buffer-reset ;

: string>buffer ( string - -buffer )
    dup string-length <buffer> tuck buffer-set ;
