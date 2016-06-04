USING: arrays assocs classes classes.algebra classes.mixin
compiler.units definitions eval hashtables io.streams.string
kernel math parser sequences source-files strings tools.test
vectors words ;
in: classes.mixin.tests

! Test mixins
mixin: sequence-mixin

INSTANCE: array sequence-mixin
INSTANCE: vector sequence-mixin
INSTANCE: slice sequence-mixin

mixin: assoc-mixin

INSTANCE: hashtable assoc-mixin

GENERIC: collection-size ( x -- y ) ;

M: sequence-mixin collection-size length ;

M: assoc-mixin collection-size assoc-size ;

{ t } [ array sequence-mixin class<= ] unit-test
{ t } [ { 1 2 3 } sequence-mixin? ] unit-test
{ 3 } [ { 1 2 3 } collection-size ] unit-test
{ f } [ H{ { 1 2 } { 2 3 } } sequence-mixin? ] unit-test
{ t } [ H{ { 1 2 } { 2 3 } } assoc-mixin? ] unit-test
{ 2 } [ H{ { 1 2 } { 2 3 } } collection-size ] unit-test

! Test mixing in of new classes after the fact
defer: mx1
forget: mx1

mixin: mx1

INSTANCE: integer mx1

{ t } [ integer mx1 class<= ] unit-test
{ f } [ mx1 integer class<= ] unit-test
{ f } [ mx1 number class<= ] unit-test

"in: classes.mixin.tests use: arrays INSTANCE: array mx1" eval( -- )

{ t } [ array mx1 class<= ] unit-test
{ f } [ mx1 number class<= ] unit-test

[ \ mx1 forget ] with-compilation-unit

use: io.streams.string

2 [
    [ "mixin-forget-test" forget-source ] with-compilation-unit

    [ ] [
        {
            "USING: sequences ;"
            "in: classes.mixin.tests"
            "mixin: mixin-forget-test"
            "INSTANCE: sequence mixin-forget-test"
            "GENERIC: mixin-forget-test-g ( x -- y ) ;"
            "M: mixin-forget-test mixin-forget-test-g ;"
        } "\n" join <string-reader> "mixin-forget-test"
        parse-stream drop
    ] unit-test

    [ { } ] [ { } "mixin-forget-test-g" "classes.mixin.tests" lookup-word execute ] unit-test
    [ H{ } "mixin-forget-test-g" "classes.mixin.tests" lookup-word execute ] must-fail

    [ ] [
        {
            "USING: hashtables ;"
            "in: classes.mixin.tests"
            "mixin: mixin-forget-test"
            "INSTANCE: hashtable mixin-forget-test"
            "GENERIC: mixin-forget-test-g ( x -- y ) ;"
            "M: mixin-forget-test mixin-forget-test-g ;"
        } "\n" join <string-reader> "mixin-forget-test"
        parse-stream drop
    ] unit-test

    [ { } "mixin-forget-test-g" "classes.mixin.tests" lookup-word execute ] must-fail
    [ H{ } ] [ H{ } "mixin-forget-test-g" "classes.mixin.tests" lookup-word execute ] unit-test
] times

! Method flattening interfered with mixin update
mixin: flat-mx-1
TUPLE: flat-mx-1-1 ; INSTANCE: flat-mx-1-1 flat-mx-1
TUPLE: flat-mx-1-2 ; INSTANCE: flat-mx-1-2 flat-mx-1
TUPLE: flat-mx-1-3 ; INSTANCE: flat-mx-1-3 flat-mx-1
TUPLE: flat-mx-1-4 ; INSTANCE: flat-mx-1-4 flat-mx-1
mixin: flat-mx-2     INSTANCE: flat-mx-2 flat-mx-1
TUPLE: flat-mx-2-1 ; INSTANCE: flat-mx-2-1 flat-mx-2

{ t } [ T{ flat-mx-2-1 } flat-mx-1? ] unit-test

! Too eager with reset-class

{ } [ "in: classes.mixin.tests mixin: blah singleton: boo INSTANCE: boo blah" <string-reader> "mixin-reset-test" parse-stream drop ] unit-test

{ t } [ "blah" "classes.mixin.tests" lookup-word mixin-class? ] unit-test

{ } [ "in: classes.mixin.tests mixin: blah" <string-reader> "mixin-reset-test" parse-stream drop ] unit-test

{ t } [ "blah" "classes.mixin.tests" lookup-word mixin-class? ] unit-test

mixin: empty-mixin

{ f } [ "hi" empty-mixin? ] unit-test

mixin: move-instance-declaration-mixin

{ } [ "in: classes.mixin.tests.a use: strings use: classes.mixin.tests INSTANCE: string move-instance-declaration-mixin" <string-reader> "move-mixin-test-1" parse-stream drop ] unit-test

{ } [ "in: classes.mixin.tests.b use: strings use: classes.mixin.tests INSTANCE: string move-instance-declaration-mixin" <string-reader> "move-mixin-test-2" parse-stream drop ] unit-test

{ } [ "in: classes.mixin.tests.a" <string-reader> "move-mixin-test-1" parse-stream drop ] unit-test

{ { string } } [ move-instance-declaration-mixin class-members ] unit-test

mixin: silly-mixin
symbol: not-a-class

[ [ \ not-a-class \ silly-mixin add-mixin-instance ] with-compilation-unit ] must-fail

symbol: not-a-mixin
TUPLE: a-class ;

[ [ \ a-class \ not-a-mixin add-mixin-instance ] with-compilation-unit ] must-fail

! Changing a mixin member's metaclass should not remove it from the mixin
mixin: metaclass-change-mixin
TUPLE: metaclass-change ;
INSTANCE: metaclass-change metaclass-change-mixin

GENERIC: metaclass-change-generic ( a -- b ) ;

M: metaclass-change-mixin metaclass-change-generic ;

{ T{ metaclass-change } } [ T{ metaclass-change } metaclass-change-generic ] unit-test

{ } [ "in: classes.mixin.tests use: math UNION: metaclass-change integer ;" eval( -- ) ] unit-test

{ 0 } [ 0 metaclass-change-generic ] unit-test

! Forgetting a mixin member class should remove it from the mixin
{ } [ [ metaclass-change forget-class ] with-compilation-unit ] unit-test

{ t } [ metaclass-change-mixin class-members empty? ] unit-test
