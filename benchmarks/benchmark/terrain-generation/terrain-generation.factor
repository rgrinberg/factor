! (c)Joe Groff bsd license
USING: accessors kernel math.vectors.simd terrain.generation ;
FROM: alien.c-types => float ;
in: benchmark.terrain-generation

: terrain-generation-benchmark ( -- )
    <terrain> float-4{ 0 0 0 1 } terrain-segment
    dim>> { 512 512 } assert= ;

main: terrain-generation-benchmark
