IMR     .SET    0004H
IFR     .SET    0006H
SYSCR   .SET    7018H
SYSSR   .SET    701AH
SYSIVR  .SET    701EH

RTICNTR .SET    7021H
WDCNTR  .SET    7023H
WDKEY   .SET    7025H
RTICR   .SET    7027H
WDCR    .SET    7029H

CKCR0   .SET    702BH
CKCR1   .SET    702DH


ADCTRL1	.SET	07032H
ADCTRL2	.SET	07034H
ADCFIFO1.SET	07036H
ADCFIFO2.SET	07038H

SPICCR  .SET    7040H
SPICTL  .SET    7041H
SPISTS  .SET    7042H
SPIBRR  .SET    7044H
SPIEMU  .SET    7046H
SPIBUF  .SET    7047H
SPIDAT  .SET    7049H
SPIPC1  .SET    704DH
SPIPC2  .SET    704EH
SPIPRI  .SET    704FH



SCICCR	.SET	07050H
SCICTL1	.SET	07051H
SCIHBAUD.SET	07052H
SCILBAUD.SET	07053H
SCICTL2	.SET	07054H
SCIRXST	.SET	07055H
SCITXEMU.SET	07056H
SCIRXBUF.SET	07057H
SCITXBUF.SET	07059H
SCIPC2	.SET	0705EH
SCIPRI	.SET	0705FH

XINT1CR .SET    7070H
NMICR   .SET    7072H
XINT2CR .SET    7078H
XINT3CR .SET    707AH


OCRA    .SET    07090H
OCRB    .SET    07092H
PADATDIR.SET    07098H
PBDATDIR.SET    0709AH
PCDATDIR.SET    0709CH
PDDATDIR.SET    0709EH
ISRA    .SET    07094H
ISRB    .SET    07096H

GPTCON  .SET    07400H
T1CNT   .SET    07401H
T1CMPR  .SET    07402H
T1PR    .SET    07403H
T1CON   .SET    07404H
T2CNT   .SET    07405H
T2CMPR  .SET    07406H
T2PR    .SET    07407H
T2CON   .SET    07408H
T3CNT   .SET    07409H
T3CMPR  .SET    0740AH
T3PR    .SET    0740BH
T3CON   .SET    0740CH

COMCON  .SET    07411H
ACTR    .SET    07413H
SACTR   .SET    07414H
DBTCON  .SET    07415H
CMPR1   .SET    07417H
CMPR2   .SET    07418H
CMPR3   .SET    07419H
SCMPR1  .SET    0741AH
SCMPR2  .SET    0741BH
SCMPR3  .SET    0741CH

CAPCON	.SET	7420H
CAPFIFO	.SET	7422H
CAP1FIFO.SET	7423H
CAP2FIFO.SET	7424H
CAP3FIFO.SET	7425H
CAP4FIFO.SET	7426H

EVIMRA	.SET	742CH
EVIMRB	.SET	742DH
EVIMRC	.SET	742EH
EVIFRA	.SET	742FH
EVIFRB	.SET	7430H
EVIFRC	.SET	7431H
EVIVRA	.SET	7432H
EVIVRB	.SET	7433H
EVIVRC	.SET	7434H

WSGR    .SET    0FFFFH

;Bit masks used by the SBIT0 & SBIT1 Macros
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
B15_MSK 	.set	8000h		;Bit Mask for 15
B14_MSK 	.set	4000h		;Bit Mask for 14
B13_MSK 	.set	2000h		;Bit Mask for 13
B12_MSK 	.set	1000h		;Bit Mask for 12
B11_MSK 	.set	0800h		;Bit Mask for 11
B10_MSK 	.set	0400h		;Bit Mask for 10
B9_MSK		.set	0200h		;Bit Mask for 9
B8_MSK		.set	0100h		;Bit Mask for 8
B7_MSK		.set	0080h		;Bit Mask for 7
B6_MSK		.set	0040h		;Bit Mask for 6
B5_MSK		.set	0020h		;Bit Mask for 5
B4_MSK		.set	0010h		;Bit Mask for 4
B3_MSK		.set	0008h		;Bit Mask for 3
B2_MSK		.set	0004h		;Bit Mask for 2
B1_MSK		.set	0002h		;Bit Mask for 1
B0_MSK		.set	0001h		;Bit Mask for 0

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






