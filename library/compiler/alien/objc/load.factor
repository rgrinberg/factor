USE: kernel

PROVIDE: library/compiler/alien/objc {
    { "objc-x86.factor" [ cpu "x86" = ] }
    { "objc-ppc.factor" [ cpu "ppc" = ] }
    "runtime.factor"
    "utilities.factor"
    "subclassing.factor"
} ;
