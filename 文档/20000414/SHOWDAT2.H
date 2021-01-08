;∂‘’’±Ì
; .= 00H blank=01H
;0=02H   1=03H	2=04H   3=05H    4=06H   5=07H  6=08H
;7=09H   8=0AH  9=OBH   ==0CH 	 A=0DH 	 B=0EH
;C=0FH	 D=10H	E=11H	F=12H	 G=13H	 H=14H	I=15H	
;J=16H	 K=17H	L=18H	M=19H	 N=1AH	 O=1BH	P=1CH
;Q=1DH	 R=1EH  S=1FH	T=20H	 U=21H   V=22H  W=23H
;X=24H   Y=25H	Z=26H		 
;show poisition  04 0A 10 16 1C 22  28  2E  34 
;3A 40 46 4C  52  58  5E
	.DATA
ETAB: .WORD     000H
      .WORD     000H
      .WORD     060H
      .WORD     060H
      .WORD     000H
      .WORD     000H      ; .=00H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     000H	   ;  BLANK=  01H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     03EH
      .WORD     051H
      .WORD     049H
      .WORD     045H
      .WORD     03EH      ; 0 =   02H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     042H
      .WORD     07FH
      .WORD     040H
      .WORD     000H      ; 1=03H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     042H
      .WORD     061H
      .WORD     051H
      .WORD     049H
      .WORD     046H      ; 2=04H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     021H
      .WORD     041H
      .WORD     045H
      .WORD     04BH
      .WORD     031H      ; 3=05H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     018H
      .WORD     014H
      .WORD     012H
      .WORD     07FH
      .WORD     010H      ; 4=06H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     027H
      .WORD     045H
      .WORD     045H
      .WORD     045H
      .WORD     039H      ; 5=07H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     03EH
      .WORD     049H
      .WORD     049H
      .WORD     049H
      .WORD     032H      ; 6=08H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     001H
      .WORD     001H
      .WORD     079H
      .WORD     005H
      .WORD     003H      ; 7=09H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     036H
      .WORD     049H
      .WORD     049H
      .WORD     049H
      .WORD     036H      ; 8=0AH
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     006H
      .WORD     049H
      .WORD     049H
      .WORD     029H
      .WORD     01EH      ; 9=OBH
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     014H
      .WORD     014H
      .WORD     014H
      .WORD     014H
      .WORD     014H      ; = = 0CH
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     07EH
      .WORD     011H
      .WORD     011H
      .WORD     011H
      .WORD     07EH      ; A = 0DH
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     041H
      .WORD     07FH
      .WORD     049H
      .WORD     049H
      .WORD     036H      ; B = 0EH
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     03EH
      .WORD     041H
      .WORD     041H
      .WORD     041H
      .WORD     022H      ; C  =0FH
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     041H
      .WORD     07FH
      .WORD     041H
      .WORD     041H
      .WORD     03EH      ; D=10H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     07FH
      .WORD     049H
      .WORD     049H
      .WORD     049H
      .WORD     049H      ; E=11H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     07FH
      .WORD     009H
      .WORD     009H
      .WORD     009H
      .WORD     001H      ; F=12H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     03EH
      .WORD     041H
      .WORD     041H
      .WORD     049H
      .WORD     07AH      ; G=13H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     07FH
      .WORD     008H
      .WORD     008H
      .WORD     008H
      .WORD     07FH      ; H=14H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     041H
      .WORD     07FH
      .WORD     041H
      .WORD     000H      ; I=15H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     020H
      .WORD     040H
      .WORD     041H
      .WORD     03FH
      .WORD     001H      ; J=16H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     07FH
      .WORD     008H
      .WORD     014H
      .WORD     022H
      .WORD     041H      ; K=17H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     07FH
      .WORD     040H
      .WORD     040H
      .WORD     040H
      .WORD     040H      ; L=18H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     07FH
      .WORD     002H
      .WORD     00CH
      .WORD     002H
      .WORD     07FH      ; M=19H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     07FH
      .WORD     006H
      .WORD     008H
      .WORD     030H
      .WORD     07FH      ; N=1AH
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     03EH
      .WORD     041H
      .WORD     041H
      .WORD     041H
      .WORD     03EH      ; O=1BH
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     07FH
      .WORD     009H
      .WORD     009H
      .WORD     009H
      .WORD     006H      ; P=1CH
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     03EH
      .WORD     041H
      .WORD     051H
      .WORD     021H
      .WORD     05EH      ; Q=1DH
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     07FH
      .WORD     009H
      .WORD     019H
      .WORD     029H
      .WORD     046H      ; R=1EH
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     026H
      .WORD     049H
      .WORD     049H
      .WORD     049H
      .WORD     032H      ; S=1FH
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     001H
      .WORD     001H
      .WORD     07FH
      .WORD     001H
      .WORD     001H      ; T=20H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     03FH
      .WORD     040H
      .WORD     040H
      .WORD     040H
      .WORD     03FH      ; U=21H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     01FH
      .WORD     020H
      .WORD     040H
      .WORD     020H
      .WORD     01FH      ; V=22H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     07FH
      .WORD     020H
      .WORD     018H
      .WORD     020H
      .WORD     07FH      ; W=23H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     063H
      .WORD     014H
      .WORD     008H
      .WORD     014H
      .WORD     063H      ; X=24H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     007H
      .WORD     008H
      .WORD     070H
      .WORD     008H
      .WORD     007H      ; Y=25H
      .WORD     000H
      .WORD     000H
      .WORD     000H
      .WORD     061H
      .WORD     051H
      .WORD     049H
      .WORD     045H
      .WORD     043H      ; Z=26H
      .WORD     000H
      .WORD     000H

