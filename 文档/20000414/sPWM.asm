; THIS IS SPWM TEST PROGRAM===SPWM14.ASM
	

        .INCLUDE   "INIT.H"
        
        .DATA
SINWAVE       .WORD         02H
              .WORD         06H
              .WORD         0BH
              .WORD         0FH
              .WORD         013H
              .WORD         017H
              .WORD         01CH
              .WORD         020H
              .WORD         024H
              .WORD         028H
              .WORD         02DH
              .WORD         031H
              .WORD         035H
              .WORD         039H
              .WORD         03EH
              .WORD         042H
              .WORD         046H
              .WORD         04AH
              .WORD         04EH
              .WORD         053H
              .WORD         057H
              .WORD         05BH
              .WORD         05FH
              .WORD         063H
              .WORD         067H
              .WORD         06CH
              .WORD         070H
              .WORD         074H
              .WORD         078H
              .WORD         07CH
              .WORD         080H
              .WORD         084H
              .WORD         088H
              .WORD         08CH
              .WORD         090H
              .WORD         094H
              .WORD         098H
              .WORD         09CH
              .WORD         0A0H
              .WORD         0A4H
              .WORD         0A8H
              .WORD         0ACH
              .WORD         0AFH
              .WORD         0B3H
              .WORD         0B7H
              .WORD         0BBH
              .WORD         0BFH
              .WORD         0C2H
              .WORD         0C6H
              .WORD         0CAH
              .WORD         0CEH
              .WORD         0D1H
              .WORD         0D5H
              .WORD         0D8H
              .WORD         0DCH
              .WORD         0E0H
              .WORD         0E3H
              .WORD         0E7H
              .WORD         0EAH
              .WORD         0EEH
              .WORD         0F1H
              .WORD         0F5H
              .WORD         0F8H
              .WORD         0FBH
              .WORD         0FFH
              .WORD         0102H
              .WORD         0105H
              .WORD         0109H
              .WORD         010CH
              .WORD         010FH
              .WORD         0112H
              .WORD         0115H
              .WORD         0118H
              .WORD         011CH
              .WORD         011FH
              .WORD         0122H
              .WORD         0125H
              .WORD         0128H
              .WORD         012AH
              .WORD         012DH
              .WORD         0130H
              .WORD         0133H
              .WORD         0136H
              .WORD         0139H
              .WORD         013BH
              .WORD         013EH
              .WORD         0141H
              .WORD         0143H
              .WORD         0146H
              .WORD         0148H
              .WORD         014BH
              .WORD         014DH
              .WORD         0150H
              .WORD         0152H
              .WORD         0155H
              .WORD         0157H
              .WORD         0159H
              .WORD         015BH
              .WORD         015EH
              .WORD         0160H
              .WORD         0162H
              .WORD         0164H
              .WORD         0166H
              .WORD         0168H
              .WORD         016AH
              .WORD         016CH
              .WORD         016EH
              .WORD         0170H
              .WORD         0172H
              .WORD         0173H
              .WORD         0175H
              .WORD         0177H
              .WORD         0178H
              .WORD         017AH
              .WORD         017CH
              .WORD         017DH
              .WORD         017FH
              .WORD         0180H
              .WORD         0181H
              .WORD         0183H
              .WORD         0184H
              .WORD         0185H
              .WORD         0187H
              .WORD         0188H
              .WORD         0189H
              .WORD         018AH
              .WORD         018BH
              .WORD         018CH
              .WORD         018DH
              .WORD         018EH
              .WORD         018FH
              .WORD         0190H
              .WORD         0191H
              .WORD         0191H
              .WORD         0192H
              .WORD         0193H
              .WORD         0193H
              .WORD         0194H
              .WORD         0194H
              .WORD         0195H
              .WORD         0195H
              .WORD         0196H
              .WORD         0196H
              .WORD         0196H
              .WORD         0197H
              .WORD         0197H
              .WORD         0197H
              .WORD         0197H
              .WORD         0197H
              .WORD         0197H
              .WORD         0197H
              .WORD         0197H
              .WORD         0197H
              .WORD         0197H
              .WORD         0197H
              .WORD         0197H
              .WORD         0196H
              .WORD         0196H
              .WORD         0196H
              .WORD         0195H
              .WORD         0195H
              .WORD         0194H
              .WORD         0194H
              .WORD         0193H
              .WORD         0193H
              .WORD         0192H
              .WORD         0191H
              .WORD         0191H
              .WORD         0190H
              .WORD         018FH
              .WORD         018EH
              .WORD         018DH
              .WORD         018CH
              .WORD         018BH
              .WORD         018AH
              .WORD         0189H
              .WORD         0188H
              .WORD         0187H
              .WORD         0185H
              .WORD         0184H
              .WORD         0183H
              .WORD         0181H
              .WORD         0180H
              .WORD         017FH
              .WORD         017DH
              .WORD         017CH
              .WORD         017AH
              .WORD         0178H
              .WORD         0177H
              .WORD         0175H
              .WORD         0173H
              .WORD         0172H
              .WORD         0170H
              .WORD         016EH
              .WORD         016CH
              .WORD         016AH
              .WORD         0168H
              .WORD         0166H
              .WORD         0164H
              .WORD         0162H
              .WORD         0160H
              .WORD         015EH
              .WORD         015BH
              .WORD         0159H
              .WORD         0157H
              .WORD         0155H
              .WORD         0152H
              .WORD         0150H
              .WORD         014DH
              .WORD         014BH
              .WORD         0148H
              .WORD         0146H
              .WORD         0143H
              .WORD         0141H
              .WORD         013EH
              .WORD         013BH
              .WORD         0139H
              .WORD         0136H
              .WORD         0133H
              .WORD         0130H
              .WORD         012DH
              .WORD         012AH
              .WORD         0128H
              .WORD         0125H
              .WORD         0122H
              .WORD         011FH
              .WORD         011CH
              .WORD         0118H
              .WORD         0115H
              .WORD         0112H
              .WORD         010FH
              .WORD         010CH
              .WORD         0109H
              .WORD         0105H
              .WORD         0102H
              .WORD         0FFH
              .WORD         0FBH
              .WORD         0F8H
              .WORD         0F5H
              .WORD         0F1H
              .WORD         0EEH
              .WORD         0EAH
              .WORD         0E7H
              .WORD         0E3H
              .WORD         0E0H
              .WORD         0DCH
              .WORD         0D8H
              .WORD         0D5H
              .WORD         0D1H
              .WORD         0CEH
              .WORD         0CAH
              .WORD         0C6H
              .WORD         0C2H
              .WORD         0BFH
              .WORD         0BBH
              .WORD         0B7H
              .WORD         0B3H
              .WORD         0AFH
              .WORD         0ACH
              .WORD         0A8H
              .WORD         0A4H
              .WORD         0A0H
              .WORD         09CH
              .WORD         098H
              .WORD         094H
              .WORD         090H
              .WORD         08CH
              .WORD         088H
              .WORD         084H
              .WORD         080H
              .WORD         07CH
              .WORD         078H
              .WORD         074H
              .WORD         070H
              .WORD         06CH
              .WORD         067H
              .WORD         063H
              .WORD         05FH
              .WORD         05BH
              .WORD         057H
              .WORD         053H
              .WORD         04EH
              .WORD         04AH
              .WORD         046H
              .WORD         042H
              .WORD         03EH
              .WORD         039H
              .WORD         035H
              .WORD         031H
              .WORD         02DH
              .WORD         028H
              .WORD         024H
              .WORD         020H
              .WORD         01CH
              .WORD         017H
              .WORD         013H
              .WORD         0FH
              .WORD         0BH
              .WORD         06H
              .WORD         02H

    


              .SECT   ".VEC"
