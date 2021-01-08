;THIS IS A RS232 TEST PROGRAM  == RS232T15.ASM

	.INCLUDE	"INIT.H"
	.INCLUDE	"RS232t2.H"

LENGTH1 .SET    00007H
LENGTH2	.SET	00016H
LENGTH3	.SET	0001Bh
LENGTH4 .SET	00020H

B2_SADDR.SET    00060H
B0_SADDR.SET    00200H
B1_SADDR.SET	00300H

;Variable  definitions

        .BSS	DATA_OUT,LENGTH1
	.BSS	GPR0,1
	.BSS	VALUE1,1
	.BSS	VALUE11,1
	.BSS	VALUE12,1
	.BSS	VALUE13,1
	.BSS	VALUE14,1
	.BSS	VALUE15,1
	.BSS	COUNT1,1
 
;MAIN CODE

	.TEXT
START:	SETC	INTM	;DISABLE INTERRUPTS
	CLRC	SXM	;CLEAR SIGN EXTENSION MODE
	CLRC	OVM	;RESET OVERFLOW MODE
	CLRC	CNF	;CONFIG BLOCK B0 TO DATA MEM.
	LDP	#00E0H
	SPLK	#006FH,WDCR	;DISABLE WATCHDOG IF VCCP=5V
	KICK_DOG

;INIT B2 RAM ZERO'S

        LAR     AR2,#B2_SADDR   ;AR2->B2 START ADDRESS
        MAR     *,AR2           ;SET ARP=AR2
        ZAC                     ;SET ACC=0
        RPT     #1FH            ;SET REPEAT CNTR FOR 31+1 LOOPS
        SACL    *+              ;WRITE ZEROS TO B2 RAM

;INIT DATAOUT WITH DATA TO BE TRANMITTED

        LAR     AR2,#B2_SADDR   ;RESET AR2-> B2 START ADDRESS
        LAR     AR1,#DATA_OUT   ;AR1-> DATAOUT START ADDRESS
        RPT     #04H            ;SET REPEAT COUNTER FOR 4+1 LOOPS
        BLPD    #TXDATA,*+      ;LOADS B2 WITH TXDATA

;INIT OF INTERRUPT DRIVEN SCI ROUTINE
SCI_INIT:	LDP	#00E0H
		SPLK	#0037H,SCICCR
		SPLK	#0013H,SCICTL1
		SPLK	#0002H,SCICTL2
		SPLK    #0000H,SCIHBAUD
 		SPLK    #0040H,SCILBAUD ;RATE=19200B/S
		SPLK    #0022H,SCIPC2
		SPLK	#003BH,SCICTL1
		LAR	AR0,#SCITXBUF
		LAR	AR1,#SCIRXBUF
		LAR   	AR2,#B1_SADDR 	;Load AR2 with TX data start address
 		LAR 	AR3,#B0_SADDR
		LDP	#0
		LACC 	IFR
		SACL	IFR
		SPLK	#0001H,IMR
		CLRC	INTM
	
		LDPK    #224
	        LACC    ADCTRL1
        	LACC    ADCTRL2
	        LACC    ADCFIFO1
	        LACC    ADCFIFO2
;	        SPLK    #1111110001110001B,ADCTRL1
	        NOP
	        SPLK    #0000000000000111B,ADCTRL2
	        NOP
        	NOP
	        NOP
        	NOP
	        NOP
        	NOP
	        NOP

;MAIN PROGRAM ROUTAIN

MAIN:
	
;	LDP	#224
;WAITAD1:	LACC    ADCTRL1
;    		LACC    ADCTRL2
;		BIT	ADCTRL1,BIT7
;		BCND    WAITAD1,NTC 
	
;		LACC	ADCFIFO1
;		RPT	#7
;		SFR
;		NOP
;		LDP	#00E0H
;		SACL	SCITXBUF
;		NOP

		NOP
		NOP	
		B	MAIN



INT1_ISR:	LDP 	#00E0h 		;DP = 224 Address 7000h-707Fh
		LACL 	SYSIVR 		;Load peripheral INT vector address
		LDP 	#0000h 		;DP = 0 Addresses 0000h-007Fh
		SUB	#0006h 		;Subtract RXINT offset from above
		BCND 	RX_ISR,EQ 	;verify RXINT initiated interrupt
		B 	BAD_INT 	;Else, bad interrupt occurred

RX_ISR: 	MAR 	*,AR1 		;ARP = AR1
		LACC 	* 		;Load ACC w/RX buffer character
		BIT 	*,BIT6,AR3 	;Determine if the character is a letter
		BCND 	NUMBER,NTC
		AND 	#01011111b 	;If a letter, capitalize the letter
NUMBER:	 	SACL 	*+ 		;Store the character/number
IP_VALUE:	SUB 	#000Dh 		;Check to see if <CR>
		BCND 	CHECK_IP,EQ 	;If value entered is a <CR>, then process input
		B 	NO_IP 		;else, wait until <CR> is pressed
