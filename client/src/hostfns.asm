;
; ADTPro - Apple Disk Transfer ProDOS
; Copyright (C) 2006 by David Schmidt
; david__schmidt at users.sourceforge.net
;
; This program is free software; you can redistribute it and/or modify it 
; under the terms of the GNU General Public License as published by the 
; Free Software Foundation; either version 2 of the License, or (at your 
; option) any later version.
;
; This program is distributed in the hope that it will be useful, but 
; WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY 
; or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License 
; for more details.
;
; You should have received a copy of the GNU General Public License along 
; with this program; if not, write to the Free Software Foundation, Inc., 
; 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
;

;---------------------------------------------------------
; Host command functions
; DIR, CD
;---------------------------------------------------------

;---------------------------------------------------------
; DIR - GET DIRECTORY FROM THE PC AND PRINT IT
; PC SENDS 0,1 AFTER PAGES 1..N-1, 0,0 AFTER LAST PAGE
;---------------------------------------------------------
DIR:
	jsr PARMINT
	ldy #PMWAIT
	jsr SHOWM1

	jsr DIRREQUEST
	lda #>BIGBUF	; Get buffer pointer high byte
	sta BLKPTR+1	; Set block buffer pointer
	ldy #$00	; Counter

	jsr DIRREPLY
	lda #>BIGBUF	; Get buffer pointer high byte
	sta BLKPTR+1	; Set block buffer pointer
	ldy #0		; Reset counter
	jsr HOME	; Clear screen

DIRDISP:
	lda (BLKPTR),Y	; Get byte from buffer
	php		; Save flags
	iny		; Bump
	bne DIRMORE	; Skip
	inc BLKPTR+1	; Next 256 bytes
DIRMORE:
	plp		; Restore flags
	beq DIRPAGE	; Page or dir end?
	ora #$80
	jsr COUT1	; Display
	jmp DIRDISP	; Loop back around

DIRPAGE:
	lda (BLKPTR),Y	; Get byte from buffer
	bne DIRCONT

	ldy #PMSG30	; No more files, wait for a key
	jsr SHOWM1 	; ... and return
	jsr RDKEY;
	rts

DIRCONT:
	ldy #PMSG29	; "space to continue, esc to stop"
	jsr SHOWMSG
	jsr RDKEY
	eor #CHR_ESC	; NOT ESCAPE, CONTINUE NORMALLY
	bne DIR		; BY SENDING A "D" TO PC
	jsr DIRABORT
	rts

;---------------------------------------------------------
; CD - Change directory
;---------------------------------------------------------

CD:
	jsr PARMINT
	jsr GETFN1
	bne CDSTART
	jmp CDDONE

CDSTART:
	ldy #PMWAIT
	jsr SHOWM1	; Tell user to have patience
	jsr CDREQUEST
	jsr CDREPLY
	bne CDERROR
	ldy #PMSG14
	jsr SHOWM1
	jsr PAUSE

CDDONE:
	rts

CDERROR:
	tay
	jsr SHOWHM1
	jsr PAUSE
	jmp ABORT
