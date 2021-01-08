        .INCLUDE   "INIT.H"		;加入头文件	

	.INCLUDE   "SHOWDAT2.H"		;加入所需显示的数据文件
	.INCLUDE   "SHOW.H"		;加入LCD显示的通用子程序
        .SECT   ".VEC"			;中断向量

RSVECT		B	START		;跳至开始

	.BSS	OUTDATA,1		;变量定义，显示输出数据，用于显示初始化
	.BSS	SHOWCOM,1		;显示命令
	.BSS	SHOWDAT,1		;显示数据
	.BSS	COUNT1,1		;页面地址暂存器
   	
PD1	.SET	0032H			;液晶常量定义
	.BSS	ADDRESS2,1		;字符字模块首地址
	.BSS	COLUMN,1		;LCD列地址
	.BSS	PAGE,1			;LCD页地址
	.BSS	CODE,1			;字符代码寄存器
	.BSS	COUNT,1			;计数器
	.BSS	ADDRESS1,1		;辅助地址寄存器

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
  	CLRC	CNF			;map b0 block to data memory
	CALL	SHOWINT			;调用初始化子程序
	CALL	CLEAR			;调用清屏子程序
LOOP:	CALL	E_SHOW			;调用显示固定字符子程序
	B	LOOP



CLEAR:	LDP	#0		;页面地址暂存器设置
        SPLK 	#0,COUNT1
CLEAR1:	LDP	#0		;取页地址值			
	LACC	COUNT1
	OR	#0B8H		;“或”页面地址设置代码
	SACL	SHOWCOM		;页面地址设置
	CALL	PR0		
	CALL	PR3
	LDP	#0		;页地址设置为“0”，因为页地址
	SPLK	#0,SHOWCOM	;自动增一，所以勿需再次赋值
	CALL	PR0
	CALL	PR3
	MAR	*,AR2		;一页清80个字节
	LAR	AR2,#80
CLEAR2:	LDP	#0
	SPLK	#0H,SHOWDAT	;显示数据为“0”
	CALL	PR1
	CALL	PR4
	BANZ	CLEAR2		;页内字节清零循环
	LDP	#0
	LACC	COUNT1		;页地址暂存器加1
	ADD	#1
	SACL	COUNT1		;一共有四页，循环判断
	SUB	#04
	BCND	CLEAR1,LT
	RET





CW_PR:	LDP	#0		;确定字符字模块首地址
	SPLK	#ETAB,ADDRESS1	
	LT	CODE		;取代码
	MPY	#8		;字模块宽度为8个字节
	PAC
	ADD	ADDRESS1
	SACL	ADDRESS2	;ADDRESS2=ETAB+CODE*8
	LDP	#0
	LACC    COLUMN		;列地址暂存入ADDRESS1中
	SACL	ADDRESS1
	SPLK	#0,CODE		;代码寄存器借用为间址寄存器
	LACC	PAGE		;读页地址寄存器
	BIT	PAGE,8		;判字符体
	BCND	CW_1,TC
	SPLK	#06H,COUNT	;6*8点阵
	B	CW_2
CW_1:	LDP	#0
	SPLK	#08H,COUNT	;计数器设置为8，8*8点阵
CW_2:	LACC	PAGE		;读页地址设置指令
	AND	#03H
	OR	#0B8H		;“或”页地址设置代码
	SACL	SHOWCOM		;写页地址设置指令
	CALL	PR0
	CALL	PR3
	LDP	#0
	LACC	ADDRESS1     	;取出列地址值
	SACL    COLUMN
	SUB	#PD1		;与列地址-模块参数比较
	BCND	CW_3,LT		;判断是否在左或右半边
	SACL	COLUMN		;<0为左边（E1）
	LACC	PAGE		;>=0为右边（E2）
	OR	#08H		;设置区域标志位		
	SACL	PAGE		;0 为 E1，1 为 E2
CW_3:	LDP	#0
	LACC	COLUMN		;设置列地址值
	SACL	SHOWCOM
	LACC	PAGE
	BIT	PAGE,12		;判区域标志以确定设置哪个控制器
	BCND	CW_4,NTC
	CALL	PR3		;区域E2
	B	CW_5
CW_4:	CALL	PR0		;区域E1
CW_5:	LDP	#0
	LACC	ADDRESS2	;取字库首地址
	ADD	CODE		;加上间址寄存器值
	TBLR	SHOWDAT		;读出显示数据
	BIT	PAGE,12		;确定区域，写显示数据
	BCND	CW_6,NTC
	CALL	PR4
	B	CW_7
CW_6:	CALL	PR1
CW_7:	LDP	#0
	LACC	CODE		;间址寄存器加1
	ADD	#1
	SACL	CODE
	LACC	COLUMN		;列地址加1
	ADD	#1
	SACL	COLUMN
	SUB	#PD1		;与模块显示常数比较，确定区域
	BCND	CW_8,GT		;超出则判是否在区域E2
	B	CW_9		;未超出则继续
CW_8:	LACC	PAGE		;在区域E2则继续
	BIT	PAGE,12
	BCND	CW_9,TC
	OR	#08H		;在区域E1则修改成E2
	SACL	PAGE
	SPLK	#0,SHOWCOM
	CALL	PR3
CW_9:	LACC	COUNT		
	SUB	#1		;循环
	SACL    COUNT
	BCND    CW_5,GT
	RET

 	.END


	

