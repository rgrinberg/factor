! :folding=none:collapseFolds=1:

! $Id$
!
! Copyright (C) 2004 Slava Pestov.
! 
! Redistribution and use in source and binary forms, with or without
! modification, are permitted provided that the following conditions are met:
! 
! 1. Redistributions of source code must retain the above copyright notice,
!    this list of conditions and the following disclaimer.
! 
! 2. Redistributions in binary form must reproduce the above copyright notice,
!    this list of conditions and the following disclaimer in the documentation
!    and/or other materials provided with the distribution.
! 
! THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES,
! INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
! FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
! DEVELOPERS AND CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
! SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
! PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
! OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
! WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
! OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
! ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

USE: combinators
USE: kernel
USE: lists
USE: math
USE: namespaces
USE: parser
USE: real-math
USE: stack
USE: stdio
USE: streams
USE: strings
USE: vectors
USE: vectors
USE: words

IN: compiler
DEFER: set-compiled-byte
DEFER: set-compiled-cell
DEFER: compiled-offset
DEFER: set-compiled-offset
DEFER: literal-top
DEFER: set-literal-top

IN: kernel
DEFER: getenv
DEFER: setenv
DEFER: save-image
DEFER: room
DEFER: os-env
DEFER: type-of
DEFER: size-of
DEFER: address-of
DEFER: dump

IN: strings
DEFER: str=
DEFER: str-hashcode
DEFER: sbuf=
DEFER: sbuf-clone

IN: files
DEFER: stat
DEFER: (directory)
DEFER: cwd
DEFER: cd

IN: io-internals
DEFER: port?
DEFER: open-file
DEFER: client-socket
DEFER: server-socket
DEFER: close-port
DEFER: add-accept-io-task
DEFER: accept-fd
DEFER: can-read-line?
DEFER: add-read-line-io-task
DEFER: read-line-fd-8
DEFER: can-read-count?
DEFER: add-read-count-io-task
DEFER: read-count-fd-8
DEFER: can-write?
DEFER: add-write-io-task
DEFER: write-fd-8
DEFER: add-copy-io-task
DEFER: pending-io-error
DEFER: next-io-task

IN: math
DEFER: number=
DEFER: /i

IN: parser
DEFER: str>float

IN: profiler
DEFER: call-profiling
DEFER: call-count
DEFER: set-call-count
DEFER: allot-profiling
DEFER: allot-count
DEFER: set-allot-count

IN: random
DEFER: init-random
DEFER: (random-int)

IN: words
DEFER: <word>
DEFER: word-hashcode
DEFER: word-xt
DEFER: set-word-xt
DEFER: word-primitive
DEFER: set-word-primitive
DEFER: word-parameter
DEFER: set-word-parameter
DEFER: word-plist
DEFER: set-word-plist

IN: unparser
DEFER: unparse-float

IN: image

: primitives, ( -- )
    1 [
        execute
        call
        ifte
        cons?
        cons
        car
        cdr
        set-car
        set-cdr
        vector?
        <vector>
        vector-length
        set-vector-length
        vector-nth
        set-vector-nth
        string?
        str-length
        str-nth
        str-compare
        str=
        str-hashcode
        index-of*
        substring
        str-reverse
        sbuf?
        <sbuf>
        sbuf-length
        set-sbuf-length
        sbuf-nth
        set-sbuf-nth
        sbuf-append
        sbuf>str
        sbuf-reverse
        sbuf-clone
        sbuf=
        number?
        >fixnum
        >bignum
        >float
        number=
        fixnum?
        bignum?
        ratio?
        numerator
        denominator
        float?
        str>float
        unparse-float
        float>bits
        complex?
        real
        imaginary
        >rect
        rect>
        +
        -
        *
        /i
        /f
        /
        mod
        /mod
        bitand
        bitor
        bitxor
        bitnot
        shift
        <
        <=
        >
        >=
        facos
        fasin
        fatan
        fatan2
        fcos
        fexp
        fcosh
        flog
        fpow
        fsin
        fsinh
        fsqrt
        word?
        <word>
        word-hashcode
        word-xt
        set-word-xt
        word-primitive
        set-word-primitive
        word-parameter
        set-word-parameter
        word-plist
        set-word-plist
        drop
        dup
        swap
        over
        pick
        nip
        tuck
        rot
        >r
        r>
        eq?
        getenv
        setenv
        open-file
        stat
        (directory)
        garbage-collection
        save-image
        datastack
        callstack
        set-datastack
        set-callstack
        port?
        exit*
        client-socket
        server-socket
        close-port
        add-accept-io-task
        accept-fd
        can-read-line?
        add-read-line-io-task
        read-line-fd-8
        can-read-count?
        add-read-count-io-task
        read-count-fd-8
        can-write?
        add-write-io-task
        write-fd-8
        add-copy-io-task
        pending-io-error
        next-io-task
        room
        os-env
        millis
        init-random
        (random-int)
        type-of
        size-of
        call-profiling
        call-count
        set-call-count
        allot-profiling
        allot-count
        set-allot-count
        dump
        cwd
        cd
        set-compiled-byte
        set-compiled-cell
        compiled-offset
        set-compiled-offset
        literal-top
        set-literal-top
        address-of
    ] [
        swap succ tuck primitive,
    ] each drop ;

: version, ( -- )
    "version" [ "kernel" ] search version unit compound, ;

: make-image ( name -- )
    #! Make an image for the C interpreter.
    [
        "/library/platform/native/boot.factor" run-resource
    ] with-image

    swap write-image ;

: make-images ( -- )
    "64-bits" off
    "big-endian" off "boot.image.le32" make-image
    "big-endian" on  "boot.image.be32" make-image
    "64-bits" on
    "big-endian" off "boot.image.le64" make-image
    "big-endian" on  "boot.image.be64" make-image ;
