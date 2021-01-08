
WSR         EQU  0014H
IMASK1      EQU  0013H
IPEND1      EQU  0012H
WATCHDOG    EQU  000AH
IPEND       EQU  0009H
IMASK       EQU  0008H
PIPEND      EQU  1FBEH
PIMASK      EQU  1FBCH

P4PIN       EQU  1FFFH
P3PIN       EQU  1FFEH
P4REG       EQU  1FFDH
P3REG       EQU  1FFCH

P5PIN       EQU  1FF7H
P5REG       EQU  1FF5H
P5DIR       EQU  1FF3H
P5MODE      EQU  1FF1H

P2PIN       EQU  1FD6H
P2REG       EQU  1FD4H
P2DIR       EQU  1FD2H
P2MODE      EQU  1FD0H

P1PIN       EQU  1FA9H
P0PIN       EQU  1FA8H

ADTIME      EQU  1FAFH
ADTEST      EQU  1FAEH
ADCOM       EQU  1FACH
ADRES       EQU  1FAAH

T2CON       EQU  1F7CH
T1CON       EQU  1F78H

CAP2CON     EQU  1F48H
CAP2T       EQU  1F4AH
CAP1CON     EQU  1F44H
CAP1T       EQU  1F46H
SP          EQU  0018H
AX          EQU  0020H
AL          EQU  0020H
BX          EQU  0022H
BL          EQU  0022H
CX          EQU  0024H
CL          EQU  0024H
CH          EQU  0025H
DX          EQU  0026H
DL          EQU  0026H
EX          EQU  0028H
EL          EQU  0028H
EH          EQU  0029H
FX          EQU  002AH
FL          EQU  002AH
FH          EQU  002BH
GX          EQU  002CH
GL          EQU  002CH
HX          EQU  002EH
HL          EQU  002EH
IX          EQU  0030H
IXL         EQU  0030H
IXH         EQU  0031H
JX          EQU  0034H
JXL         EQU  0034H
JXH         EQU  0036H
KX          EQU  0038H
LX          EQU  0060H
ML          EQU  0062H

SINK        EQU  003AH
IM          EQU  3CH
SXWE        EQU  3EH
BWFLAG      EQU  40H
STOPFLAG    EQU  41H
UD          EQU  42H
IA          EQU  44H
IB          EQU  46H
UA          EQU  48H
UB          EQU  4AH
XWFLAG      EQU  4BH
HEX0        EQU  4CH
HEX0L       EQU  4CH
HEX0H       EQU  4DH
HEX2        EQU  4EH
DIS1        EQU  50H
DIS2        EQU  52H
DIS3        EQU  54H
BUFF0       EQU  56H
IM1         EQU  58H
IM1L        EQU  58H
IM1H        EQU  59H
IM2         EQU  5AH
IM3         EQU  5CH

  ORG   2500H
   DCB 03H,9FH,25H,0DH
   DCB 99H,49H,041H,01FH
   DCB 01H,19H,11H,0C1H
   DCB 0E5H,85H,61H,71H

   ORG 4000H
   DCB 1,2,3,4
   DCB 5,5,6,7,8,9

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ORG   2600H
  DCB 128, 120
  DCB 112, 104
  DCB 96, 89
  DCB 81,74
  DCB 67,60
  DCB 53,47
  DCB 41,35
  DCB 30,25
  DCB 21,17
  DCB 13,10
  DCB 7,5
  DCB 3,2
  DCB 1,1
  DCB 1,2
  DCB 3,5
  DCB 7,10
  DCB 13,17
  DCB 21,25
  DCB 30,35
  DCB 41,47
  DCB 53,60
  DCB 67,74
  DCB 81,89
  DCB 96,104
  DCB 112,120
  DCB 128,136
  DCB 144,152
  DCB 160,167
  DCB 174,182
  DCB 189,196
  DCB 203,209
  DCB 215,221
  DCB 226,231
  DCB 235,239
  DCB 243,246
  DCB 249,251
  DCB 253,254
  DCB 255,255
  DCB 255,254
  DCB 253,251
  DCB 249,246
  DCB 243,239
  DCB 235,231
  DCB 226,221
  DCB 215,209
  DCB 203,196
  DCB 189,182
  DCB 175,167
  DCB 160,152
  DCB 144,136
  DCB 128,120
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ORG   2018H
  DCW  20CDH,20DCH
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ORG   2008H
  DCW  3000H
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ORG   200CH
  DCW  3300H
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ORG  2080H                   ;MAIN PROGRAM
	DI
	LD SP,#0200H
	CLR HX
	CLRB XWFLAG
	CLRB STOPFLAG
	CLR IM
	LD LX,#400
