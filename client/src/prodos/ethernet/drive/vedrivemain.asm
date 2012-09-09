;
; ADTPro - Apple Disk Transfer ProDOS
; Copyright (C) 2012 by David Schmidt
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

; Virtual drive over ethernet based on ideas by Terence J. Boldt

	.import ip65_init

	.export cfg_ip
	.export cfg_netmask
	.export cfg_gateway
	.export cfg_dns
	.export dhcp_server
	.export cfg_tftp_server
	.export output_buffer

	.global COMMSLOT

RESETIO:
	jsr $0000	; Pseudo-indirect JSR to reset the IO device
	rts

COMMSLOT:
	.byte $02	; Zero-indexed comms slot (3)
PDHCP:	.byte 0		; DHCP Configuration? (YES)

ip_parms:
serverip:	.byte 192, 168,   0,  24
cfg_ip:		.byte   0,   0,   0,   0 ; ip address of local machine (will be overwritten if dhcp_init is called)
cfg_netmask:	.byte   0,   0,   0,   0 ; netmask of local network (will be overwritten if dhcp_init is called)
cfg_gateway:	.byte   0,   0,   0,   0 ; ip address of router on local network (will be overwritten if dhcp_init is called)
PARMSEND:
cfg_dns:	.byte   0,   0,   0,   0 ; ip address of dns server to use (will be overwritten if dhcp_init is called)
dhcp_server:	.byte   0,   0,   0,   0 ; will be set address of dhcp server that configuration was obtained from
cfg_tftp_server:
		.byte   0,   0,   0,   0 ; ip address of server to send tftp requests to (can be a broadcast address)
output_buffer:
	.res $0208,$00