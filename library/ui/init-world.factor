! Copyright (C) 2005 Slava Pestov.
! See http://factor.sf.net/license.txt for BSD license.
IN: help
DEFER: tutorial

IN: gadgets
USING: generic help io kernel listener math namespaces
prettyprint sequences styles threads words ;

SYMBOL: stack-display

: ui.s ( -- )
    stack-display get dup pane-clear [
        datastack reverse [ unparse. terpri ] each
    ] with-stream* ;

: init-world
    global [
        <world> world set
        
        {{
            [[ background [ 255 255 255 ] ]]
            [[ rollover-bg [ 216 216 255 ] ]]
            [[ bevel-1 [ 160 160 160 ] ]]
            [[ bevel-2 [ 216 216 216 ] ]]
            [[ foreground [ 0 0 0 ] ]]
            [[ reverse-video f ]]
            [[ font "Sans Serif" ]]
            [[ font-size 12 ]]
            [[ font-style plain ]]
        }} world get set-gadget-paint
        
        { 1024 768 0 } world get set-gadget-dim
        
        <plain-gadget> add-layer
    
        <pane> dup pane set <scroller>
        <pane> dup stack-display set <scroller>
        3/4 <y-splitter> add-layer
        
        [
            pane get [
                [ ui.s ] listener-hook set
                clear print-banner
                "Tutorial" [ drop [ tutorial ] pane get pane-call ] <button> gadget.
                listener
            ] with-stream
        ] in-thread
        
        pane get request-focus
    ] bind ;

SYMBOL: first-time

global [ first-time on ] bind

: ?init-world
    first-time get [ init-world first-time off ] when ;
