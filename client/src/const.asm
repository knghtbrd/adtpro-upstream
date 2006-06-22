*---------------------------------------------------------
* Passive addresses (not written to)
*---------------------------------------------------------
MLI	.eq $BF00
MLIADDR	.eq $BF10

*---------------------------------------------------------
* ProDOS equates
*---------------------------------------------------------
PD_ONL	.eq $C5
PD_READ	.eq $80
PD_WRIT	.eq $81
PD_INFO	.eq $C4

*---------------------------------------------------------
* Monitor equates
*---------------------------------------------------------
ch	.eq $24		Character horizontal position
cv	.eq $25		Character vertical position
BASL	.eq $28		Base Line Address
INVFLG	.eq $32		INVERSE FLAG
CLREOL	.eq $FC9C	CLEAR TO END OF LINE
CLREOP	.eq $FC42	CLEAR TO END OF SCREEN
HOME	.eq $FC58	CLEAR WHOLE SCREEN
TABV	.eq $FB5B	SET BASL FROM A
RDKEY	.eq $FD0C	CHARACTER INPUT
NXTCHAR	.eq $FD75	LINE INPUT
COUT1	.eq $FDF0	CHARACTER OUTPUT
CROUT	.eq $FD8E	OUTPUT RETURN
PRDEC   .eq $ED24	Print pointer as decimal

*---------------------------------------------------------
* Horizontal tabs for volume display
*---------------------------------------------------------
H_SL	.eq $02
H_DR	.eq $08
H_VO	.eq $0f
H_SZ	.eq $21

*---------------------------------------------------------
* Horizontal tabs for buffer display
*---------------------------------------------------------
H_BUF	.eq $08
H_NUM1	.eq $12

*---------------------------------------------------------
* Veritcal tab for buffer display
*---------------------------------------------------------
V_MSG	.eq $06
V_BUF	.eq $0a

*---------------------------------------------------------
* Characters
*---------------------------------------------------------
CHR_BLK	.eq $20
CHR_SP	.eq " "
CHR_C	.eq "C"
CHR_G	.eq "G"
CHR_I	.eq "I"
CHR_O	.eq "O"		The letter O
CHR_P	.eq "P"
CHR_R	.eq "R"
CHR_S	.eq "S"
CHR_V	.eq "V"
CHR_W	.eq "W"
CHR_X	.eq "X"
CHR_Z	.eq "Z"
CHR_0	.eq "0"		Zero
CHR_ESC	.eq $9b
CHR_ACK	.eq $06
CHR_NAK	.eq $15