KICK_DOG	.MACRO
		LDP	#00E0H
		SPLK	#055H,WDKEY
		SPLK	#0AAH,WDKEY
		LDP	#4
		.ENDM


		.TEXT				
CAP1:		SST 	#0,STK1 			;save ST0 - Forced Page 0
		SST 	#1,STK2 			;save ST1 - Forced Page 0
		LDP	#0
		SACL 	STK3 				;save ACCL
		SACH 	STK4 				;save ACCH

		LDP	#232
		LACC	EVIVRC	
		LDP	#232
		LACC	T2CNT
		LDP	#4
		SACL	T2TEMP
		LACC	T2TEMP
		SUB	#2A00H
		BCND	DO2,LT
		LACC	T2TEMP
		SUB	#3A00H
		BCND	DO2,GT
		LACC	EVIFRC
		SACL	EVIFRC


CAPDO:		NOP
	        
         
	        
		LDP	#4
		LACC	NEWCAMP1
		SACL	CAPTEMP4
		LACC	CAPTEMP4
		SUB	#2A0H
		BCND 	DO4,LT
		LDP	#4
		SACL	CAPTEMP2
		LACC	CAPTEMP2
		SUB	#10H
		BCND	DO11,LEQ
		SPLK	#0,SLOW2
		LACC	CAPTEMP2
		SUB	CAPTEMP1
		BCND	DO2,LEQ
		LDP	#232
		LACC	T1PR
		ADD	#1
		SACL	T1PR
		B	DO2	
DO4:		NEG
		LDP	#4
		SACL	CAPTEMP2
		SPLK	#0,SLOW2
		LACC	CAPTEMP2
		SUB	CAPTEMP1
		BCND	DO2,LEQ	
		LDP	#232
		LACC	T1PR
		SUB     #1	
		SACL	T1PR
		B	DO2
DO11:		LDP	#4
		LACC	SLOW2
		ADD	#1
		SACL	SLOW2
		SUB	#8
		BCND	DO16,LT
                SPLK	#8,SLOW2
                SPLK	#1,OUTTAG

DO16:		LDP	#4
		LACC	CAPTEMP4
		SUB	CAPTEMP5
		BCND	DO2,EQ
		LACC	CAPTEMP4
		SUB	#2A0H
		BCND	DO12,EQ
		LDP	#232
		LACC	T1PR
		SUB     #1	
		SACL	T1PR
		B	DO2
DO12:		LDP	#232
		LACC	T1PR
		ADD     #1	
		SACL	T1PR
DO2:		LDP	#4
		LACC	CAPTEMP2
		SACL	CAPTEMP1
		LACC	CAPTEMP4
		SACL	CAPTEMP5
		LDP	#232
		SPLK	#0,T2CNT
		LACC	T1PR
		SUB	#550H
		BCND	DO21,LT
		LACC	T1PR
 		SUB	#1
		SACL	T1PR
DO21:		LACC	T1PR
		SUB	#510H
		BCND	DO22,GT
		LACC	T1PR
		ADD	#1
		SACL	T1PR
DO22:		LDP	#232
		BIT	COMCON,BIT9
		BCND	DO25,NTC
		LDP	#4	
		LACC	SLOW3
		ADD	#1
		SACL	SLOW3
DO25:		NOP
DO126:		CALL	OUTJUDGE


DO125:		LDP	#0
  		ZALH 	STK4 				; restore ACCH
		ADDS 	STK3 				; restore ACCL
		LST 	#1,STK2 			; restore ST1
		LST 	#0,STK1 			; restore ST0
		CLRC 	INTM 				;Enable Interrupts
		
		RET






ACLIMIT:	LDP	#4
        	LACC	LIMIT2
		ADD	PWMADD
		SUB	#1316
		BCND	LJUDGE101,LT
		SPLK	#28AH,LIMIT2
LJUDGE101:	ADD	#1316
		SUB	#16
		BCND	LJUDGE102,GT
		SPLK	#16,LIMIT2
		LACC	LIMIT2
		SUB	PWMADD
		SACL	LIMIT2