;--------------------------------------------------------
	CLRB IMASK1                  ; SET UP INT-REGSTERs
	LDB IMASK,#01010000B
	LDB AL,#00H
	STB AL,PIMASK[0]
;--------------------------------------------------------
	LDB AL,#0FFH                 ; SET UP P5
	STB AL,P5REG[0]
	LDB AL,#80H
	STB AL,P5DIR[0]
	LDB AL,#0FFH
	STB AL,P5MODE[0]
;--------------------------------------------------------

	LDB AL,P2REG[0]              ; SET UP P2
	ORB AL,#00000110B
	STB AL,P2REG[0]
	LDB AL,P2DIR[0]
	ORB AL,#00000111B
	ANDB AL,#00000111B
	STB AL,P2DIR[0]
	LDB AL,P2MODE[0]
	ORB AL,#00000110B
	ANDB AL,#00000110B
	STB AL,P2MODE[0]
;--------------------------------------------------------
	LDB AL,#00100100B            ;SET UP CAP1COMP_CON
	STB AL,CAP1CON[0]
;-------------------------------------------------------
	LDB AL,#11000000B            ;SET UP T1_CON
	STB AL,T1CON[0]
	LDB AL,#01000000B            ; SET UP CAP2COMP_CON
	STB AL,CAP2CON[0]
;--------------------------------------------------------
	LDB DL,#01100111B            ; SETUP  A/D
	STB DL,ADTIME[0]
;--------------------------------------------------------
;                                    ;SET DISPLAY 8279
	LD AX,#0A000H
	LD  BX,#0A001H;
	LDB CL,#00000101B
	STB CL,[BX]
	LDB CL,#00100100B
	STB CL,[BX]
	LDB CL,#11011111B
	STB CL,[BX]


;-------------------------------------------------------
MAIN:   LCALL CVER2
	LD HEX0,IM2
	LCALL HEX_D
;       LD DIS3,#DATA
	LCALL DISPLAY
;--------------------------------------------------------
	CLRB EL
	STB EL,ADTEST[0]
	LDB EL,#00110111B;          ;ACH7  A/D
	STB EL,ADCOM[0]
T_IM1:  LD EX,ADRES[0]
	JBS EX,4,T_IM1
	SHR EX,#8                    ;GET IM
	LD IM,EX
	LCALL CVER3
	STB IM3,6001H[0]

	LCALL CVER2
	LD HEX0,IM2
	LCALL HEX_D
;       LD DIS3,#DATA
	LCALL DISPLAY
;----------------------------------------------------

	LDB EL,#00111000B           ;ACH8  A/D
	STB EL,ADCOM[0]
T_SXW1: LD EX,ADRES[0]
	JBS EX,4,T_SXW1
	SHR EX,#8
	DIVUB EX,#5
	ADDB EL,XWFLAG
	CLRB EH
	LDB IXL,#01000000B
	STB IXL,0A001H[0]
	LDB IXL,0A000H[0]
	JBS IXL,3,T_SXW2
	LD SXWE,EX ;                ;GET SXWE
	SJMP T_SXW3
T_SXW2: LD  IX,#100
	SUB SXWE,IX,EX
T_SXW3: NOP

;-------------------------------------------------------
;  INPUT UD AND ID STOP FOR  LOWER UD
;-------------------------------------------------------
	LDB EL,#00H
	STB EL,ADTEST[0]
	LDB EL,#00110010B
	STB EL,ADCOM[0]
TUD1:   LD EX,ADRES[0]
	JBS EX,4,TUD1
	SHR EX,#8
;       LD  UD,EX
	LD UD ,#120
	CMP UD,#90
	JLE UDLOW1
	CMP UD,#150
	JGE UDUP1
	LJMP TUAUB1
UDLOW1: LCALL STOP
	LCALL DELAY
	LJMP MAIN
UDUP1:  LCALL STOP
	LCALL DELAY
	LJMP MAIN

