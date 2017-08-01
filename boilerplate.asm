; ProgramName
; Description of program
; spanning multiple lines

; History
; ~~~~~~~
; v0.1 - 2017-11-25
; Initial release
;
; v0.2 - 2017-12-15
; - Bug fix print routine
; - Added hardware scrolling


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


; How to assemble (command line)
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Release: pasmo --tapbas myFile.asm myFile.tap
;   Debug: pasmo --bin myFile.asm myFile.tap
;          Load into emulator (ZX Spin / Load Binary)
;          Type: Print Usr 24832 (p, CTRL+SHIFT L)
; 
; How to assemble (batch file)
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~
; run: build.bat --help

; Additional:
; ~~~~~~~~~~~
; - http://pasmo.speccy.org/pasmodoc.html#command

; Naming Conventions:
; ~~~~~~~~~~~~~~~~~~~
; Variables are camelCase. E.g., 
; myVariable	db	#3
;
; Constant addresses are UPPERCASE, spaces are replaced with an underscore. E.g., 
; SCREEN_RAM	equ	$4000
;
; Labels begin with an underscore and then continue as 'camelCase', ending with a colon. E.g.,
; _camelCase:	ld 	a, #3
;
; Functions / Sub-routines begin with 'fn_' and continue in 'TitleCase', ending with a colon. E.g., 
; fn_TitleCase:
; call fn_TitleCase

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

; Constants (Addresses)

; Location in memory program will ORGiginate
START_ADDRESS           equ     $6100

; Address of screen RAM
; Screen resolution 256 x 191 (32 x 24 characters. 768 Total). Each character is 8x8 pixels, but
; is divided up into 8 x 1 byte data. E.g., $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff = 1 character 
; %00111100 = $3c / #60
; %01000010 = $42 / #66
; %10100101 = $A5 / #165
; %10000001 = $81 / #129
; %10100101 = $A5 / #165
; %10011001 = $99 / #153
; %01000010 = $42 / #66
; %00111100 = $3c / #60
; Screen RAM is from $4000 - $57FF, total of 6143 bytes. Divide this by 8 = 768 characters
SCREEN_RAM              equ     $4000   ; $4000 - $57FF (Total Bytes = 6143 + 0)

; Colour pallet RAM
; Screen resolution: 32 x 24 characters (768 in total).
; Only 2 colours per character allowed; Ink + Paper colour
; Colour RAM is from $5800 - $5AFF, total of 767 bytes.
COLOUR_RAM              equ     $5800   ; $5800 - $5AFF (Total Bytes = 767 + 0)

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

; Constants (Values)

LIVES                   equ     #3


; Program Block Start
                        org     START_ADDRESS

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Variables

playerLives:            db      4

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Main Code
                        ;code starts here...
                        call    fn_ClearScreen


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Includes / Unassembled Libs / Binary Assets

                        include "./includes/library.asm"
                        ;incbin  "./includes/assets/myasset.bin"

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Strings
; Structure:    ix+0 : Length of string
;               ix+1 : AT x position
;               ix+2 : AY y position
;               ix+3 : String

_strScore:               db      5,1,4, "Score"

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Data Tables
; Structure:    ix+0 : Length of data table
;               ix+1 : data
;               ix+n : data, ...

_tblJump:                db      9, 1, 1, 2, 3, 0, 0, 1, 2, 4

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Program Block End
                        End     START_ADDRESS