! Copyright (C) 2009 Slava Pestov.
! See http://factorcode.org/license.txt for BSD license.
USING: command-line io namespaces sequences ;
in: tools.deploy.test.15

: main ( -- ) command-line get [ print ] each ;

main: main