LJUDGE102:	RET			


LIMIT:		LDP	#4
        	LACC	LIMIT1
		ADD	PWMADD
		SUB	#1316
		BCND	LJUDGE1,LT
		SPLK	#28AH,LIMIT1
LJUDGE1:	ADD	#1316
		SUB	#16
		BCND	LJUDGE2,GT
		SPLK	#16,LIMIT1
		LACC	LIMIT1
		SUB	PWMADD
		SACL	LIMIT1
LJUDGE2:	RET					

OUTJUDGE:	LDP	#4
		BIT	KEYMODE,BIT15			;�жϰ���״̬,���Ϊֹͣ,��������PWM����
		BCND	DO101,NTC

		LACC	OUTTAG
		BCND	DO101,EQ
		
		LACC	RUNTAG
		BCND	DO101,EQ

		LDP	#4
		LACC	U2AD1
		SUB	#620
		BCND	DO101,LT

DO102:		LDP	#232				;
	        SPLK	#0000100110011001B,ACTR
		SPLK    #1000101001010111B,COMCON
		B	DO103

DO101:		LDP	#232
	     	SPLK	#0000100110011001B,ACTR		;�趨�ĸ�PWM����ļ���
		SPLK    #1000100001010111B,COMCON	;�����ȽϹ���,�����������
DO103:		NOP
		RET
		


DIVIDSUB:	LDP	#4
		LACC	DIVID1
		BCND	DIVIDSUB1,GT
		NEG
		SACL	DIVID1
		RPT	#15
		SUBC	DIVID2
		SACL	DIVRESULT1
		SACH	DIVRESULT2
		LACC	DIVRESULT1
		NEG	
		SACL	DIVRESULT1
		LACC	DIVRESULT2
		NEG
		SACL	DIVRESULT2
		B   	DIVIDSUB2
DIVIDSUB1:	RPT	#15
		SUBC	DIVID2
		SACL	DIVRESULT1
		SACH	DIVRESULT2
DIVIDSUB2:	RET

MPYSUB:		LDP	#4
		LACC	MPY1
		BCND	MPYSUB1,GT
		NEG
		SACL	MPY1
		LT 	MPY1		 		
		MPY 	MPY2				
		PAC 
		NEG
		SACL	MPYRESULT
		B	MPYSUB2
MPYSUB1:	LT	MPY1
		MPY 	MPY2
		PAC 
		SACL	MPYRESULT
MPYSUB2:	RET

		
ADWANT05:	NOP			;0.5
		LDP	#4
		LACC	WDATA4
		ADD	WDATA1
		ADD	WDATA1
		SACL	DIVID1
		SPLK	#12,DIVID2
		CALL	DIVIDSUB
		LACC	DIVRESULT1
		SACL	WDATA6
		LACC	WDATA4
		SUB	WDATA3
		SACL	MPY1
		SPLK	#9,MPY2
		CALL	MPYSUB
		LACC	MPYRESULT
		SFR
		SFR
		SFR
		SFR
		SACL 	WDATA7
		LACC	WDATA2
		SUB	WDATA1
		SACL	MPY1
		SPLK	#3,MPY2
		CALL	MPYSUB
		LACC	MPYRESULT
		SFR
		SFR
		SFR
		SFR
		SACL 	WDATA8
		LACC	WDATA4
		ADD	WDATA6
		ADD	WDATA7
		ADD	WDATA8
		SACL	WDATA5
		RET

PWMWANT05:	NOP			;0.5
		LDP	#4
		LACC	TDATA4
		ADD	TDATA1
		ADD	TDATA1
		SACL	DIVID1
		SPLK	#12,DIVID2
		CALL	DIVIDSUB
		LACC	DIVRESULT1
		SACL	TDATA6
		LACC	TDATA4
		SUB	TDATA3
		SACL	MPY1
		SPLK	#9,MPY2
		CALL	MPYSUB
		LACC	MPYRESULT
		SFR
		SFR
		SFR
		SFR
		SACL 	TDATA7
		LACC	TDATA2
		SUB	TDATA1
		SACL	MPY1
		SPLK	#3,MPY2
		CALL	MPYSUB
		LACC	MPYRESULT
		SFR
		SFR
		SFR
		SFR
		SACL 	TDATA8
		LACC	TDATA4
		ADD	TDATA6
		ADD	TDATA7
		ADD	TDATA8
		SACL	TDATA5
		RET
		


