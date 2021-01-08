; THIS IS  TEST PROGRAM===d105.ASM

	        .INCLUDE   "INIT105.H"		;加入变量定义，同步程序以及一些子程序
        	.INCLUDE   "PWM.H"		;加入85%和25%脉宽表格，85%表格用于同步程序，以及电流的微调，25%脉宽表格，该表格用于输出电流
		.INCLUDE   "PWMS105.H"		;加入PWM定时器中断子程序
		.INCLUDE   "SHOW105.H"		;加入LCD显示的通用子程序和变量定义


                .SECT   ".VEC"
RSVECT		B	START			;跳至程序开始
INT1            B       DD        		;中断1，暂时未用
INT2            B       LOADCOUNT		;PWM定时器中断
INT3            B       DD			;未用
INT4		B	CAP1			;同步捕捉中断
INT5		B	RS232			;RS232通讯中断
         
		.BSS	DIVID1,1		;被除数（用于除法子程序）
		.BSS	DIVID2,1		;除数（用于除法子程序）
		.BSS	DIVRESULT1,1		;商（用于除法子程序）
		.BSS	DIVRESULT2,1		;余数（用于除法子程序）
		.BSS	MPY1,1			;被乘数（用于乘法子程序）
		.BSS	MPY2,1			;乘数（用于乘法子程序）
		.BSS	MPYRESULT,1		;乘积（用于乘法子程序）
	       	.BSS   	PWMADDRESS,1		;PWM表的起始数据地址
		.BSS	PWMADDRESS1,1		;PWM9表的起始数据地址
		.BSS	PWMADDRESS4,1		;独立逆变电压表的起始数据地址
		.BSS	SPWM2,1			;和电网电压相对应的脉宽，以抵消电网电压
		.BSS	SPWM1,1			;和输出电流的设定值相对应的PI比例环节调节系数
		.BSS	ADCALU1,1		;用于临时存储输出电流设定值对应的表格数据，和PWMCOUNT3相对应
	       	.BSS	PWMCOUNT1,1		;表格指针1，用于
		.BSS	PWMCOUNT2,1		;表格指针2，用于
		.BSS	PWMCOUNT3,1		;表格指针3，用于
		.BSS	PWMCOUNT4,1		;表格指针4，用于独立逆变时标准电压表格
		.BSS	PWMADD,1		;PWM表格的中间值，EVERY PWM PULSE ADD VALUE=T/4;WHEN T=20/150MS  PWMADD=666
		.BSS	ADDATA,1		;AC CURRENT 输出交流电流的A/D值
		.BSS	ADDATA1,1		;AC CURRENT 输出交流电流的第一次A/D值
		.BSS	ADDATA2,1		;AC CURRENT 输出交流电流的第二次A/D值
		.BSS	ADDATA3,1		;ADDATA3用于选用AC CURRENT A/D 过程的暂存值
		.BSS	ADDATA4,1		;同上
		.BSS	ADDATA5,1		;同上
		.BSS	NEWCAMP1,1		;85%PWM表格数据，用于同步程序
		.BSS	NEWCAMP7,1		;存储输出交流电流微调时85%PWM表格数据
		.BSS	NEWCAMP2,1		;输出交流电流微调时输出值
		.BSS	NEWCAMP21,1		;输出交流电流微调时计算中间值
		.BSS	NEWCAMP,1		;输出交流电流设定值的PWM数据
		.BSS	NEWCAMP3,1		;输出交流电流计算中间值
		.BSS	NEWCAMPT1,1		;输出交流电流微调时进行积分计算的中间值
		.BSS	NEWCAMPT2,1		;输出交流电流的最后输出脉宽
		.BSS	SLOW2,1			;用于同步程序，当SLOW=8，即连续8次同步对准后，才打开PWM口
		.BSS	SLOW3,1			;用于输出电流的软启动
		.BSS	T2TEMP,1		;用于临时存放两个同步脉冲之间的时间间隔 
		.BSS	CAPTEMP1,1		;用于同步程序
		.BSS	CAPTEMP2,1		;同上
		.BSS	CAPTEMP3,1		;同上
		.BSS	CAPTEMP4,1		;同上
		.BSS	CAPTEMP5,1		;同上
		.BSS	FDATA1,1		;用于交流微调的积分调节环节
		.BSS	FDATA2,1		;同上
		.BSS	FDATA3,1		;同上	
		.BSS	FDATA4,1		;同上
		.BSS	WDATA1,1		;存储输出交流电流的A/D值（减去了中间值）1
		.BSS	WDATA2,1		;存储输出交流电流的A/D值（减去了中间值）2
		.BSS	WDATA3,1		;存储输出交流电流的A/D值（减去了中间值）3
		.BSS	WDATA4,1		;存储输出交流电流的A/D值（减去了中间值）4
		.BSS	WDATA5,1		;用于输出交流电流的A/D值预估计算	
		.BSS	WDATA6,1		;同上
		.BSS	WDATA7,1		;同上
		.BSS	WDATA8,1		;同上
		.BSS	PWMK2,1			;用于输出交流电流微调积分计算的系数
