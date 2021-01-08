KICK_DOG	.MACRO
	LDP	#00E0H
	SPLK	#055H,WDKEY
	SPLK	#0AAH,WDKEY
	LDP	#0H
	.ENDM

;BIT CODES FOR TEST BIT INSTRUTION(BIT)

BIT15	.SET	0000H
BIT14	.SET	0001H
BIT13	.SET	0002H
BIT12	.SET	0003H
BIT11	.SET	0004H
BIT10	.SET	0005H
BIT9	.SET	0006H
BIT8	.SET	0007H
BIT7	.SET	0008H
BIT6	.SET	0009H
BIT5	.SET	000AH
BIT4	.SET	000BH
BIT3	.SET	000CH
BIT2	.SET	000DH
BIT1	.SET	000EH
BIT0	.SET	000FH

;INIT TRANMIT DATA FOR INTERRUPT SERVICE ROUTINE

	.DATA
TXDATA	.WORD	0052H
	.WORD	0065H
	.WORD	0061H
	.WORD	0064H
	.WORD	0079H
	.word 	000dh 		;Hex equivalent of ASCII <CR>
	.word 	0000h 		;Hex equivalent of ASCII NULL

INVALID_IP       		
	.word	0049h 		;Hex equivalent of ASCII character 'I'
	.word 	006Eh 		;Hex equivalent of ASCII character 'n'
	.word 	0076h 		;Hex equivalent of ASCII character 'v'
	.word 	0061h 		;Hex equivalent of ASCII character 'a'
	.word 	006Ch 		;Hex equivalent of ASCII character 'l'
	.word 	0069h 		;Hex equivalent of ASCII character 'i'
	.word 	0064h 		;Hex equivalent of ASCII character 'd'
	.word 	0020h 		;Hex equivalent of ASCII (SPACE)
	.word 	0069h 		;Hex equivalent of ASCII character 'i'
	.word 	006Eh 		;Hex equivalent of ASCII character 'n'
	.word 	0070h 		;Hex equivalent of ASCII character 'p'
	.word 	0075h 		;Hex equivalent of ASCII character 'u'
	.word 	0074h 		;Hex equivalent of ASCII character 't'
	.word 	000dh 		;Hex equivalent of ASCII <CR>
	.word 	0000h 		;Hex equivalent of ASCII NULL

GOOD	.word	0074h 		;Hex equivalent of ASCII character 't'
	.word 	0074h 		;Hex equivalent of ASCII character 't'
	.word 	0074h 		;Hex equivalent of ASCII character 't'
	.word 	0074h 		;Hex equivalent of ASCII character 't'
	.word 	0000h 		;Hex equivalent of ASCII NULL

NIGHT	.word	0044h 		;Hex equivalent of ASCII character 'd'
	.word 	0064h 		;Hex equivalent of ASCII character 'd'
	.word 	0064h 		;Hex equivalent of ASCII character 'd'
	.word 	0064h 		;Hex equivalent of ASCII character 'd'
	.word 	0000h 		;Hex equivalent of ASCII NULL

sss	.word	0075h 		;Hex equivalent of ASCII character 'u'
	.word 	0075h 		;Hex equivalent of ASCII character 'u'
	.word 	0075h 		;Hex equivalent of ASCII character 'u'
	.word 	0075h 		;Hex equivalent of ASCII character 'u'
	.word 	0000h 		;Hex equivalent of ASCII NULL


number1	.word	0030h		;Hex equivalent of ASCII character '0'
	.word 	0000h 		;Hex equivalent of ASCII NULL
	.word 	0031h 		;Hex equivalent of ASCII character '1'
	.word 	0000h 		;Hex equivalent of ASCII NULL
	.word 	0032h 		;Hex equivalent of ASCII character '2'
	.word 	0000h 		;Hex equivalent of ASCII NULL
	.word 	0033h 		;Hex equivalent of ASCII character '3'
	.word 	0000h 		;Hex equivalent of ASCII NULL
	.word 	0034h 		;Hex equivalent of ASCII character '4'
	.word 	0000h 		;Hex equivalent of ASCII NULL
	.word 	0035h 		;Hex equivalent of ASCII character '5'
	.word 	0000h 		;Hex equivalent of ASCII NULL
	.word 	0036h 		;Hex equivalent of ASCII character '6'
	.word 	0000h 		;Hex equivalent of ASCII NULL
	.word 	0037h 		;Hex equivalent of ASCII character '7'
	.word 	0000h 		;Hex equivalent of ASCII NULL
	.word 	0038h 		;Hex equivalent of ASCII character '8'
	.word 	0000h 		;Hex equivalent of ASCII NULL
	.word 	0039h 		;Hex equivalent of ASCII character '9'
	.word 	0000h 		;Hex equivalent of ASCII NULL
	.word 	0041h 		;Hex equivalent of ASCII character 'A'
	.word 	0000h 		;Hex equivalent of ASCII NULL
	.word 	0042h 		;Hex equivalent of ASCII character 'B'
	.word 	0000h 		;Hex equivalent of ASCII NULL
	.word 	0043h 		;Hex equivalent of ASCII character 'C'
	.word 	0000h 		;Hex equivalent of ASCII NULL
	.word 	0044h 		;Hex equivalent of ASCII character 'D'
	.word 	0000h 		;Hex equivalent of ASCII NULL
	.word 	0045h 		;Hex equivalent of ASCII character 'E'
	.word 	0000h 		;Hex equivalent of ASCII NULL
	.word 	0046h 		;Hex equivalent of ASCII character 'F'
	.word 	0000h 		;Hex equivalent of ASCII NULL


;VECTOR	ADDRESS DECLARATIONS

	.SECT	".VECTORS"

RSVECT		B	START
INT1		B	INT1_ISR
INT2		B	LOADCOUNT
INT3		B	PHANTOM
INT4		B	PHANTOM
INT5		B	PHANTOM
INT6		B	PHANTOM
RESERVED	B	PHANTOM
SW_INT8 	B	PHANTOM
SW_INT9 	B	PHANTOM
SW_INT10 	B	PHANTOM
SW_INT11 	B	PHANTOM
SW_INT12 	B	PHANTOM
SW_INT13 	B	PHANTOM
SW_INT14 	B	PHANTOM
SW_INT15 	B	PHANTOM
SW_INT16 	B	PHANTOM
TRAP	 	B	PHANTOM
NMI	 	B	PHANTOM
EMU_TRAP 	B	PHANTOM
SW_INT20 	B	PHANTOM
SW_INT21	B	PHANTOM
SW_INT22 	B	PHANTOM
SW_INT23 	B	PHANTOM