KEYPRESS:	LDP	#0E1H
		LACC	PBDATDIR
		BIT	PBDATDIR,BIT6		;�жϡ�ֹͣ������
		BCND	KEYPRESS2,TC		;���δ����������ж��¸�����
		LDP	#4			;
		LACC	KEYTEMP1		;
		ADD	#1			;��KEYTEMP1�е�ֵ��1
		SACL	KEYTEMP1		;
		SUB	#KEYTEMP2		;��300�Ƚϣ������֮������Ϊ���ˡ�ֹͣ����
		BCND	STOPPRESS,GT		;����ֹͣ�����������
		B	KEYPRESS1		;�����жϣ�������KEYTEMP1��ֵ

KEYPRESS2:	LDP	#0E1H			;
		BIT	PBDATDIR,BIT2		;�жϡ����С�����
		BCND	KEYPRESS3,TC		;���δ��������KEYPRESS3
		LDP	#4			;
		LACC	KEYTEMP1		;
		ADD	#1			;
		SACL	KEYTEMP1		;
		SUB	#KEYTEMP2		;
		BCND	RUNPRESS,GT		;�������а����������
		B	KEYPRESS1		;�����жϣ�������KEYTEMP1��ֵ

KEYPRESS3:	LDP	#0E1H			;
		BIT	PADATDIR,BIT2		;�жϡ�SET������
		BCND	KEYPRESS4,TC		;���δ��������KEYPRESS4
		LDP	#4			;
		LACC	KEYTEMP1		;
		ADD	#1			;
		SACL	KEYTEMP1		;
		SUB	#KEYTEMP2		;
		BCND	SETPRESS,GT		;����SET�����������
		B	KEYPRESS1		;�����жϣ�������KEYTEMP1��ֵ

KEYPRESS4:	LDP	#0E1H			;
		BIT	PBDATDIR,BIT1		;�жϡ�UP������
		BCND	KEYPRESS5,TC		;���δ��������KEYPRESS5
		LDP	#4			;
		LACC	KEYTEMP1		;
		ADD	#1			;
		SACL	KEYTEMP1		;
		SUB	#KEYTEMP2			;
		BCND	UPPRESS,GT		;����UP�����������
		B	KEYPRESS1		;�����жϣ�������KEYTEMP1��ֵ

KEYPRESS5:	LDP	#0E1H			;
		BIT	PADATDIR,BIT3		;�жϡ�RIGHT������
		BCND	KEYPRESS6,TC		;���δ��������KEYPRESS6
		LDP	#4			;
		LACC	KEYTEMP1		;
		ADD	#1			;
		SACL	KEYTEMP1		;
		SUB	#KEYTEMP2			;
		BCND	RIGHTPRESS,GT		;����RIGHT�����������
		B	KEYPRESS1		;�����жϣ�������KEYTEMP1��ֵ

KEYPRESS6:	LDP	#0E1H			;
		BIT	PBDATDIR,BIT0		;�жϡ�DOWN������
		BCND	KEYPRESS7,TC		;���δ��������KEYPRESS7
		LDP	#4			;
		LACC	KEYTEMP1		;
		ADD	#1			;
		SACL	KEYTEMP1		;
		SUB	#KEYTEMP2			;
		BCND	DOWNPRESS,GT		;����DOWN�����������
		B	KEYPRESS1		;�����жϣ�������KEYTEMP1��ֵ

KEYPRESS7:	LDP	#4			;��ʾδ���κμ�����KEYTEMP1ֵ����
		SPLK	#0,KEYTEMP1		;

KEYPRESS1:	RET				;����

;		KEYMODE
;		5432109876543210
;		RS        dutlsr
;               S
;5   : RUN=1 STOP=0
;4 :   SET MODE=1 
;3:




