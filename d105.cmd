D105.obj
-o D105.out
-m D105.map
MEMORY
{
  PAGE 0:
   EPROM: org=0100h,len=0F000h
   VEC:   org=0000h,len=0040h
  PAGE 1:
    B0:   org=0200h,len=100h
    B1:   org=0300h,len=100h
    B2:   org=060h,len=20h
}
SECTIONS
{
  .text:>  EPROM	PAGE 0
  .data:>  EPROM        PAGE 0
  .bss:>   B0           PAGE 1

}


