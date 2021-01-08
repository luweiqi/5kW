        .INCLUDE   "INIT.H"

        .TEXT
        LDPK    #224
        LACC    ADCTRL1
        LACC    ADCTRL2
        LACC    ADCFIFO1
        LACC    ADCFIFO2
        SPLK    #1010110000000011B,ADCTRL1
        NOP
        SPLK    #0000000000000111B,ADCTRL2
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        LACC    ADCTRL1
        LACC    ADCTRL2
        LACC    ADCFIFO1
        LACC    ADCFIFO2
        NOP
        NOP
        BLPD    #ADCFIFO1,02H
        BIT     02H,0
        CC      LOOP1,TC
        CALL    LOOP2



LOOP1:  LDPK    #0E1H                  
	SPLK	#0000H,OCRA
	SPLK	#0000H,OCRB    

        SPLK    #0101H,PADATDIR
	CALL    WAIT1

        SPLK    #0100H,PADATDIR
	CALL    WAIT1
        B       LOOP1
        RET

LOOP2:  LDPK    #0E1H                   
	SPLK	#0000H,OCRA
	SPLK	#0000H,OCRB    

        SPLK    #0101H,PADATDIR  
	CALL    WAIT1

        SPLK    #0101H,PADATDIR
	CALL    WAIT1
        B       LOOP2
        RET



WAIT1:  LACC    #006FH
	SFL
WAIT2:  SUB     #01H
	NOP
	NOP
	NOP
	NOP
	NOP
        BCND    WAIT2,GT
        RET

