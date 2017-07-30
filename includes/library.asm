

;
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


;
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