STK1		.usect "B2",1			;用于中断程序调用时保留现场
STK2 		.usect "B2",1			;同上		
STK3 		.usect "B2",1			;同上
STK4 		.usect "B2",1			;同上
INDCCUR1	.USECT "B2",1			;前级输入直流电流
INDCCUR2	.USECT "B2",1			;后级输入直流电流
		.BSS	LIMIT1,1		;用于数据限幅子程序
		.BSS	PWMAD1,1		;存储交流输出电流的第一次A/D值
		.BSS	PWMAD2,1		;存储交流输出电流的第二次A/D值
		.BSS	PWMAD,1			;存储交流输出电流A/D经过调整后的值
		.BSS	TDATA1,1		;用于发送抵消电网电压的脉冲宽度的预估（1/2T）运算
		.BSS	TDATA2,1		;同上
		.BSS	TDATA3,1		;同上
		.BSS	TDATA4,1		;同上
		.BSS	TDATA5,1		;同上
		.BSS	TDATA6,1		;同上
		.BSS	TDATA7,1		;同上
		.BSS	TDATA8,1		;同上
		.BSS	PWMM1,1			;用于计算抵消电网电压的脉冲宽度的A/D值的转换系数
		.BSS	U2AD1,1			;后级直流电压A/D值
		.BSS	U2K1,1			;用于计算输出交流电流设定值的PWM值NEWCAMP的系数
		.BSS	ADK1,1			;和输出电流的设定值相对应的PI比例环节调节系数
		.BSS	SETCURRENT1,1		;实际用于输出的给定电流值
		.BSS	AD1MID,1		;交流输出电压（电流电网）A/D转换中间值AC VOL  AD BASE
		.BSS	AD2MID,1		;交流输出电流A/D转换中间值	AC CUR  AD BASE
		.BSS	KEYTEMP1,1		;按键防抖动计数器
		.BSS	KEYTEMP3,1		;设定记数器
		.BSS	KEYTEMP4,1		;设定位置计数器
KEYTEMP2	.SET	400			;按键防抖动常数
		.BSS	KEYMODE,1		;按键状态标志
		.BSS	SHOWMODE,1		;显示的状态标志	
		.BSS	OUTDATA,1		;显示输出数据，用于显示初始化
		.BSS	SHOWCOM,1		;子程序中的显示命令
		.BSS	SHOWDAT,1		;子程序中的显示数据
		.BSS	SHOWTEMP1,1		;页面地址暂存器
