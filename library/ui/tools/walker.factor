! Copyright (C) 2006 Slava Pestov.
! See http://factorcode.org/license.txt for BSD license.
IN: gadgets-walker
USING: arrays errors gadgets gadgets-buttons gadgets-frames
gadgets-listener gadgets-panes gadgets-scrolling gadgets-text
gadgets-tiles gadgets-tracks generic hashtables inspector
interpreter io kernel kernel-internals listener math models
namespaces sequences shells threads vectors ;

: <scrolling-tile> ( model quot title -- gadget )
    >r <pane-control> <scroller> r> f <tile> ;

: <callstack-display> ( model -- )
    [ continuation-call callstack. ]
    "Call stack" <scrolling-tile> ;

: <datastack-display> ( model -- )
    [ continuation-data stack. ]
    "Data stack" <scrolling-tile> ;

: <retainstack-display> ( model -- )
    [ continuation-retain stack. ]
    "Retain stack" <scrolling-tile> ;

: <namestack-display> ( model -- )
    [ continuation-name stack. ]
    "Name stack" <scrolling-tile> ;

: <catchstack-display> ( model -- )
    [ continuation-catch stack. ]
    "Catch stack" <scrolling-tile> ;

: <quotation-display> ( quot -- gadget )
    [ [ first2 callframe. ] when* ] <pane-control> <scroller> ;

: <walker-track> ( model quot -- gadget )
    {
        { [ <quotation-display> ] f f 1/6 }
        { [ dup <callstack-display> ] f f 1/6 }
        { [ dup <datastack-display> ] f f 1/6 }
        { [ dup <retainstack-display> ] f f 1/6 }
        { [ dup <namestack-display> ] f f 1/6 }
        { [ <catchstack-display> ] f f 1/6 }
    } { 0 1 } make-track ;

TUPLE: walker-gadget model quot ns ;

: find-walker-gadget [ walker-gadget? ] find-parent ;

: update-stacks ( walker -- )
    meta-interp get over walker-gadget-model set-model
    meta-callframe swap walker-gadget-quot set-model ;

: with-walker ( gadget quot -- )
    swap find-walker-gadget
    dup walker-gadget-ns [ slip update-stacks ] bind ; inline

: walker-step [ step ] with-walker ;
: walker-step-in [ step-in ] with-walker ;
: walker-step-out [ step-out ] with-walker ;
: walker-step-all [ step-all ] with-walker ;
: walker-step-back [ step-back ] with-walker ;

: <walker-toolbar> ( -- gadget )
    [
        "Step" [ walker-step ] <bevel-button> ,
        "Step in" [ walker-step-in ] <bevel-button> ,
        "Step out" [ walker-step-out ] <bevel-button> ,
        "Continue" [ walker-step-all ] <bevel-button> ,
        "Step back" [ walker-step-back ] <bevel-button> ,
    ] make-toolbar ;

: init-walker-models ( walker -- )
    f <model> over set-walker-gadget-model
    f <model> swap set-walker-gadget-quot ;

: walker-models ( -- model quot )
    gadget get walker-gadget-model
    gadget get walker-gadget-quot ;

M: walker-gadget gadget-title
    drop "Single stepper" <model> ;

M: walker-gadget pref-dim*
    delegate pref-dim { 500 600 } vmax ;

: (walk) ( quot continuation walker -- )
    H{ } clone over set-walker-gadget-ns [
        V{ } clone meta-history set
        meta-interp set
        (meta-call)
    ] with-walker ;

C: walker-gadget ( -- gadget )
    dup init-walker-models {
        { [ <walker-toolbar> ] f f @top }
        { [ walker-models <walker-track> ] f f @center }
    } make-frame* ;

\ walker-gadget H{
    { T{ key-down f f "s" } [ walker-step ] }
    { T{ key-down f f "i" } [ walker-step-in ] }
    { T{ key-down f f "o" } [ walker-step-out ] }
    { T{ key-down f f "a" } [ walker-step-all ] }
    { T{ key-down f f "b" } [ walker-step-back ] }
} set-gestures

: walk ( quot -- )
    continuation dup continuation-data pop*
    <walker-gadget> [ (walk) ] keep open-window stop ;
