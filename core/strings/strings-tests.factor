USING: arrays continuations io.streams.null kernel
kernel.private literals make math math.order memory namespaces
prettyprint sbufs sequences strings strings.private tools.test
vectors ;

{ char: b } [ 1 >bignum "abc" nth ] unit-test

{ } [ 10 [ [ -1000000 <sbuf> ] ignore-errors ] times ] unit-test

{ "abc" } [ [ "a" "b" "c" ] [ [ % ] each ] "" make ] unit-test

{ "abc" } [ "ab" "c" append ] unit-test
{ "abc" } [ "a" "b" "c" 3append ] unit-test

{ 3 } [ "a" "hola" start ] unit-test
{ f } [ "x" "hola" start ] unit-test
{ 0 } [ "" "a" start ] unit-test
{ 0 } [ "" "" start ] unit-test
{ 0 } [ "hola" "hola" start ] unit-test
{ 1 } [ "ol" "hola" start ] unit-test
{ f } [ "amigo" "hola" start ] unit-test
{ f } [ "holaa" "hola" start ] unit-test

{ "Beginning" } [ "Beginning and end" 9 head ] unit-test

{ f } [ char: I "team" member? ] unit-test
{ t } [ "ea" "team" subseq? ] unit-test
{ f } [ "actore" "Factor" subseq? ] unit-test

{ "end" } [ "Beginning and end" 14 tail ] unit-test

{ t } [ "abc" "abd" before? ] unit-test
{ t } [ "z" "abd" after? ] unit-test
{ "abc" } [ "abc" "abd" min ] unit-test
{ "z" } [ "z" "abd" max ] unit-test

[ 0 10 "hello" subseq ] must-fail

{ "Replacing+spaces+with+plus" }
[
    "Replacing spaces with plus"
    [ dup char: \s = [ drop char: + ] when ] map
]
unit-test

{ "05" } [ "5" 2 char: 0 pad-head ] unit-test
{ "666" } [ "666" 2 char: 0 pad-head ] unit-test

[ 1 "" nth ] must-fail
[ -6 "hello" nth ] must-fail

{ t } [ "hello world" dup >vector >string = ] unit-test

{ "ab" } [ 2 "abc" resize-string ] unit-test
{ "abc\0\0\0" } [ 6 "abc" resize-string ] unit-test

{ "\u001234b" } [ 2 "\u001234bc" resize-string ] unit-test
{ "\u001234bc\0\0\0" } [ 6 "\u001234bc" resize-string ] unit-test

! Random tester found this
[ 2 -7 resize-string ]
[ ${ KERNEL-ERROR ERROR-TYPE 11 -7 } = ] must-fail-with

! Make sure 24-bit strings work
"hello world" "s" set

{ } [ 0x1234 1 "s" get set-nth ] unit-test
{ 0x1234 } [ 1 "s" get nth ] unit-test

{ } [ 0x4321 3 "s" get set-nth ] unit-test
{ 0x4321 } [ 3 "s" get nth ] unit-test

{ } [ 0x654321 5 "s" get set-nth ] unit-test
{ 0x654321 } [ 5 "s" get nth ] unit-test

{
    {
        char: h
        0x1234
        char: l
        0x4321
        char: o
        0x654321
        char: w
        char: o
        char: r
        char: l
        char: d
    }
} [
    "s" get >array
] unit-test

! Make sure string initialization works
{ 0x123456 } [ 100 0x123456 <string> first ] unit-test

! Make sure we clear aux vector when storing octets
{ "\u123456hi" } [ "ih\u123456" clone reverse! ] unit-test

! Make sure aux vector is not shared
{ "\udeadbe" } [
    "\udeadbe" clone
    char: \u123456 over clone set-first
] unit-test

! Regressions
{ } [
    [
        4 [
            100 [ "obdurak" clone ] replicate
            gc
            dup [
                1234 0 rot set-string-nth
            ] each
            1000 [
                1000 f <array> drop
            ] times
            .
        ] times
    ] with-null-writer
] unit-test

{ t } [
    10000 [
        drop
        300 100 char: \u123456
        [ <string> clone resize-string first ] keep =
    ] all-integers?
] unit-test

"X" "s" set
{ } [ 0x100,0000 0 "s" get set-nth ] unit-test
{ 0 } [ 0 "s" get nth ] unit-test

{ } [ -1 0 "s" get set-nth ] unit-test
{ 0x7fffff } [ 0 "s" get nth ] unit-test