SHOWPD1		.SET	0032H			;液晶常量定义
		.BSS	SHOWTEMP2,1		;字符字模块首地址
		.BSS	SHOWCOLUMN,1		;LCD列地址
		.BSS	SHOWPAGE,1		;LCD页地址
		.BSS	SHOWCODE,1		;字符代码寄存器
		.BSS	SHOWCOUNT1,1		;显示计数器
		.BSS	SHOWTEMP3,1		;辅助地址寄存器
		.BSS	KEYTEMP31,1		;用于存储设定电流显示值的十位数字
		.BSS	KEYTEMP32,1		;用于存储设定电流显示值的个位数字
		.BSS	DCVOL1,1		;输入的直流电压
		.BSS	DCVOLLIM1,1		;输入的直流电压的工作下限
		.BSS	DCVOLLIM2,1		;输入的直流电压的工作上限
		.BSS	OUTTAG,1		;脉冲输出标志单元,1表示输出脉冲状态,0表示停止输出脉冲状态
		.BSS	ACVOL2,1		;独立逆变时输出的交流电压值
		.BSS	ACVOL21,1		;独立逆变时输出的交流电压值临时1
		.BSS	ACVOL22,1		;独立逆变时输出的交流电压值临时2		
		.BSS	AD3MID,1		;独立逆变时输出的交流电压值中间值
		.BSS	PDATA1,1		;用于独立逆变电压调节的积分环节
		.BSS	PDATA3,1
		.BSS	ACVOLDAT1,1		;从独立逆变时输出的交流电压表格中读出的值
		.BSS	ACVOLDAT2,1
		.BSS	ACVOLDAT3,1
		.BSS	ACVOLDAT4,1
		.BSS	ACVOLDAT5,1
		.BSS	ACVOLDAT6,1
		.BSS	VDATA1,1
		.BSS	VDATA2,1
		.BSS	VDATA3,1
		.BSS	VDATA4,1
		.BSS	ACVOLK1,1
		.BSS	ACVOLK2,1
		.BSS	ACVOLK4,1		;电压调整时积分环节的系数
		.BSS	LIMIT2,1		;独立逆变输出的限幅判断辅助寄存器
		.BSS    ACVOLAVE,1		;独立逆变采集电压的实际平均值
		.BSS	ACVOLSET,1		;独立逆变采集电压的平均值的给定值
		.BSS	ACVOLCOU,1		;独立逆变采集电压的累积值
		.BSS	ACLEAVE,1		;用于独立逆变时PI调节时积分环节的除法的余数
		.BSS	PWMCOUNT5,1		;用于独立逆变时每个75点PI调节一次
		.BSS	ACLEAVE1,1		;用于独立逆变时PI调节除法的余数
		.BSS	DCVOL1AVE,1
		.BSS	DCVOL1NO,1
		.BSS	DCVOL1USE,1
		.BSS	DATA_S,1
		.BSS	DATA_D2,1
		.BSS	DATA_D3,1
		.BSS	DATA_D4,1
		.BSS	D_INCUR,1
		.BSS	RUNTAG,1
LENGTH1 .SET    00007H				;用于RS232串口通讯
LENGTH2	.SET	00016H				;用于RS232串口通讯
LENGTH3	.SET	0001BH				;用于RS232串口通讯		
LENGTH4 .SET	00020H				;用于RS232串口通讯
B2_SADDR.SET    00060H				;用于RS232串口通讯
B0_SADDR.SET    00200H				;用于RS232串口通讯
B1_SADDR.SET	00300H				;用于RS232串口通讯
		
		
	.TEXT
	NOP
START:	SETC  	INTM				;关闭中断
	CLRC	SXM				;SXM标识运算时是否为有符号数，CLRC 表示为无符号数
	CLRC	OVM				;
	CLRC	CNF				;
	LDP	#00E0H				;
	SPLK	#006FH,WDCR			;关闭看门狗
        NOP
	KICK_DOG				;看门狗计数器复位
	LDP     #0
	NOP
        SPLK    #001AH,IMR			;使能 INT4 AND INT2 and int5
        NOP
        LACC    IFR				;
	NOP
	NOP
        SACL    IFR				;清除中断记录
	NOP
	NOP



	LDP	#00E1H
	SPLK	#00H,OCRA
	SPLK	#01CH,OCRB

	CALL	STARTDELAY1

	LACC	PCDATDIR
	AND	#0FEFFH
	SACL	PCDATDIR
	BIT	PCDATDIR,BIT0
	BCND	START1,NTC
	LDP	#0E0H
	LACC	SYSCR
	OR	#08000H
	SACL	SYSCR
	
	LDP	#0E1H
	BIT	PADATDIR,BIT1
	BCND	START1,NTC
	LDP	#0E0H
	LACC	SYSCR
	OR	#08000H
	SACL	SYSCR


	LDP	#0E1H
	BIT	PCDATDIR,BIT6
	BCND	START1,NTC
	LDP	#0E0H
	LACC	SYSCR
	OR	#08000H
	SACL	SYSCR



