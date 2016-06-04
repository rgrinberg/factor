USING: kernel math math.parser sequences ;
in: benchmark.parse-bignum

: parse-bignum-benchmark ( -- )
    3000 iota [
        2^ [ number>string string>number ] [ assert= ] bi
    ] each ;

main: parse-bignum-benchmark
