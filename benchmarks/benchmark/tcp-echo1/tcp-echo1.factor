! Copyright (C) 2011 Doug Coleman.
! See http://factorcode.org/license.txt for BSD license.
USING: benchmark.tcp-echo0 io ;
in: benchmark.tcp-echo1

: tcp-echo1-benchmark ( -- )
    5,000 64 tcp-echo-benchmark ;

main: tcp-echo1-benchmark
