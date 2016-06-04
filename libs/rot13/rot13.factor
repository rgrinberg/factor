! Copyright (C) 2006 Daniel Ehrenberg
! See http://factorcode.org/license.txt for BSD license.
USING: kernel math sequences strings io combinators ascii ;
in: rot13

: rotate ( ch base -- ch ) [ - 13 + 26 mod ] [ + ] bi ;

: rot-letter ( ch -- ch )
    {
        { [ dup letter? ] [ char: a rotate ] }
        { [ dup LETTER? ] [ char: A rotate ] }
        [ ]
    } cond ;

: rot13 ( string -- string ) [ rot-letter ] map ;

: rot13-demo ( -- )
    "Please enter a string:" print flush
    readln [
        "Your string: " write dup print
        "Rot13:       " write rot13 print
    ] when* ;

main: rot13-demo