;-------------------------------------------------------
;TEST UB AND UA,NORMAL OR ERRO ?
;-------------------------------------------------------------
					    ;  180us < T < 220us
TUAUB1: CMP LX,#360
;       CMP LX,#135
	JLE TUA1
	CMP LX,#440
;       CMP LX,#165
	JGE TUA1
	CLRB STOPFLAG
	LCALL OPEN
	LJMP T_RUN
TUA1:   LDB STOPFLAG,#0FFH
	LCALL STOP
;       LCALL DELAY
	LJMP MAIN
       
;---------------------------------------------------------
;   LOGICAL  CONTROL
;---------------------------------------------------------
T_RUN:  LDB IXL,#01000000B
	STB IXL,0A001H[0]
	LDB IXL,0A000H[0]
	JBS IXL,7,TRUN1
	LCALL OPEN
	LJMP  RUN
TRUN1:  LCALL STOP
	LCALL DELAY
	LJMP MAIN
;--------------------------------------------------------------
;  INPUT IM AND SXWE
;---------------------------------------------------------------
RUN:    EI
	LJMP MAIN


;-------------------------------------------------------------
;*************************************************************
;-------------------------------------------------------------


	ORG 3000H                    ;PROGRAM OF CAP1CMOP-INT
	PUSHA



	LD BX,SXWE
	LDB CL,#100
	CLRB CH
	SUB CX,BX
	LDB AL,2600H[BX]
	STB AL,6000H[0]
	INC BX
	DECB CL
	LD GX,CAP1T[0]               ;GX=TIME OF CAP1COMP-INT
	SUB JX,GX,HX                 ;JX=GX-HX
	LD HX,GX                     ;HX=GX
	CLR JXH
	DIVU JX,#100                ;JX=(GX-IX)/100
	LD LX,JXL
;-----------------------------------------------------------
	ADD SINK,JXL,GX          ;CAP2COMP_ TIME=CAP1COMP_TIME+IL
	ST SINK,CAP2T[0]

	EI
	POPA
	RET
;*************************************************************
;-------------------------------------------------------------


	ORG 3300H                   ;PROGRAME OF CAP2COMP-INT
	DI
	PUSHA
	LDB AL,2600H[BX]
	STB AL,6000H[0]
	INC BX
	DECB CL
	JNE LOOP1
	LD BX,#0
	LDB CL,#100

LOOP1:  ADD SINK,JXL,SINK        ;CAP2COMP_TIME=CAP2COMP_TIME+IX
	ST SINK,CAP2T[0]
;--------------------------------------------------------------
;TEST UB IA AND OUTPUT CONTROL MODEL I/O
;-------------------------------------------------------------
	POPA
	EI
	RET
;-----------------------------------------------------------


HEX_D:  LD IX,#0
	LD HEX2,#4
CVER1:  DIVUB HEX0,#10

	STB HEX0H,4000H[IX]
	INC IX

	CLRB HEX0H
	DJNZ HEX2,CVER1
	RET
;-----------------------------------
DISPLAY:LDB DIS1,#10010000B
	STB DIS1,0A001H[0]
	LD IX,#4
	CLR DIS1
DSPL2:  DEC IX
	LDB DIS1,4000H[IX]
	LD DIS2,2500H[DIS1]
	STB DIS2,0A000H[0]
	CMP IX,#0
	JNE DSPL2
	RET
;-------------------------------------
CVER2:  LD IM1,IM
	MULU IM1,#10
	DIVUB IM1,#17
	CLRB IM1H
	LD IM2,IM1
	RET
;------------------------------------
CVER3:  LD IM1,IM
	MULU IM1,#33
	SUB IM1,#1275
	DIVUB IM1,#10
	CLRB IM1H
	LD IM3,IM1
	RET
;---------------------------------------------------------
OPEN:   LDB ML,P2REG[0]              ; SET UP P2
	ORB ML,#00010000B
	STB ML,P2REG[0]
	RET
;--------------------------------------------------------
STOP:   LDB ML,P2REG[0]              ; SET UP P2
	ANDB ML,#11101111B
	STB ML,P2REG[0]
	RET
;------------------------------------
DELAY:  LD DX,#6
DEL1:   LD KX,#0FFFFH
DEL2:   NOP
	DEC KX
	JNE DEL2
	DEC DX
	JNE DEL1
	RET
;-----------------------------------------------------------
	END






































































































































































