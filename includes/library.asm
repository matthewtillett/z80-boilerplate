

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
; Created       : 04/08/2017
; Author        : Matthew Tillett
;
; Data Structure: ix+0 : Length of string
;               : ix+1 : AT line (Y-position)
;               : ix+2 : AY column (X-position)
;               : ix+3 : String
;
; Example
;
;                 ld      hl, _strUpper         ; Message address
;                 call    fn_PrintUpper         ; Call subroutine to print to upper screen (lines 0 - 21)
;                 ld      hl, _strLower         ; Message address
;                 call    fn_PrintLower         ; Call subroutine to print to lower screen (lines 0 & 1)
; _strUpper:      db      5,21,3,"Upper"        ; Message structure
; _strLower:      db      5,1,3,"Lower"         ; Message structure

fn_PrintUpper:
                        push    hl                      ; Push onto stack message address
                                                        ; Calls to $1601 modifies hl

                        ld      a, 2                    ; Output to upper screen (0-21)
                        jp      _printAt


fn_PrintLower:
                        push    hl                      ; Push onto stack message address
                                                        ; Calls to $1601 modifies hl

                        ld      a, 1                    ; Output to upper screen (0-21)


_printAt:
                        call    $1601                   ; Open channel to upper or lower section of screen

                        ld      a, 22                   ; Print at
                        rst     16                      ;

                        pop     hl                      ; Restore message address

                        ld      b, (hl)                 ; Length of string to output

                        inc     hl                      ; Grab line number to print at (y-pos)
                        ld      a, (hl)
                        rst     16

                        inc     hl                      ; Grab column number to print at (x-pos)
                        ld      a, (hl)
                        rst     16

_printLoop:
                        inc     hl                      ; Loop through characters
                        ld      a, (hl)                 ;
                        rst     16                      ; ..and display
                        djnz    _printLoop              ; Decrease 'b'. If b != 0, do jump to label

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

