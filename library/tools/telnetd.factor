! Copyright (C) 2003, 2005 Slava Pestov.
! See http://factor.sf.net/license.txt for BSD license.
IN: telnetd
USING: errors listener kernel logging namespaces stdio streams
threads parser ;

: telnet-client ( socket -- )
    dup [ log-client listener ] with-stream ;

: telnet-connection ( socket -- )
    [ telnet-client ] in-thread drop ;

: telnetd-loop ( server -- server )
    [ [ accept telnet-connection ] keep ] forever ;

: telnetd ( port -- )
    [
        <server> [ telnetd-loop ] [ swap fclose rethrow ] catch
    ] with-logging ;

IN: shells

: telnet
    "telnetd-port" get str>number telnetd ;

global [ 9999 "telnetd-port" set ] bind
