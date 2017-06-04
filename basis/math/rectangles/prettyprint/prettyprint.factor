! Copyright (C) 2009, 2010 Slava Pestov.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors math.rectangles kernel prettyprint.custom prettyprint.backend ;
IN: math.rectangles.prettyprint

M: rect pprint*
    [
        \ rect: [
            [ loc>> ] [ dim>> ] bi [ pprint* ] bi@
        ] pprint-prefix
    ] check-recursion ;
