! Copyright (C) 2023 Doug Coleman.
! See http://factorcode.org/license.txt for BSD license.
USING: build-from-source io.directories io.launcher multiline ;
IN: build-from-source.windows

! From `choco install -y nasm`
! Add nasm to path (windows+r sysdm.cpl -> Advanced tab -> Environment Variables -> New -> "c:\Program Files\NASM")
: check-nasm ( -- ) { [[ C:\Program Files\NASM\nasm.exe]] } try-process ;

! From `choco install -y StrawberryPerl`
! make sure it is above the git /usr/bin/perl (if that is installed)
! TODO: https://stackoverflow.com/questions/5898131/set-a-persistent-environment-variable-from-cmd-exe
: check-perl ( -- ) { "perl" "-h" } try-process ;

! From vcvarsall.bat (x64 Native Tools Command Prompt runs this automatically)
: check-nmake ( -- ) { "nmake" "/?" } try-process ;
: check-cmake ( -- ) { "cmake" "-h" } try-process ;
: check-msbuild ( -- ) { "msbuild" "-h" } try-process ;

: build-openssl-64-dlls ( -- )
    "https://github.com/openssl/openssl.git" [
        check-perl
        check-nasm
        check-nmake
        { "perl" "Configure" "VC-WIN64A" } try-process  ! "VC-WIN32"
        { "nmake" } try-process

        { "openssl/apps/libssl-3-x64.dll" "openssl/apps/libcrypto-3-x64.dll" } copy-output-files
    ] with-updated-git-repo ;

: build-pcre2-dll ( -- )
    "https://github.com/PCRE2Project/pcre2.git" [
        [
            check-cmake
            check-msbuild
            { "cmake" "-DCMAKE_BUILD_TYPE=Release" "-DBUILD_SHARED_LIBS=ON" ".." } try-process
            { "msbuild" "PCRE2.sln" } try-process
            { "Debug/pcre2-8d.dll" "Debug/pcre2-posixd.dll" } copy-output-files
        ] with-build-directory
    ] with-updated-git-repo ;

: build-sqlite3-dll ( -- )
    "https://github.com/sqlite/sqlite.git" [
        check-nmake
        { "nmake" "/f" "Makefile.msc" "clean" } try-process
        { "nmake" "/f" "Makefile.msc" } try-process
        "sqlite3.dll" copy-output-file
    ] with-updated-git-repo ;

: build-zlib-dll ( -- )
    "https://github.com/madler/zlib" [
        check-nmake
        { "nmake" "/f" "win32/Makefile.msc" "clean" } try-process
        { "nmake" "/f" "win32/Makefile.msc" } try-process
        "zlib1.dll" copy-output-file
    ] with-updated-git-repo ;

: build-windows-dlls ( -- )
    dll-out-directory remake-directory
    build-openssl-64-dlls
    build-sqlite3-dll
    build-zlib-dll ;