RUNPRESS:	LDP	#0E1H
RUNPRESS1:	CALL	DELAY
		BIT	PBDATDIR,BIT2
		BCND	RUNPRESS1,NTC		;�ȴ���������
		LDP	#4
		SPLK	#0,KEYTEMP1
		LACC	KEYMODE
		OR	#8001H
		SACL	KEYMODE
		B	SHOWJUDGE

DOWNPRESS:	LDP	#0E1H
DOWNPRESS1:	CALL	DELAY
		BIT	PBDATDIR,BIT0
		BCND	DOWNPRESS1,NTC		;�ȴ���������
		LDP	#4
		SPLK	#0,KEYTEMP1
		LACC	KEYMODE
		OR	#0020H
		SACL	KEYMODE
		B	SHOWJUDGE
			

RIGHTPRESS:	LDP	#0E1H
RIGHTPRESS1:	CALL	DELAY
		BIT	PADATDIR,BIT3
		BCND	RIGHTPRESS1,NTC		;�ȴ���������
		LDP	#4
		SPLK	#0,KEYTEMP1
		LACC	KEYMODE
		OR	#0004H
		SACL	KEYMODE
		B	SHOWJUDGE
	

UPPRESS:	LDP	#0E1H
UPPRESS1:	CALL	DELAY
		BIT	PBDATDIR,BIT1
		BCND	UPPRESS1,NTC		;�ȴ���������
		LDP	#4
		SPLK	#0,KEYTEMP1
		LACC	KEYMODE
		OR	#0010H
		SACL	KEYMODE
		B	SHOWJUDGE

STOPPRESS:	LDP	#0E1H
STOPPRESS1:	CALL	DELAY
		BIT	PBDATDIR,BIT6
		BCND	STOPPRESS1,NTC		;�ȴ���������
		LDP	#4
		SPLK	#0,KEYTEMP1
		LACC	KEYMODE
		OR	#8002H
		SACL	KEYMODE
		B	SHOWJUDGE

SETPRESS:	LDP	#0E1H
SETPRESS1:	CALL	DELAY
		BIT	PADATDIR,BIT2
		BCND	SETPRESS1,NTC		;�ȴ���������
		LDP	#4
		SPLK	#0,KEYTEMP1
		LACC	KEYMODE
		XOR	#4008H			;ʹ�����ָ��Ӷ����Դ�SET�������Ƴ�
		SACL	KEYMODE
		
		B	SHOWJUDGE

;		RUN     #0001H
;		STOP	#0002H
;		UP	#0010H
;		DOWN	#0020H
;		RIGHT   #0004H
;		SET	#0008H

SHOWJUDGE:	LDP	#4
		LACC	KEYMODE
		
		BCND	STOPSHOW,EQ

		SUB	#8000H
		BCND	RUNSHOW1,EQ
		
		ADD	#8000H
		SUB	#8008H
		BCND	RUNSHOW1,EQ

		ADD	#8008H
		SUB	#0008H
		BCND	STOPSHOW,EQ

		ADD	#0008H
		SUB	#8002H			;JUDGE IF PRESS STOP IN RUN MODE
		BCND	STOPSHOW,EQ

		ADD	#8002H
		SUB	#8001H			;JUDGE IF PRESS RUN
		BCND    RUNSHOW1,EQ
		
	
		ADD	#8001H			;JUDGE	IF PRESS SET IN STOP MODE
		SUB	#4008H
		BCND	SETSHOW1,EQ		
		
		ADD	#4008H			;JUDGE IF PRESS SET IN RUN MODE
		SUB	#0C008H
		BCND	SETSHOW5,EQ



		ADD	#0C008H			;
		SUB	#8020H			;JUDGE IF PRESS DOWN IN RUN MODE
		BCND	RUNSHOW2,EQ		;SHOW SECOND DATA
		
		ADD	#8020H
		SUB     #4020H			;JUDGE IF PRESS DOWN IN  SET(STOP) MODE
		BCND	SETSHOW2,EQ


		ADD	#4020H
		SUB	#0C020H
		BCND	SETSHOW2,EQ


		ADD	#0C020H
		SUB     #8010H			;JUDGE IF PRESS UP  IN RUN MODE
		BCND	RUNSHOW1,EQ		;SHOW  FIRST DATA
		
		ADD	#8010H			
		SUB 	#4010H			;JUDGE IF PRESS UP IN SET MODE
		BCND 	SETSHOW3,EQ

		ADD	#4010H
		SUB	#0C010H
		BCND	SETSHOW3,EQ

		ADD	#0C010H
		SUB	#4004H			;JUDGE IF PRESS RIGHT IN SET MODE
		BCND	SETSHOW4,EQ

		ADD	#4004H
		SUB	#0C004H
		BCND	SETSHOW4,EQ

		ADD	#0C004H
		AND	#0FF00H			;LET THE KEYMODE LOW 8 BITS=0
		SACL	KEYMODE		
		B	KEYPRESS1
		
		
		