START1:	NOP
	LDP	#00E1H
	LACC	PBDATDIR
	AND	#1011100011111111B		;将PB.0(DOWN) and  PB.1(^) and PB.2(RUN) PB.6(STOP)  设为输入
	SACL	PBDATDIR

	LACC	PADATDIR
	AND	#1111001111111111B		;将PA.2(SET) and  PA.3(>)  设为输入
	SACL	PADATDIR

	LDP	#00E1H
	LACC	PCDATDIR			;将PC.5设为输出端，控制前级的输出
	OR	#0010000000100000B
	SACL	PCDATDIR			;开机时输出为1,封锁前级


	LDP	#4
	SPLK	#0,KEYMODE			;初始化  keymode=00h
	SPLK	#0,KEYTEMP3			;初始化  KEYTEMP3=0H	
	SPLK	#0,KEYTEMP4			;初始化  KEYTEMP4=0H

	LDP	#0E0H	
	SPLK 	#0000000001100000b,CKCR1
	SPLK 	#0000000000000001b,CKCR0	; Disable PLL
	NOP
	NOP
	SPLK 	#0000000011000001b,CKCR0	; Re-enable PLL

	LDP	#224
	NOP
	NOP
	SPLK	#00H,XINT3CR			;pwm 2 the uv singal

	LDP	#0E1H
	LACC	PADATDIR
	OR	#0200H
	AND	#0FFFDH
	SACL	PADATDIR			;独立逆变继电器打开

	LDP	#0E1H
	LACC	PCDATDIR
	OR	#04000H
	AND	#0FFBFH
	SACL	PCDATDIR			;并网继电器打开

	

	LDP	#0E0H
	SPLK	#00H,SPIPC2			;定义SPISIMO,SPISOMI两个引脚为标准输入引脚
;--------------------------------------------------------------------
;	SCI 串口通讯中断的初始化 （目前未使用）
;--------------------------------------------------------------------

SCI_INIT:	LDP	#00E0H
		SPLK	#0037H,SCICCR
		SPLK	#0013H,SCICTL1
		SPLK	#0002H,SCICTL2
		SPLK    #0000H,SCIHBAUD
 		SPLK    #0040H,SCILBAUD 	;RATE=19200B/S
		SPLK    #0022H,SCIPC2
		SPLK	#0033H,SCICTL1
		SPLK	#01100000B,SCIPRI
		LAR	AR0,#SCITXBUF
		LAR	AR1,#SCIRXBUF
		LAR   	AR2,#B1_SADDR 		;Load AR2 with TX data start address
 		LAR 	AR3,#B0_SADDR

;--------------------------------------------------------------------
;	设置PWM模块
;--------------------------------------------------------------------

	LDP     #232
	NOP
	SPLK	#03H,T2CNT			;设定T2为同步脉冲间隔时间，即为电网的电压周期
	SPLK	#0FFFFH,T2PR
	SPLK	#07FFFH,T2CMPR			;20MS =30D4H(1/32 CPUCLK)
	NOP
	NOP
	SPLK    #1001010101000000B,T2CON	;T2定时器的控制设定
	NOP
	SPLK	#1010000010000000B,CAPCON	;使能捕捉中断
	SPLK	#0000100110011001B,ACTR		;设定四个PWM输出引脚的有效电平
	NOP
	NOP
        SPLK    #1110000000101010B,GPTCON	;设定GP定时器控制寄存器	
	NOP
	NOP
	SPLK	#0000010111111000B,DBTCON	;死区设定，使用了X/8的CPU时钟频率，大致为2ms
	NOP
	NOP
	SPLK	#0535H,T1PR			;设定PWM定时器的周期时间，因为使用中心对称的PWM方式，所以其值为实际值的1/2
	NOP
	NOP
	SPLK    #0081H,EVIMRA			;使能 the int of cmpr1 and pdpint.
	SPLK	#0001B,EVIMRC			;使能CAP1中断		
	NOP
        SPLK    #0A802H,T1CON			;T1定时器的控制设定
	NOP
        SPLK    #0A842H,T1CON			;启动T1定时器
	NOP
	NOP
        SPLK    #0000100001010111B,COMCON	;初步设定全比较功能寄存器
	NOP
	NOP
;--------------------------------------------------------------------
;	清除所有的EV事件中断
;--------------------------------------------------------------------

	LDP	#232
	NOP
	LACC	EVIFRA
	NOP
	SACL	EVIFRA
	NOP
	LACC	EVIFRB
	NOP
	SACL	EVIFRB
	NOP
	LACC	EVIFRC
	NOP
	SACL	EVIFRC
	NOP
;--------------------------------------------------------------------
;	显示的初始化及显示停机信息
;------------------------------------------------------------------


	CALL	SHOWINT			;调用显示初始化子程序
	CALL	CLEAR			;调用清屏子程序
	CALL    STOP_SHOW		;调用停止状态显示子程序

