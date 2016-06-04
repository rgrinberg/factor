USING: libc.private ;
in: libc

: malloc ( size -- newalien ) (malloc) check-ptr ;

: realloc ( alien size -- newalien ) (realloc) check-ptr ;

: calloc ( size count -- newalien ) (calloc) check-ptr ;

: free ( alien -- ) (free) ;

forget: malloc-ptr

forget: <malloc-ptr>
