USING: accessors arrays compiler.units definitions eval generic
io.streams.string kernel math namespaces parser sequences
tools.test vocabs words words.symbol ;
in: words.tests

{ 4 } [
    [
        "poo" "words.tests" create-word [ 2 2 + ] ( -- n ) define-declared
    ] with-compilation-unit
    "poo" "words.tests" lookup-word execute
] unit-test

{ t } [ t loaded-vocab-names [ vocab-words [ word? and ] each ] each ] unit-test

defer: plist-test

{ t } [
    \ plist-test t "sample-property" set-word-prop
    \ plist-test "sample-property" word-prop
] unit-test

{ f } [
    \ plist-test f "sample-property" set-word-prop
    \ plist-test "sample-property" word-prop
] unit-test

{ } [ [ "create-test" "scratchpad" create-word { 1 2 } "testing" set-word-prop ] with-compilation-unit ] unit-test

{ { 1 2 } } [
    "create-test" "scratchpad" lookup-word "testing" word-prop
] unit-test

H{ } clone [
    [ t ] [ \ array? "array?" "arrays" lookup-word = ] unit-test

    [ ] [ [ "test-scope" "scratchpad" create-word drop ] with-compilation-unit ] unit-test
] with-variables

{ "test-scope" } [
    "test-scope" "scratchpad" lookup-word name>>
] unit-test

{ t } [ loaded-vocab-names array? ] unit-test
{ t } [ loaded-vocab-names [ vocab-words [ word? ] all? ] all? ] unit-test

{ f } [ gensym gensym = ] unit-test

symbol: a-symbol
{ t } [ \ a-symbol symbol? ] unit-test

! See if redefining a generic as a colon def clears some
! word props.
GENERIC: testing ( a -- b ) ;
"in: words.tests : testing ( -- ) ;" eval( -- )

{ f } [ \ testing generic? ] unit-test

: forgotten ( -- ) ;
: another-forgotten ( -- ) ;

forget: forgotten

forget: another-forgotten
: another-forgotten ( -- ) ;

! Make sure that undefined words throw proper errors
defer: deferred
[ deferred ] [ T{ undefined-word f deferred } = ] must-fail-with

[ "in: words.tests defer: not-compiled << not-compiled >>" eval( -- ) ]
[ error>> [ undefined-word? ] [ word>> name>> "not-compiled" = ] bi and ] must-fail-with

{ } [ "in: words.tests forget: not-compiled" eval( -- ) ] unit-test

{ } [ [ "no-loc" "words.tests" create-word drop ] with-compilation-unit ] unit-test
{ f } [ "no-loc" "words.tests" lookup-word where ] unit-test

{ } [ "in: words.tests : no-loc-2 ( -- ) ;" eval( -- ) ] unit-test
{ f } [ "no-loc-2" "words.tests" lookup-word where ] unit-test

{ } [ "in: words.tests : test-last ( -- ) ;" eval( -- ) ] unit-test
{ "test-last" } [ last-word name>> ] unit-test

"undef-test" "words.tests" lookup-word [
    [ forget ] with-compilation-unit
] when*

[ "in: words.tests : undef-test ( -- ) ; << undef-test >>" eval( -- ) ]
[ error>> undefined-word? ] must-fail-with

{ } [
    "in: words.tests GENERIC: symbol-generic ( x -- x )" eval( -- ) ;
] unit-test

{ } [
    "in: words.tests symbol: symbol-generic" eval( -- )
] unit-test

{ t } [ "symbol-generic" "words.tests" lookup-word symbol? ] unit-test
{ f } [ "symbol-generic" "words.tests" lookup-word generic? ] unit-test

{ } [
    "in: words.tests GENERIC: symbol-generic ( a -- b ) ;" <string-reader>
    "symbol-generic-test" parse-stream drop
] unit-test

{ } [
    "in: words.tests TUPLE: symbol-generic ;" <string-reader>
    "symbol-generic-test" parse-stream drop
] unit-test

{ t } [ "symbol-generic" "words.tests" lookup-word symbol? ] unit-test
{ f } [ "symbol-generic" "words.tests" lookup-word generic? ] unit-test

! Regressions
{ } [ "in: words.tests : decl-forget-test ( -- ) ; foldable" eval( -- ) ] unit-test
{ t } [ "decl-forget-test" "words.tests" lookup-word "foldable" word-prop ] unit-test
{ } [ "in: words.tests : decl-forget-test ( -- ) ;" eval( -- ) ] unit-test
{ f } [ "decl-forget-test" "words.tests" lookup-word "foldable" word-prop ] unit-test

{ } [ "in: words.tests : decl-forget-test ( -- ) ; flushable" eval( -- ) ] unit-test
{ t } [ "decl-forget-test" "words.tests" lookup-word "flushable" word-prop ] unit-test
{ } [ "in: words.tests : decl-forget-test ( -- ) ;" eval( -- ) ] unit-test
{ f } [ "decl-forget-test" "words.tests" lookup-word "flushable" word-prop ] unit-test

{ { } }
[
    all-words [
        [ "effect-dependencies" word-prop ]
        [ "definition-dependencies" word-prop ]
        [ "conditional-dependencies" word-prop ] tri
        3append [ "forgotten" word-prop ] filter
    ] map harvest
] unit-test

[ "hi" word-code ] must-fail
