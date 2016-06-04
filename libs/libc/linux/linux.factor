USING: alien.c-types alien.syntax destructors kernel system ;
in: libc

LIBRARY: libc

CONSTANT: EPERM 1
CONSTANT: ENOENT 2
CONSTANT: ESRCH 3
CONSTANT: EINTR 4
CONSTANT: EIO 5
CONSTANT: ENXIO 6
CONSTANT: E2BIG 7
CONSTANT: ENOEXEC 8
CONSTANT: EBADF 9
CONSTANT: ECHILD 10
CONSTANT: EAGAIN 11
CONSTANT: ENOMEM 12
CONSTANT: EACCES 13
CONSTANT: EFAULT 14
CONSTANT: ENOTBLK 15
CONSTANT: EBUSY 16
CONSTANT: EEXIST 17
CONSTANT: EXDEV 18
CONSTANT: ENODEV 19
CONSTANT: ENOTDIR 20
CONSTANT: EISDIR 21
CONSTANT: EINVAL 22
CONSTANT: ENFILE 23
CONSTANT: EMFILE 24
CONSTANT: ENOTTY 25
CONSTANT: ETXTBSY 26
CONSTANT: EFBIG 27
CONSTANT: ENOSPC 28
CONSTANT: ESPIPE 29
CONSTANT: EROFS 30
CONSTANT: EMLINK 31
CONSTANT: EPIPE 32
CONSTANT: EDOM 33
CONSTANT: ERANGE 34
CONSTANT: EDEADLK 35
CONSTANT: ENAMETOOLONG 36
CONSTANT: ENOLCK 37
CONSTANT: ENOSYS 38
CONSTANT: ENOTEMPTY 39
CONSTANT: ELOOP 40
ALIAS: EWOULDBLOCK EAGAIN ;
CONSTANT: ENOMSG 42
CONSTANT: EIDRM 43
CONSTANT: ECHRNG 44
CONSTANT: EL2NSYNC 45
CONSTANT: EL3HLT 46
CONSTANT: EL3RST 47
CONSTANT: ELNRNG 48
CONSTANT: EUNATCH 49
CONSTANT: ENOCSI 50
CONSTANT: EL2HLT 51
CONSTANT: EBADE 52
CONSTANT: EBADR 53
CONSTANT: EXFULL 54
CONSTANT: ENOANO 55
CONSTANT: EBADRQC 56
CONSTANT: EBADSLT 57
ALIAS: EDEADLOCK EDEADLK ;
CONSTANT: EBFONT 59
CONSTANT: ENOSTR 60
CONSTANT: ENODATA 61
CONSTANT: ETIME 62
CONSTANT: ENOSR 63
CONSTANT: ENONET 64
CONSTANT: ENOPKG 65
CONSTANT: EREMOTE 66
CONSTANT: ENOLINK 67
CONSTANT: EADV 68
CONSTANT: ESRMNT 69
CONSTANT: ECOMM 70
CONSTANT: EPROTO 71
CONSTANT: EMULTIHOP 72
CONSTANT: EDOTDOT 73
CONSTANT: EBADMSG 74
CONSTANT: EOVERFLOW 75
CONSTANT: ENOTUNIQ 76
CONSTANT: EBADFD 77
CONSTANT: EREMCHG 78
CONSTANT: ELIBACC 79
CONSTANT: ELIBBAD 80
CONSTANT: ELIBSCN 81
CONSTANT: ELIBMAX 82
CONSTANT: ELIBEXEC 83
CONSTANT: EILSEQ 84
CONSTANT: ERESTART 85
CONSTANT: ESTRPIPE 86
CONSTANT: EUSERS 87
CONSTANT: ENOTSOCK 88
CONSTANT: EDESTADDRREQ 89
CONSTANT: EMSGSIZE 90
CONSTANT: EPROTOTYPE 91
CONSTANT: ENOPROTOOPT 92
CONSTANT: EPROTONOSUPPORT 93
CONSTANT: ESOCKTNOSUPPORT 94
CONSTANT: EOPNOTSUPP 95
CONSTANT: EPFNOSUPPORT 96
CONSTANT: EAFNOSUPPORT 97
CONSTANT: EADDRINUSE 98
CONSTANT: EADDRNOTAVAIL 99
CONSTANT: ENETDOWN 100
CONSTANT: ENETUNREACH 101
CONSTANT: ENETRESET 102
CONSTANT: ECONNABORTED 103
CONSTANT: ECONNRESET 104
CONSTANT: ENOBUFS 105
CONSTANT: EISCONN 106
CONSTANT: ENOTCONN 107
CONSTANT: ESHUTDOWN 108
CONSTANT: ETOOMANYREFS 109
CONSTANT: ETIMEDOUT 110
CONSTANT: ECONNREFUSED 111
CONSTANT: EHOSTDOWN 112
CONSTANT: EHOSTUNREACH 113
CONSTANT: EALREADY 114
CONSTANT: EINPROGRESS 115
CONSTANT: ESTALE 116
CONSTANT: EUCLEAN 117
CONSTANT: ENOTNAM 118
CONSTANT: ENAVAIL 119
CONSTANT: EISNAM 120
CONSTANT: EREMOTEIO 121
CONSTANT: EDQUOT 122
CONSTANT: ENOMEDIUM 123
CONSTANT: EMEDIUMTYPE 124
CONSTANT: ECANCELED 125
CONSTANT: ENOKEY 126
CONSTANT: EKEYEXPIRED 127
CONSTANT: EKEYREVOKED 128
CONSTANT: EKEYREJECTED 129
CONSTANT: EOWNERDEAD 130
CONSTANT: ENOTRECOVERABLE 131

CONSTANT: SIGHUP           1
CONSTANT: SIGINT           2
CONSTANT: SIGQUIT          3
CONSTANT: SIGILL           4
CONSTANT: SIGTRAP          5
CONSTANT: SIGABRT          6
CONSTANT: SIGIOT           6
CONSTANT: SIGBUS           7
CONSTANT: SIGFPE           8
CONSTANT: SIGKILL          9
CONSTANT: SIGUSR1         10
CONSTANT: SIGSEGV         11
CONSTANT: SIGUSR2         12
CONSTANT: SIGPIPE         13
CONSTANT: SIGALRM         14
CONSTANT: SIGTERM         15
CONSTANT: SIGSTKFLT       16
CONSTANT: SIGCHLD         17
ALIAS:    SIGCLD          SIGCHLD ;
CONSTANT: SIGCONT         18
CONSTANT: SIGSTOP         19
CONSTANT: SIGTSTP         20
CONSTANT: SIGTTIN         21
CONSTANT: SIGTTOU         22
CONSTANT: SIGURG          23
CONSTANT: SIGXCPU         24
CONSTANT: SIGXFSZ         25
CONSTANT: SIGVTALRM       26
CONSTANT: SIGPROF         27
CONSTANT: SIGWINCH        28
CONSTANT: SIGIO           29
ALIAS:    SIGPOLL         SIGIO ;
CONSTANT: SIGPWR          30
CONSTANT: SIGSYS          31

FUNCTION: c-string strerror_r ( int errno, char* buf, size_t buflen ) ;

M: linux strerror ( errno -- str )
    [
        1024 [ malloc &free ] keep strerror_r
    ] with-destructors ;
