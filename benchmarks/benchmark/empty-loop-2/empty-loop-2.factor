USING: math math.private kernel sequences ;
in: benchmark.empty-loop-2

: empty-loop-2 ( n -- )
    iota [ drop ] each ;

: empty-loop-2-benchmark ( -- )
    50000000 empty-loop-2 ;

main: empty-loop-2-benchmark
