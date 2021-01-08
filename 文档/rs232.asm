        .INCLUDE        "INIT.H"
KICK_DOG.MACRO
        LDP     #00E0H
        SPLK    #055H,WDKEY
        SPLK    #0AAH,WDKEY
        LDP     #0H
        .ENDM
        

	.TEXT
START:	SETC	INTM	;DISABLE INTERRUPTS
	CLRC	SXM	;CLEAR SIGN EXTENSION MODE
	CLRC	OVM	;RESET OVERFLOW MODE
	CLRC	CNF	;CONFIG BLOCK B0 TO DATA MEM.
        LDP     #00E0H
        SPLK    #006FH,WDCR
        KICK_DOG
	LDP	#00E0H
        SPLK    #0000000001101000B,CKCR1
        SPLK    #0000000011000010B,CKCR0    ;CLKMD=PLL ,SYSCLK=CPUCLK/2
        SPLK    #40C0H,SYSCR                ;CLKOUT=CPUCLK

;INIT OF INTERRUPT DRIVEN SCI ROUTINE
SCI_INIT:	LDP	#00E0H
                SPLK    #0037H,SCICCR
                SPLK    #001BH,SCICTL1
                
                SPLK    #0000H,SCICTL2
		SPLK    #0000H,SCIHBAUD
                SPLK    #0040H,SCILBAUD ;RATE=9600B/S(20M)
		SPLK    #0022H,SCIPC2
                SPLK    #003BH,SCICTL1
                LACC    SCIRXST
                LACC    SCIRXBUF
                LACC    SCICTL2
                
;MAIN PROGRAM ROUTAIN

                              
        NOP
        CALL    WAIT1
        NOP
        NOP
	NOP
        SPLK    #0052H,SCITXBUF
        NOP
        NOP
        CALL    WAIT1
        NOP
        NOP
        SPLK    #0052H,SCITXBUF
        NOP
        NOP
        CALL    WAIT1
        NOP
        NOP

        SPLK    #0065H,SCITXBUF
        NOP
        NOP
        CALL    WAIT1
	NOP
	NOP
        NOP
        SPLK    #0061H,SCITXBUF
        NOP
        NOP
        CALL    WAIT1
	NOP
	NOP
        SPLK    #0064H,SCITXBUF
        NOP
        NOP
        CALL    WAIT1
	NOP
	NOP
        SPLK    #0079H,SCITXBUF
        NOP
        NOP
        CALL    WAIT1
	NOP
	NOP
        SPLK    #001AH,SCITXBUF
        NOP
        NOP
        NOP
        CALL    WAIT1
        NOP
	NOP
        NOP


MAIN:   
        LDP     #6
;        BLPD    #SCIRXBUF,00H
        LDP     #00E0H
        LACC    SCIRXBUF
        SUB     #005AH                  ;IF RECEIVE THE CODE "Z",THEN SEND "TT"
        BCND    SEND_CHAR,EQ
        B       MAIN


WAIT1:  LDP     #00E0H
;        SPLK    #0,SCIRXBUF
        LACC    #03FFH          ;THIS WAIT TIME WILL BE CHANGE IF THE 40MHz CHANGE
	SFL
LOOP1:  SUB     #01H
	NOP
	NOP
	NOP
	NOP
	NOP
	BCND	LOOP1,GT
	RET


SEND_CHAR:
        NOP
        CALL    WAIT1
        NOP
        NOP
        SPLK    #0054H,SCITXBUF         ;do not know why need send the first character twice
        NOP
        NOP
        CALL    WAIT1
        NOP
	NOP
        SPLK    #0053H,SCITXBUF
        NOP
        NOP
        CALL    WAIT1
        NOP
        NOP
S:      B       S
