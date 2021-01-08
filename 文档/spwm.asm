; THIS IS SPWM TEST PROGRAM===SPWM9.ASM
	

        .INCLUDE   "INIT.H"

        .DATA
SINWAVE .WORD 128
        .WORD 112
        .WORD 96
        .WORD 81
        .WORD 67
        .WORD 53
        .WORD 41
        .WORD 30
        .WORD 21
        .WORD 13
        .WORD 7
        .WORD 3
        .WORD 1
        .WORD 1
        .WORD 3
        .WORD 7
        .WORD 13
        .WORD 21
        .WORD 30
        .WORD 41
        .WORD 53
        .WORD 67
        .WORD 81
        .WORD 96
        .WORD 112
        .WORD 128
        .WORD 144
        .WORD 160
        .WORD 174
        .WORD 189
        .WORD 203
        .WORD 215
        .WORD 226
        .WORD 235
        .WORD 243
        .WORD 249
        .WORD 253
        .WORD 255
        .WORD 255
        .WORD 253
        .WORD 249
        .WORD 243
        .WORD 235
        .WORD 226
        .WORD 215
        .WORD 203
        .WORD 189
        .WORD 175
        .WORD 160
        .WORD 144
        .WORD 128

COUNT   .SET   0002H
        .SECT   ".VEC"

RSVECT		B	START
INT1            B       INT1_DO
INT2            B       DD
INT3            B       LOADCOUNT


	.TEXT
        LDP     #7
        SPLK    #50,COUNT
START:  LDPK    #232
        
        SPLK    #1110000001101010B,GPTCON
      
        SPLK	#0000011001100110B,ACTR		
	SPLK	#0000010111100000B,DBTCON	
        SPLK    #0308H,CMPR1
        SPLK    #008CH,CMPR2
        SPLK    #0081H,CMPR3
        SPLK    #014D5H,T1PR
        SPLK    #01404H,T2PR
        SPLK    #01403H,T2CMPR
        SPLK    #0100101101010111B,COMCON
        SPLK    #1100101101010111B,COMCON
	SPLK    #0002H,EVIMRB
        SPLK    #0A842H,T1CON
        SPLK    #0904AH,T2CON
        LDP     #0
        LACC    IFR
        SACL    IFR
        SPLK    #0004H,IMR
        CLRC    INTM
	LAR     AR3,COUNT
        LAR     AR0,#SINWAVE

LOOP:   NOP
        NOP
        NOP

        B       LOOP

LOADCOUNT:      LDP     #232
                LACL    EVIVRB
                SUB     #002CH
                BCND    CHANGE,EQ
                RET

CHANGE: 	MAR     *,AR0
 	     	LAR     AR1,*
 	        NOP
	        MAR     *,AR1
	        LDP     #232
	        SAR     AR1,CMPR1
        	NOP
	        NOP
        	NOP
	        NOP
        	NOP
	        NOP
        	MAR     *,AR0
 	        ADRK    #01H
        	NOP
	        NOP
        	NOP
	        NOP
 	        MAR      *,AR3
                BANZ     LOOP
                CALL     RELOAD
		RET
       
RELOAD:         LAR     AR3,#50
        	LAR     AR0,#SINWAVE
		RET


DD:		B	DD
INT1_DO:	B	INT1_DO
		.END
