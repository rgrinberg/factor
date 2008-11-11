! Copyright (C) 2008 Slava Pestov.
! See http://factorcode.org/license.txt for BSD license.
USING: kernel sequences accessors arrays fry math.intervals
combinators namespaces
stack-checker.inlining
compiler.tree
compiler.tree.combinators
compiler.tree.propagation.copy
compiler.tree.propagation.info
compiler.tree.propagation.nodes
compiler.tree.propagation.simple
compiler.tree.propagation.branches
compiler.tree.propagation.constraints ;
IN: compiler.tree.propagation.recursive

: check-fixed-point ( node infos1 infos2 -- )
    [ value-info<= ] 2all?
    [ drop ] [ label>> f >>fixed-point drop ] if ;

: latest-input-infos ( node -- infos )
    in-d>> [ value-info ] map ;

: recursive-stacks ( #enter-recursive -- stacks initial )
    [ label>> calls>> [ node-input-infos ] map flip ]
    [ latest-input-infos ] bi ;

: generalize-counter-interval ( interval initial-interval -- interval' )
    {
        { [ 2dup interval-subset? ] [ empty-interval ] }
        { [ over empty-interval eq? ] [ empty-interval ] }
        { [ 2dup interval>= t eq? ] [ 1./0. [a,a] ] }
        { [ 2dup interval<= t eq? ] [ -1./0. [a,a] ] }
        [ [-inf,inf] ]
    } cond interval-union nip ;

: generalize-counter ( info' initial -- info )
    2dup [ class>> null-class? ] either? [ drop ] [
        [ drop clone ] [ [ interval>> ] bi@ ] 2bi
        generalize-counter-interval >>interval
    ] if ;

: unify-recursive-stacks ( stacks initial -- infos )
    over empty? [ nip ] [
        [
            [ value-infos-union ] dip
            [ generalize-counter ] keep
            value-info-union
        ] 2map
    ] if ;

: propagate-recursive-phi ( #enter-recursive -- )
    [ recursive-stacks unify-recursive-stacks ] keep
    out-d>> set-value-infos ;

M: #recursive propagate-around ( #recursive -- )
    constraints [ H{ } clone suffix ] change
    [
        constraints [ but-last H{ } clone suffix ] change

        child>>
        [ first compute-copy-equiv ]
        [ first propagate-recursive-phi ]
        [ (propagate) ]
        tri
    ] until-fixed-point ;

: recursive-phi-infos ( node -- infos )
    label>> enter-recursive>> node-output-infos ;

: generalize-return-interval ( info -- info' )
    dup [ literal?>> ] [ class>> null-class? ] bi or
    [ clone [-inf,inf] >>interval ] unless ;

: generalize-return ( infos -- infos' )
    [ generalize-return-interval ] map ;

: return-infos ( node -- infos )
    label>> return>> node-input-infos generalize-return ;

: save-return-infos ( node infos -- )
    swap out-d>> set-value-infos ;

M: #call-recursive propagate-before ( #call-recursive -- )
    [
        [ ] [ latest-input-infos ] [ recursive-phi-infos ] tri
        check-fixed-point
    ]
    [
        dup label>> loop?>> [ drop ] [
            [ ] [ return-infos ] [ node-output-infos ] tri
            [ check-fixed-point ] [ drop save-return-infos ] 3bi
        ] if
    ] bi ;

M: #call-recursive annotate-node
    dup [ in-d>> ] [ out-d>> ] bi append (annotate-node) ;

M: #enter-recursive annotate-node
    dup out-d>> (annotate-node) ;

M: #return-recursive propagate-before ( #return-recursive -- )
    dup label>> loop?>> [ drop ] [
        [ ] [ latest-input-infos ] [ node-input-infos ] tri
        check-fixed-point
    ] if ;

M: #return-recursive annotate-node
    dup in-d>> (annotate-node) ;
