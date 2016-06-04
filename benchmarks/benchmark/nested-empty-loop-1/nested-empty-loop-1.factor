! Copyright (C) 2008 Slava Pestov.
! See http://factorcode.org/license.txt for BSD license.
USING: math locals hints ;
in: benchmark.nested-empty-loop-1

:: nested-empty-loop ( n -- )
    n [
        n [
            n [
                n [
                    n [
                        n [
                            n [
                                n [
                                    n [ ] times
                                ] times
                            ] times
                        ] times
                    ] times
                ] times
            ] times
        ] times
    ] times ;

HINTS: nested-empty-loop fixnum ;

: nested-empty-loop-1-benchmark ( -- ) 7 nested-empty-loop ;

main: nested-empty-loop-1-benchmark