RSVECT		B	START
INT1            B       INT1_DO
INT2            B       LOADCOUNT
INT3            B       DD
         
	       .BSS   	ADDRESS1,1
	       .BSS	COUNT1,1
	       .BSS	COUNT2,1
        	
KICK_DOG	.MACRO
		LDP	#00E0H
		SPLK	#055H,WDKEY
		SPLK	#0AAH,WDKEY
		LDP	#0H
		.ENDM
	.TEXT
START:	SETC  	INTM
	CLRC	SXM
	CLRC	OVM
	CLRC	CNF
	LDP	#00E0H
	SPLK	#006FH,WDCR
        NOP
	KICK_DOG
        CLRC	CNF	;map b0 block to data memory

        
	LDPK    #232
       
        SPLK    #1110000111101010B,GPTCON
        SPLK	#0000011001100110B,ACTR		
	SPLK	#0000000111100000B,DBTCON	

	SPLK	#029AH,T1PR
	SPLK	#0034H,CMPR1
;	SPLK	#0034H,CMPR2
        SPLK    #0100101101010111B,COMCON
        SPLK    #1100101101010111B,COMCON

	SPLK    #0003H,EVIMRA			;enable the int of cmpr1 and pdpint.

	NOP
        SPLK    #0A802H,T1CON
        SPLK    #0A842H,T1CON
	LDP     #0
        LACC    IFR
        SACL    IFR
        SPLK    #0002H,IMR
        CLRC    INTM
        SPLK    #4,COUNT2
	SPLK	#SINWAVE,ADDRESS1
        
  
LOOP:	KICK_DOG        
        NOP
  	CLRC    INTM
        NOP
        NOP
	B       LOOP

LOADCOUNT:      LDP     #232
                LACL    EVIVRA
                SUB     #0021H
                BCND    CHANGE,EQ
		NOP
		NOP
		B	LOOP1               
CHANGE:         NOP
		LDP     #0
		LACC    COUNT2
                ADD     ADDRESS1
                LDP     #232
		TBLR	CMPR1
		LDP     #0
        	LACC    COUNT2
                ADD     #1
                SACL    COUNT2
                SUB     #300
 	        BCND    LOOP1,LT
		NOP
		NOP
		SPLK    #0,COUNT2
LOOP1:	        NOP
		B       LOOP


DD:		B	DD
INT1_DO:	B	INT1_DO

		.END