CHECK_IP:	LAR 	AR3,#B0_SADDR 	;AR3 = Address of first value entered
		LACC 	*+ 		;ACC = ASCII equivalent of value
		SUB  	#0046h 		;Check to see if ASCII letter 'F'
		BCND 	FREQ_CHG,EQ 	;If 'F' goto routine to change frequency
		ADD 	#0046h
		SUB 	#0050h 		;Check to see if ASCII letter 'P'
		BCND 	PHASE_CHG,EQ 	;If 'P' goto routine to change frequency
		ADD 	#0050h
		SUB 	#004Dh 		;Check to see if ASCII letter 'M'
		BCND 	MAG_CHG,EQ 	;If 'M' goto routine to change frequency
		ADD 	#004Dh
		SUB 	#000Dh 		;Check to see if ASCII <CR>
		BCND 	SCI_ISR,EQ 	;If <CR>, output "Ready"
		B 	BAD_IP
		B 	ISR_END 	;If neither a 'F','P','M',or<CR>,then do nothing

BAD_IP:		LAR 	AR2,#(B1_SADDR+LENGTH1) ;Address to output "Invalid Input"

SCI_ISR: 	MAR 	*,AR2 		;ARP = AR2
		LDP 	#00E0h 		;DP = 224 Addresses 7000h-707Fh
XMIT_CHAR: 	LACC 	*+,AR0 		;Load char to be xmitted into ACC
		BCND 	ISR_END,EQ 	;Check for Null Character YES? Return from INT1_ISR.
		SACL 	*,AR2 		;NO? Load char into xmit buffer.

XMIT_RDY: 	BIT 	SCICTL2, BIT7 	;Test TXRDY bit
		BCND 	XMIT_RDY, NTC 	;If TXRDY=0,then repeat loop
		B 	XMIT_CHAR 	;else xmit next character

ISR_END: 	LAR 	AR2, #B1_SADDR 	;Reload AR2 w/ TX data start address
		LAR 	AR3, #B0_SADDR 	;Reload AR3 w/ RX data start address
           	LDP 	#00E0h 		;DP = 224 Addresses 7000h-707Fh
		LACC 	#0Ah 		;Cause a line feed in the terminal
		SACL 	SCITXBUF 	;transmit the line feed
		LDP 	#0 		;DP = 0 Addresses 0000h-007Fh
		CLRC 	INTM 		;Enable Interrrupts
		RET 			;Return from INT1_ISR

NO_IP: 		LAR 	AR2, #B1_SADDR 	;Reload AR2 w/ TX data start address
		LDP 	#0 		;DP = 0 Addresses 0000h-007Fh
		CLRC 	INTM 		;Enable Interrupts
		RET 			;Return from interrupt

BAD_INT: 	LACC 	#0BADh 		;Load ACC with "bad"
		B 	BAD_INT 	;Repeat loop

;ISR    PHANTOM

PHANTOM:	B	PHANTOM
FREQ_CHG:	LDP	#224
		SPLK    #1111110001110001B,ADCTRL1
WAITAD1:	LACC    ADCTRL1
    		LACC    ADCTRL2
		BIT	ADCTRL1,BIT7
		BCND    WAITAD1,NTC 
		NOP
		LDP	#224
		LACC	ADCFIFO1
		RPT     #9
		SFR
		LDP     #00E0H
		SACL	SCITXBUF
XMIT_RDY1: 	BIT 	SCICTL2, BIT7 	;Test TXRDY bit
		BCND 	XMIT_RDY1, NTC 	;If TXRDY=0,then repeat loop
		
		LDP	#224
		LACC	ADCFIFO1
		AND	#0000001111111111B
		RPT	#5
		SFR
		LDP     #00E0H
		SACL	SCITXBUF
XMIT_RDY2: 	BIT 	SCICTL2, BIT7 	;Test TXRDY bit
		BCND 	XMIT_RDY2, NTC 	;If TXRDY=0,then repeat loop

		LAR 	AR2,#(B1_SADDR+LENGTH2) ;Address to output "Invalid Input"
		B 	SCI_ISR

PHASE_CHG:	LDP	#224
		SPLK    #1111110001110001B,ADCTRL1
WAITAD2:	LACC    ADCTRL1
    		LACC    ADCTRL2
		BIT	ADCTRL1,BIT7
		BCND    WAITAD2,NTC 
		NOP
		LDP	#224
		LACC	ADCFIFO2
		RPT     #9
		SFR
		LDP     #00E0H
		SACL	SCITXBUF
XMIT_RDY3: 	BIT 	SCICTL2, BIT7 	;Test TXRDY bit
		BCND 	XMIT_RDY3, NTC 	;If TXRDY=0,then repeat loop
		
		LDP	#224
		LACC	ADCFIFO2
		AND	#0000001111111111B
		RPT	#5
		SFR
		LDP     #00E0H
		SACL	SCITXBUF
XMIT_RDY4: 	BIT 	SCICTL2, BIT7 	;Test TXRDY bit
		BCND 	XMIT_RDY4, NTC 	;If TXRDY=0,then repeat loop


		NOP
		LAR 	AR2,#(B1_SADDR+LENGTH3) ;Address to output "dddd"
		B 	SCI_ISR


MAG_CHG:	NOP
		LAR 	AR2,#(B1_SADDR+LENGTH4) ;Address to output "tttt"
		B 	SCI_ISR

		.END