;--------------------------------------------------------------------
;	变量的初始化
;--------------------------------------------------------------------

	LDP	#4
	SPLK	#0,SLOW2
	SPLK	#0,VDATA1
	SPLK	#0,VDATA2
	SPLK	#0,VDATA3
	SPLK	#0,VDATA4
	SPLK	#0,ACVOLDAT1
	SPLK	#0,ACVOLDAT2
	SPLK	#0,ACVOLDAT3
	SPLK	#0,ACVOLDAT4
	SPLK	#0,ACVOLDAT5
	SPLK	#0,ACVOLDAT6
	SPLK	#0,FDATA1
	SPLK	#0,FDATA2
	SPLK	#0,FDATA3
	SPLK	#0,FDATA4
	SPLK	#0,WDATA1
	SPLK	#0,WDATA2
	SPLK	#0,WDATA3
	SPLK	#0,WDATA4
	SPLK	#0,WDATA5	
	SPLK	#0,WDATA6
	SPLK	#0,WDATA7
	SPLK	#0,WDATA8
	SPLK	#0,ADDATA1
	SPLK	#0,ADDATA2
	SPLK	#0,ADDATA3
	SPLK	#0,ADDATA4
	SPLK	#0,ADDATA5
	SPLK	#0,SPWM2
	SPLK	#0,ADCALU1
	SPLK	#0,LIMIT1
	SPLK	#0,PWMAD1
	SPLK	#0,PWMAD2
	SPLK	#0,PWMAD
	SPLK	#0,TDATA1
	SPLK	#0,TDATA2
	SPLK	#0,TDATA3
	SPLK	#0,TDATA4
	SPLK	#0,TDATA5
	SPLK	#0,TDATA6
	SPLK	#0,TDATA7
	SPLK	#0,TDATA8
	SPLK	#0,VDATA1
	SPLK	#0,VDATA2
	SPLK	#0,VDATA3
	SPLK	#0,VDATA4
	SPLK	#0,U2AD1
	SPLK	#0,SETCURRENT1
	SPLK	#0,NEWCAMP2
	SPLK	#0,NEWCAMP21
	SPLK	#0,NEWCAMP7
	SPLK	#0,NEWCAMP3
	SPLK	#0,NEWCAMPT1
	SPLK	#0,KEYTEMP31
	SPLK	#0,KEYTEMP32
	SPLK	#0,T2TEMP			;T2TEMP用于临时存放两个同步脉冲之间的时间间隔 
	SPLK	#0,ACVOLAVE			;独立逆变采集电压的实际平均值
	SPLK	#0,DCVOL1AVE
	SPLK	#0,DCVOL1NO
	SPLK	#198,ACVOLSET			;独立逆变采集电压的平均值的给定值
	SPLK	#0,ACVOLCOU			;独立逆变采集电压的累积值

	SPLK	#666,PWMADD	
	SPLK	#6,SPWM1	
	SPLK	#45,ADK1
	SPLK	#504,AD1MID
	SPLK	#513,AD2MID	
	SPLK	#507,AD3MID
	SPLK	#7,U2K1
	SPLK	#0100H,PWMK2
	SPLK	#25,PWMM1
	SPLK    #0,PWMCOUNT1			;指针1初始值
	SPLK	#103,PWMCOUNT3			;指针3初始值
	SPLK	#142,PWMCOUNT2			;指针2初始值
	SPLK	#0,PWMCOUNT4
	SPLK	#0,PWMCOUNT5
	SPLK	#SINWAVE,PWMADDRESS		;表格1的地址
	SPLK	#SINWAVE1,PWMADDRESS1		;表格2的地址
	SPLK	#ACVDAT,PWMADDRESS4		;表格4的地址
	SPLK	#635,DCVOLLIM1			;直流电压的工作下限
	
	SPLK	#840,DCVOLLIM2			;直流电压的工作上限
	
	SPLK	#1,ACVOLK1
	SPLK	#8,ACVOLK2

	SPLK	#16,ACVOLK4
	SPLK	#0,OUTTAG			;开机初期一定为停止输出脉冲状态

	SPLK	#0,ACLEAVE
	SPLK	#0,ACLEAVE1
	SPLK	#0,PDATA1

	SPLK	#0,PDATA3

	SPLK	#0,LIMIT2
	
	SPLK	#35H,D_INCUR
	
	SPLK	#0,RUNTAG
	