RUNSHOW1:	CALL	CLEAR
		CALL	RUN_SHOW1
		LDP	#4
		SPLK	#8000H,KEYMODE		;NOW IS IN RUN MODE
		B	KEYPRESS1

RUNSHOW2:	CALL	CLEAR
		CALL	RUN_SHOW2
		LDP	#4
		SPLK	#8000H,KEYMODE		;NOW IS IN RUN MODE
		B	KEYPRESS1



STOPSHOW:	CALL 	CLEAR
		CALL 	STOP_SHOW
		LDP	#4
		SPLK	#0000H,KEYMODE		;NOW IS IN STOP MODE
		B	KEYPRESS1

SETSHOW5:	CALL	CLEAR
		CALL	SET_SHOW1
		CALL	DATA_SHOW1
		LDP	#4
		SPLK	#0C000H,KEYMODE
		B	KEYPRESS1



SETSHOW1:	CALL	CLEAR
		CALL	SET_SHOW1
		CALL	DATA_SHOW1
		LDP	#4
		SPLK	#4000H,KEYMODE
		B	KEYPRESS1

SETSHOW2:	CALL	CLEAR
		CALL	SET_SHOW1
		LDP	#4
		LACC	KEYTEMP3
		BCND	SETSHOW21,EQ
		SUB	#1
		SACL	KEYTEMP3
SETSHOW21:	CALL	DATA_SHOW1
		B	KEYPRESS1



SETSHOW3:	CALL	CLEAR
		CALL	SET_SHOW1
		LDP	#4
		LACC	KEYTEMP3
		ADD	#01H
		SUB	#50
		BCND	SETSHOW31,GT
		ADD	#50
		SACL	KEYTEMP3
SETSHOW31:	CALL	DATA_SHOW1
		B	KEYPRESS1

SETSHOW4:	CALL	CLEAR
		CALL	SET_SHOW1	
		CALL	DATA_SHOW1
		B	KEYPRESS1

;--------------------------------------------------------------------
;	��ʱ�ӳ���(���ڰ����Ŀ�����)
;--------------------------------------------------------------------

DELAY:		NOP
		LACC	#5000
DELAY1:		SUB	#1
		BCND	DELAY1,GT
		RET
;--------------------------------------------------------------------
;	RS232�����ж��ӳ���
;--------------------------------------------------------------------

RS232:		SST 	#0,STK1 			;save ST0 - Forced Page 0
		SST 	#1,STK2 			;save ST1 - Forced Page 0
		LDP	#0
		SACL 	STK3 				;save ACCL
		SACH 	STK4 				;save ACCH

		LDP 	#00E0h 			;DP = 224 Address 7000h-707Fh
		LACL 	SYSIVR 			;Load peripheral INT vector address
		LDP 	#0000h 			;DP = 0 Addresses 0000h-007Fh
		SUB	#0006h 			;Subtract RXINT offset from above
		BCND 	RX_ISR,EQ 		;verify RXINT initiated interrupt
		B 	RS2321		;Else, bad interrupt occurred

