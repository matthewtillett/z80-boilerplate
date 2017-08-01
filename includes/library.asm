

; Clear entire screen
; Version       : v1.0
; Created       : 01/01/1971
; Author        : Unknown
; Usage         :
fn_ClearScreen:
                        push    hl
                        push    bc
                        push    de

                        xor     a
                        ld      (SCREEN_RAM), a
                        ld      hl, SCREEN_RAM
                        ld      de, SCREEN_RAM+1
                        ld      bc, 6143
                        ldir

                        pop     de
                        pop     bc
                        pop     hl
                        ret
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


; Prints a string at a specified screen location
; Version       : v1.0
; Created       : 01/08/2017
; Author        : Matthew Tillett
;
; Data Structure: ix+0 : Length of string
;               : ix+1 : AT line (Y-position)
;               : ix+2 : AY column (X-position)
;               : ix+3 : String
;
; Example
;
;                 ld      hl, _strScore         ; Label address of string structure
;                 call    fn_PrintAt            ; Call subroutine
; _strScore:      db      5,0,20,"Score"        ; Label with strings structure

fn_PrintAt:
                        push    hl                      ; Push onto stack label address
                                                        ; Calls to $1601 modifies hl

                        ld      a, 2                    ; Output to upper screen (0-21)
                        call    $1601                   ; Open channel

                        ld      a, 22                   ; Print at
                        rst     16                      ;

                        pop    hl                       ; Restore label address

                        ld      b, (hl)                 ; Length of string to output

                        inc     hl                      ; Grab line number to print at (y-pos)
                        ld      a, (hl)
                        rst     16

                        inc     hl                      ; Grab column number to print at (x-pos)
                        ld      a, (hl)
                        rst     16

_printLine:
                        inc     hl                      ; Loop through characters
                        ld      a, (hl)                 ;
                        rst     16                      ; ..and display
                        djnz    _printLine              ; Decrease 'b'. If b != 0, do jump to label

                        ret
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


; Test function
; Version       : v1.0
; Created       : 29/07/2014
; Author        : Matthew Tillett
; Usage         : call fn_Test
fn_Test:
                        ld      a, #1
                        ld      a, #1
                        ld      a, #1
                        ld      a, #1
                        ld      a, #1
                        ret
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

