! (c)2011 Joe Groff bsd license
USING: alien.data destructors io io.streams.memory kernel libc
tools.test ;
in: io.streams.memory.tests

{ 1 2 3 } [
    B{ 1 2 3 } <memory-stream>
    [ stream-read1 ] [ stream-read1 ] [ stream-read1 ] tri
] unit-test

{ 1 2 3 } [
    [
        B{ 1 2 3 } malloc-byte-array &free <memory-stream>
        [ stream-read1 ] [ stream-read1 ] [ stream-read1 ] tri
    ] with-destructors
] unit-test

{ B{ 1 2 3 } B{ 4 5 6 7 8 } } [
    B{ 1 2 3 4 5 6 7 8 } <memory-stream>
    [ 3 swap stream-read ] [ 5 swap stream-read ] bi
] unit-test

{ B{ 1 2 3 } B{ 4 5 6 7 8 } } [
    [
        B{ 1 2 3 4 5 6 7 8 } malloc-byte-array &free <memory-stream>
        [ 3 swap stream-read ] [ 5 swap stream-read ] bi
    ] with-destructors
] unit-test