RX_ISR:		LDP	#0E0H
		LACC	SCIRXBUF	
		SUB  	#004Fh 			;Check to see if ASCII letter 'F'
		BCND 	D1_CHG,EQ 		;If 'F' goto routine to change frequency
		ADD 	#004Fh
		SUB 	#0050h 			;Check to see if ASCII letter 'P'
		BCND 	D2_CHG,EQ 		;If 'P' goto routine to change frequency
		ADD	#0050H
		SUB	#0051H
		BCND	D3_CHG,EQ
		ADD	#0051H
		SUB	#0052H
		BCND	D4_CHG,EQ
		ADD	#0052H
		SUB	#0055H
		BCND	STOP_CHG,EQ
		ADD	#0055H
		SUB	#0060H
		BCND	RUN1_CHG,EQ
		ADD	#0060H
		SUB	#0053H
		BCND	RUN2_CHG,EQ
RS2321:		LDP 	#0 			;DP = 0 Addresses 0000h-007Fh
  		ZALH 	STK4 				; restore ACCH
		ADDS 	STK3 				; restore ACCL
		LST 	#1,STK2 			; restore ST1
		LST 	#0,STK1 			; restore ST0
		CLRC	INTM
		RET


D1_CHG:		LDP	#0
		LACC	INDCCUR1
		RPT	#7
		SFR
		LDP     #00E0H
		SACL	SCITXBUF
XMIT_RDY1: 	BIT 	SCICTL2, BIT7 		;Test TXRDY bit
		BCND 	XMIT_RDY1, NTC 		;If TXRDY=0,then repeat loop
		LDP	#0
		LACC	INDCCUR1
		RPT  	#7
		SFL
		RPT	#7
		SFR
		LDP	#00E0H
		SACL	SCITXBUF
XMIT_RDY2: 	BIT 	SCICTL2, BIT7 		;Test TXRDY bit
		BCND 	XMIT_RDY2, NTC 		;If TXRDY=0,then repeat loop
		B 	RS2321



D2_CHG:		LDP	#4
		LACC	DCVOL1USE
		RPT	#7
		SFR
		LDP     #00E0H
		SACL	SCITXBUF
XMIT_RDY3: 	BIT 	SCICTL2, BIT7 		;Test TXRDY bit
		BCND 	XMIT_RDY3, NTC 		;If TXRDY=0,then repeat loop
		LDP	#4
		LACC	DCVOL1USE
		RPT  	#7
		SFL
		RPT	#7
		SFR
		LDP	#00E0H
		SACL	SCITXBUF
XMIT_RDY4: 	BIT 	SCICTL2, BIT7 		;Test TXRDY bit
		BCND 	XMIT_RDY4, NTC 		;If TXRDY=0,then repeat loop
		NOP
		B 	RS2321


D3_CHG:		LDP	#4
		LACC	ADDATA
		RPT	#7
		SFR
		LDP     #00E0H
		SACL	SCITXBUF
		LACC	SETCURRENT1
		SACL	SCITXBUF
XMIT_RDY5: 	BIT 	SCICTL2, BIT7 		;Test TXRDY bit
		BCND 	XMIT_RDY5, NTC 		;If TXRDY=0,then repeat loop
		LDP	#4
		LACC	ADDATA
		RPT  	#7
		SFL
		RPT	#7
		SFR
		LDP	#00E0H
		SACL	SCITXBUF
		B 	RS2321


D4_CHG:		LDP	#4
		LACC	TDATA5
		RPT	#7
		SFR
		LDP     #00E0H
		SACL	SCITXBUF
XMIT_RDY7: 	BIT 	SCICTL2, BIT7 		;Test TXRDY bit
		BCND 	XMIT_RDY7, NTC 		;If TXRDY=0,then repeat loop
		LDP	#4
		LACC	TDATA5
		RPT  	#7
		SFL
		RPT	#7
		SFR
		LDP	#00E0H
		SACL	SCITXBUF
XMIT_RDY8: 	BIT 	SCICTL2, BIT7 		;Test TXRDY bit
		BCND 	XMIT_RDY8, NTC 		;If TXRDY=0,then repeat loop
		NOP
		B 	RS2321


STOP_CHG:	LDP	#4

		LDP	#0E0H
		B	RS2321

RUN1_CHG:	LDP	#4

		LDP	#0E0H
		B	RS2321		

RUN2_CHG:	LDP	#4

		LDP	#0E0H
		B	RS2321		