;--------------------------------------------------------------------
;	延时并继电器动作
;--------------------------------------------------------------------

	CALL	STARTDELAY1			;延时时间大约为1S

	LDP	#0E1H
	LACC	PCDATDIR
	OR	#08080H
	SACL	PCDATDIR			;启动电阻吸合
		
	CLRC	INTM				;开中断

;--------------------------------------------------------------------
;	为了增强抗干扰的能力，加入看门狗
;--------------------------------------------------------------------
;	NOP
;	LDP	#00E0H
;	SPLK	#002FH,WDCR			;使看门狗有效，复位时间大致为1S
;	NOP
	

LOOP:	NOP
	NOP
	NOP
	CALL	KEYPRESS			;调用按键判断子程序
	NOP
	CALL	OUTSET
        NOP
	CALL	RUNJUDGE
        NOP
	B       LOOP



OUTSET:	LDP	#4
	LACC	RUNTAG
	BCND	OUTSET4,EQ

	LDP	#4
	BIT	KEYMODE,BIT15
	BCND	OUTSET1,TC
	

OUTSET4:LDP	#232				;停止状态
     	SPLK	#0000100110011001B,ACTR
	SPLK    #1000100001010111B,COMCON
	LDP	#00E1H
	LACC	PCDATDIR			;将PC.5设为输出端，控制前级的输出
	OR	#0010000000100000B
	SACL	PCDATDIR			;输出为1,封锁前级

	LDP	#0E1H
	LACC	PADATDIR
	OR	#0200H
	AND	#0FFFDH
	SACL	PADATDIR			;独立逆变继电器打开

	LDP	#0E1H
	LACC	PCDATDIR
	OR	#04000H
	AND	#0FFBFH
	SACL	PCDATDIR			;并网继电器打开

	LDP	#4
	
	
	B	OUTSET2

		

OUTSET1:LDP	#00E1H
	LACC	PCDATDIR			;将PC.5设为输出端，控制前级的输出
	OR	#0010000000000000B
	AND	#1111111111011111B
	SACL	PCDATDIR			;输出为0,打开前级
	

	LDP	#4
	LACC	U2AD1
	SUB	#620
	BCND	OUTSET2,LT

	LDP	#0E0H
	BIT	SPIPC2,BIT7			;如果SPISIMO=1 为独立逆变状态;SPISIMO=0 为并网状态
	BCND	OUTSET3,NTC
	
	LDP	#0E1H
	LACC	PCDATDIR
	OR	#04000H
	AND	#0FFBFH
	SACL	PCDATDIR			;并网继电器打开


	LDP	#0E1H
	LACC	PADATDIR
	OR	#0202H
	SACL	PADATDIR			;独立逆变继电器吸合

	B	OUTSET2

OUTSET3:LDP	#0E1H
	LACC	PADATDIR
	OR	#0200H
	AND	#0FFFDH
	SACL	PADATDIR			;独立逆变继电器打开



	LDP	#0E1H
	LACC	PCDATDIR
	OR	#04040H
	SACL	PCDATDIR			;并网继电器吸合
	

OUTSET2:NOP
	NOP
	RET







STARTDELAY1:					;开机延时子程序1
	SETC	SXM
	LACC	#07FFEH
STD1:	SUB	#1
	RPT	#0BFH
	NOP
	BCND	STD1,GT
	RET

STARTDELAY3:					;开机延时子程序3
	CLRC	SXM
	LACC	#0FFFEH
STD3:	SUB	#1
	RPT	#04FH
	NOP
	BCND	STD3,GT
	RET

STARTDELAY2:					;开机延时子程序2
	CLRC	SXM
	LACC	#0FFFEH
STD2:	SUB	#1
	RPT	#0FFH
	NOP
	RPT	#0FFH
	NOP
	BCND	STD2,GT
	RET

RUNJUDGE:	NOP
	SETC	SXM
	LDP	#4
	LACC	DCVOL1USE
	SUB	DCVOLLIM1
	BCND	ST1,LT
	LACC	DCVOL1USE
	SUB	DCVOLLIM2
	BCND	ST2,GT	
	B	ST3

ST1:	LDP	#4
	SPLK	#0,RUNTAG
	B	ST3

ST2:	LDP	#4
	SPLK	#1,RUNTAG
	B	ST3

ST3:	NOP
	RET

	.END


