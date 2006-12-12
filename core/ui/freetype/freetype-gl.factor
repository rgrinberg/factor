! Copyright (C) 2005, 2006 Slava Pestov.
! See http://factorcode.org/license.txt for BSD license.
USING: alien arrays errors hashtables io kernel
libc math namespaces opengl prettyprint
sequences styles ;
IN: freetype

SYMBOL: freetype
SYMBOL: open-fonts

: freetype-error ( n -- )
    zero? [ "FreeType error" throw ] unless ;

: init-freetype ( -- )
    global [
        f <void*> dup FT_Init_FreeType freetype-error
        *void* freetype set
        H{ } clone open-fonts set
    ] bind ;

TUPLE: font ascent descent height handle widths ;

M: font equal? eq? ;

: close-font ( font -- ) font-handle FT_Done_Face ;

: close-freetype ( -- )
    global [
        open-fonts [ hash-values [ close-font ] each f ] change
        freetype [ FT_Done_FreeType f ] change
    ] bind ;

: with-freetype ( quot -- )
    freetype get expired? [
        init-freetype [ close-freetype ] cleanup
    ] [
        call
    ] if ; inline

: ttf-name ( font style -- name )
    2array H{
        { { "monospace" plain        } "VeraMono" }
        { { "monospace" bold         } "VeraMoBd" }
        { { "monospace" bold-italic  } "VeraMoBI" }
        { { "monospace" italic       } "VeraMoIt" }
        { { "sans-serif" plain       } "Vera"     }
        { { "sans-serif" bold        } "VeraBd"   }
        { { "sans-serif" bold-italic } "VeraBI"   }
        { { "sans-serif" italic      } "VeraIt"   }
        { { "serif" plain            } "VeraSe"   }
        { { "serif" bold             } "VeraSeBd" }
        { { "serif" bold-italic      } "VeraBI"   }
        { { "serif" italic           } "VeraIt"   }
    } hash ;

: ttf-path ( name -- string )
    "/fonts/" swap ".ttf" 3append resource-path ;

: open-face ( font style -- face )
    ttf-name ttf-path >r freetype get r>
    0 f <void*> [ FT_New_Face freetype-error ] keep *void* ;

: dpi 72 ; inline

: ft-floor -6 shift ; inline

: ft-ceil 63 + -64 bitand -6 shift ; inline

: font-units>pixels ( n font -- n )
    face-size face-size-y-scale FT_MulFix ;

: init-ascent ( font face -- )
    dup face-y-max swap font-units>pixels swap set-font-ascent ;

: init-descent ( font face -- )
    dup face-y-min swap font-units>pixels swap set-font-descent ;

: init-font ( font -- )
    dup font-handle 2dup init-ascent dupd init-descent
    dup font-ascent over font-descent - ft-ceil
    swap set-font-height ;

C: font ( handle -- font )
    [ set-font-handle ] keep dup init-font
    V{ } clone over set-font-widths ;

: (open-font) ( font -- open-font )
    first3 >r open-face dup 0 r> 6 shift
    dpi dpi FT_Set_Char_Size freetype-error <font> ;

: open-font ( font -- open-font )
    open-fonts get [ (open-font) ] cache ;

: load-glyph ( font char -- glyph )
    >r font-handle dup r> 0 FT_Load_Char
    freetype-error face-glyph ;

: char-width ( open-font char -- w )
    over font-widths [
        dupd load-glyph glyph-hori-advance ft-ceil
    ] cache-nth nip ;

: glyph-size ( glyph -- dim )
    dup glyph-hori-advance ft-ceil
    swap glyph-height ft-ceil 2array ;

: render-glyph ( font char -- bitmap )
    load-glyph dup
    FT_RENDER_MODE_NORMAL FT_Render_Glyph freetype-error ;

: copy-pixel ( bit tex -- bit tex )
    255 f pick set-alien-unsigned-1 1+
    f pick alien-unsigned-1
    f pick set-alien-unsigned-1 >r 1+ r> 1+ ;

: (copy-row) ( bit tex bitend texend -- bitend texend )
    >r pick over >= [
        r> 2swap 2drop
    ] [
        >r copy-pixel r> r> (copy-row)
    ] if ;

: copy-row ( bit tex width width2 -- bitend texend width width2 )
    [ pick + >r pick + r> (copy-row) ] 2keep ;

: copy-bitmap ( glyph texture -- )
    over glyph-bitmap-rows >r
    over glyph-bitmap-width dup next-power-of-2 2 *
    >r >r >r glyph-bitmap-buffer alien-address r> r> r> r> 
    [ copy-row ] times 2drop 2drop ;

: bitmap>texture ( glyph sprite -- id )
    tuck sprite-size2 * 2 * [
        alien-address [ copy-bitmap ] keep <alien> gray-texture
    ] with-malloc ;

: glyph-texture-loc ( glyph font -- loc )
    over glyph-hori-bearing-x ft-floor -rot
    font-ascent swap glyph-hori-bearing-y - ft-floor 2array ;

: glyph-texture-size ( glyph -- dim )
    dup glyph-bitmap-width next-power-of-2
    swap glyph-bitmap-rows next-power-of-2 2array ;

: <char-sprite> ( font char -- sprite )
    over >r render-glyph dup r> glyph-texture-loc
    over glyph-size pick glyph-texture-size <sprite>
    [ bitmap>texture ] keep [ init-sprite ] keep ;

: draw-char ( open-font char sprites -- )
    [ dupd <char-sprite> ] cache-nth nip
    sprite-dlist glCallList ;

: (draw-string) ( open-font sprites string loc -- )
    GL_TEXTURE_2D [
        [
            [ >r 2dup r> swap draw-char ] each 2drop
        ] with-translation
    ] do-enabled ;
