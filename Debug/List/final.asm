
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega32A
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 512 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega32A
	#pragma AVRPART MEMORY PROG_FLASH 32768
	#pragma AVRPART MEMORY EEPROM 1024
	#pragma AVRPART MEMORY INT_SRAM SIZE 2048
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x085F
	.EQU __DSTACK_SIZE=0x0200
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _fire1=R4
	.DEF _fire1_msb=R5
	.DEF _fire2=R6
	.DEF _fire2_msb=R7
	.DEF _rx_wr_index=R9
	.DEF _rx_rd_index=R8
	.DEF _rx_counter=R11
	.DEF _inside_counter=R12
	.DEF _inside_counter_msb=R13
	.DEF _position=R10

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  _ext_int0_isr
	JMP  _ext_int1_isr
	JMP  _ext_int2_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer1_ovf_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _usart_rx_isr
	JMP  0x00
	JMP  _usart_tx_isr
	JMP  _adc_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;REGISTER BIT VARIABLES INITIALIZATION
__REG_BIT_VARS:
	.DW  0x0000

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0

_0x1B:
	.DB  0xFE,0xFD,0xFB,0xF7
_0x1C:
	.DB  0x31,0x32,0x33,0x78,0x34,0x35,0x36,0x78
	.DB  0x37,0x38,0x39,0x78,0x78,0x30,0x78,0x78
_0x0:
	.DB  0x66,0x6C,0x6F,0x6F,0x72,0x31,0x20,0x6F
	.DB  0x6E,0x20,0x66,0x69,0x72,0x65,0x0,0x20
	.DB  0x70,0x65,0x6F,0x70,0x6C,0x65,0x20,0x69
	.DB  0x6E,0x73,0x69,0x64,0x65,0x0,0x66,0x6C
	.DB  0x6F,0x6F,0x72,0x32,0x20,0x6F,0x6E,0x20
	.DB  0x66,0x69,0x72,0x65,0x0,0x66,0x6C,0x6F
	.DB  0x6F,0x72,0x31,0x20,0x6F,0x6E,0x20,0x66
	.DB  0x69,0x72,0x65,0x21,0x0,0x66,0x6C,0x6F
	.DB  0x6F,0x72,0x32,0x20,0x6F,0x6E,0x20,0x66
	.DB  0x69,0x72,0x65,0x21,0x0,0x45,0x76,0x61
	.DB  0x63,0x75,0x61,0x74,0x65,0x64,0x0,0x53
	.DB  0x79,0x73,0x74,0x65,0x6D,0x20,0x6F,0x66
	.DB  0x66,0x2E,0x0,0x53,0x79,0x73,0x74,0x65
	.DB  0x6D,0x20,0x4F,0x46,0x46,0x2E,0x0,0x69
	.DB  0x6E,0x76,0x61,0x6C,0x69,0x64,0x20,0x63
	.DB  0x6F,0x64,0x65,0x0,0x54,0x65,0x73,0x74
	.DB  0x20,0x6D,0x6F,0x64,0x65,0x0,0x31,0x73
	.DB  0x74,0x20,0x66,0x6C,0x6F,0x6F,0x72,0x3A
	.DB  0x20,0x0,0x32,0x6E,0x64,0x20,0x66,0x6C
	.DB  0x6F,0x6F,0x72,0x3A,0x20,0x0,0x31,0x73
	.DB  0x74,0x20,0x66,0x6C,0x6F,0x6F,0x72,0x3A
	.DB  0x20,0x30,0xA,0x0,0x32,0x6E,0x64,0x20
	.DB  0x66,0x6C,0x6F,0x6F,0x72,0x3A,0x20,0x30
	.DB  0x0,0x45,0x76,0x61,0x63,0x75,0x61,0x74
	.DB  0x65,0x64,0x21,0x0,0x53,0x61,0x72,0x61
	.DB  0x20,0x65,0x78,0x69,0x74,0x65,0x64,0x2E
	.DB  0x0,0x53,0x61,0x72,0x61,0x20,0x65,0x6E
	.DB  0x74,0x65,0x72,0x65,0x64,0x2E,0x0,0x41
	.DB  0x74,0x69,0x65,0x68,0x20,0x65,0x78,0x69
	.DB  0x74,0x65,0x64,0x2E,0x0,0x41,0x74,0x69
	.DB  0x65,0x68,0x20,0x65,0x6E,0x74,0x65,0x72
	.DB  0x65,0x64,0x2E,0x0,0x5A,0x61,0x68,0x72
	.DB  0x61,0x20,0x65,0x78,0x69,0x74,0x65,0x64
	.DB  0x2E,0x0,0x5A,0x61,0x68,0x72,0x61,0x20
	.DB  0x65,0x6E,0x74,0x65,0x72,0x65,0x64,0x2E
	.DB  0x0,0x4A,0x61,0x63,0x6B,0x20,0x65,0x78
	.DB  0x69,0x74,0x65,0x64,0x2E,0x0,0x4A,0x61
	.DB  0x63,0x6B,0x20,0x65,0x6E,0x74,0x65,0x72
	.DB  0x65,0x64,0x2E,0x0,0x53,0x68,0x61,0x6B
	.DB  0x69,0x62,0x61,0x20,0x65,0x78,0x69,0x74
	.DB  0x65,0x64,0x2E,0x0,0x53,0x68,0x61,0x6B
	.DB  0x69,0x62,0x61,0x20,0x65,0x6E,0x74,0x65
	.DB  0x72,0x65,0x64,0x2E,0x0
_0x2020003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  0x02
	.DW  __REG_BIT_VARS*2

	.DW  0x08
	.DW  0x06
	.DW  __REG_VARS*2

	.DW  0x0F
	.DW  _0xB
	.DW  _0x0*2

	.DW  0x0F
	.DW  _0xB+15
	.DW  _0x0*2+15

	.DW  0x0F
	.DW  _0xB+30
	.DW  _0x0*2+30

	.DW  0x0F
	.DW  _0xB+45
	.DW  _0x0*2+15

	.DW  0x04
	.DW  _shift
	.DW  _0x1B*2

	.DW  0x10
	.DW  _layout
	.DW  _0x1C*2

	.DW  0x10
	.DW  _0x1E
	.DW  _0x0*2+45

	.DW  0x10
	.DW  _0x1E+16
	.DW  _0x0*2+61

	.DW  0x0A
	.DW  _0x1E+32
	.DW  _0x0*2+77

	.DW  0x0C
	.DW  _0x1E+42
	.DW  _0x0*2+87

	.DW  0x0C
	.DW  _0x5A
	.DW  _0x0*2+99

	.DW  0x0C
	.DW  _0x5A+12
	.DW  _0x0*2+99

	.DW  0x0D
	.DW  _0x5A+24
	.DW  _0x0*2+111

	.DW  0x0A
	.DW  _0x5A+37
	.DW  _0x0*2+124

	.DW  0x0F
	.DW  _0x5A+47
	.DW  _0x0*2

	.DW  0x0F
	.DW  _0x5A+62
	.DW  _0x0*2+15

	.DW  0x0C
	.DW  _0x74
	.DW  _0x0*2+134

	.DW  0x0C
	.DW  _0x74+12
	.DW  _0x0*2+146

	.DW  0x0E
	.DW  _0x75
	.DW  _0x0*2+158

	.DW  0x0D
	.DW  _0x75+14
	.DW  _0x0*2+172

	.DW  0x0B
	.DW  _0x75+27
	.DW  _0x0*2+185

	.DW  0x0B
	.DW  _0x75+38
	.DW  _0x0*2+185

	.DW  0x0D
	.DW  _0x75+49
	.DW  _0x0*2+196

	.DW  0x0E
	.DW  _0x75+62
	.DW  _0x0*2+209

	.DW  0x0E
	.DW  _0x75+76
	.DW  _0x0*2+223

	.DW  0x0F
	.DW  _0x75+90
	.DW  _0x0*2+237

	.DW  0x0E
	.DW  _0x75+105
	.DW  _0x0*2+252

	.DW  0x0F
	.DW  _0x75+119
	.DW  _0x0*2+266

	.DW  0x0D
	.DW  _0x75+134
	.DW  _0x0*2+281

	.DW  0x0E
	.DW  _0x75+147
	.DW  _0x0*2+294

	.DW  0x10
	.DW  _0x75+161
	.DW  _0x0*2+308

	.DW  0x11
	.DW  _0x75+177
	.DW  _0x0*2+324

	.DW  0x02
	.DW  __base_y_G101
	.DW  _0x2020003*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x260

	.CSEG
;#include <mega32a.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <delay.h>
;#include <stdio.h>
;#include <alcd.h>
;
;#define c1 PINC.4
;#define c2 PINC.5
;#define c3 PINC.6
;#define c4 PINC.7
;#define FIRE_THRESHOLD 639
;
;int people_inside1();
;int people_inside2();
;
;// Declare your global variables here
;int fire1,fire2 = 0;
;
;// External Interrupt 0 service routine
;interrupt [EXT_INT0] void ext_int0_isr(void)
; 0000 0014 {

	.CSEG
_ext_int0_isr:
; .FSTART _ext_int0_isr
; 0000 0015 
; 0000 0016     PORTD.7 = 1;
; 0000 0017 
; 0000 0018 }
; .FEND
;
;// External Interrupt 1 service routine
;interrupt [EXT_INT1] void ext_int1_isr(void)
; 0000 001C {
_ext_int1_isr:
; .FSTART _ext_int1_isr
_0xAC:
; 0000 001D 
; 0000 001E     PORTD.7 = 1;
	SBI  0x12,7
; 0000 001F 
; 0000 0020 }
	RETI
; .FEND
;
;// Timer1 overflow interrupt service routine
;interrupt [TIM1_OVF] void timer1_ovf_isr(void)
; 0000 0024 {
_timer1_ovf_isr:
; .FSTART _timer1_ovf_isr
	ST   -Y,R30
; 0000 0025 // Reinitialize Timer1 value
; 0000 0026 TCNT1H=0x85EE >> 8;
	LDI  R30,LOW(133)
	OUT  0x2D,R30
; 0000 0027 TCNT1L=0x85EE & 0xff;
	LDI  R30,LOW(238)
	OUT  0x2C,R30
; 0000 0028 // Place your code here
; 0000 0029 
; 0000 002A }
	LD   R30,Y+
	RETI
; .FEND
;
;// Voltage Reference: AREF pin
;#define ADC_VREF_TYPE ((0<<REFS1) | (0<<REFS0) | (0<<ADLAR))
;// Read the AD conversion result
;#define FIRST_ADC_INPUT 0
;#define LAST_ADC_INPUT 1
;unsigned int adc_data[LAST_ADC_INPUT-FIRST_ADC_INPUT+1];
;
;// ADC interrupt service routine
;// with auto input scanning
;interrupt [ADC_INT] void adc_isr(void)
; 0000 0036 {
_adc_isr:
; .FSTART _adc_isr
	CALL SUBOPT_0x0
; 0000 0037 static unsigned char input_index=0;
; 0000 0038 // Read the AD conversion result
; 0000 0039 adc_data[input_index]=ADCW;
	LDS  R30,_input_index_S0000003000
	LDI  R26,LOW(_adc_data)
	LDI  R27,HIGH(_adc_data)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	IN   R30,0x4
	IN   R31,0x4+1
	ST   X+,R30
	ST   X,R31
; 0000 003A // Select next ADC input
; 0000 003B if (++input_index > (LAST_ADC_INPUT-FIRST_ADC_INPUT))
	LDS  R26,_input_index_S0000003000
	SUBI R26,-LOW(1)
	STS  _input_index_S0000003000,R26
	CPI  R26,LOW(0x2)
	BRLO _0x7
; 0000 003C    input_index=0;
	LDI  R30,LOW(0)
	STS  _input_index_S0000003000,R30
; 0000 003D ADMUX=(FIRST_ADC_INPUT | ADC_VREF_TYPE)+input_index;
_0x7:
	LDS  R30,_input_index_S0000003000
	OUT  0x7,R30
; 0000 003E // Delay needed for the stabilization of the ADC input voltage
; 0000 003F delay_us(10);
	__DELAY_USB 27
; 0000 0040 //
; 0000 0041 //lcd_clear();
; 0000 0042 //sprintf(st,"Temp1= %d",adc_data[0]);
; 0000 0043 //lcd_puts(st);
; 0000 0044 //sprintf(st,"\nTemp2= %d",adc_data[1]);
; 0000 0045 //lcd_puts(st);
; 0000 0046 if (!fire1 && adc_data[0] > FIRE_THRESHOLD){
	MOV  R0,R4
	OR   R0,R5
	BRNE _0x9
	LDS  R26,_adc_data
	LDS  R27,_adc_data+1
	CPI  R26,LOW(0x280)
	LDI  R30,HIGH(0x280)
	CPC  R27,R30
	BRSH _0xA
_0x9:
	RJMP _0x8
_0xA:
; 0000 0047             lcd_clear();
	CALL _lcd_clear
; 0000 0048             lcd_puts("floor1 on fire");
	__POINTW2MN _0xB,0
	CALL SUBOPT_0x1
; 0000 0049             lcd_gotoxy(0,1);
; 0000 004A             lcd_putchar(people_inside1()+'0');
	CALL SUBOPT_0x2
; 0000 004B             lcd_puts(" people inside");
	__POINTW2MN _0xB,15
	CALL SUBOPT_0x3
; 0000 004C             fire1 = 1;
	CALL SUBOPT_0x4
; 0000 004D             PORTD.7 =1;
; 0000 004E             PORTD.6 = 0;
; 0000 004F             delay_ms(5);
; 0000 0050             putchar('x');
; 0000 0051             delay_ms(5);
; 0000 0052             PORTD.6 = 1;
; 0000 0053             }
; 0000 0054 if (!fire2 && adc_data[1] > FIRE_THRESHOLD){
_0x8:
	MOV  R0,R6
	OR   R0,R7
	BRNE _0x13
	__GETW2MN _adc_data,2
	CPI  R26,LOW(0x280)
	LDI  R30,HIGH(0x280)
	CPC  R27,R30
	BRSH _0x14
_0x13:
	RJMP _0x12
_0x14:
; 0000 0055             lcd_clear();
	CALL _lcd_clear
; 0000 0056             lcd_puts("floor2 on fire");
	__POINTW2MN _0xB,30
	CALL SUBOPT_0x1
; 0000 0057             lcd_gotoxy(0,1);
; 0000 0058             lcd_putchar(people_inside2()+'0');
	RCALL _people_inside2
	SUBI R30,-LOW(48)
	MOV  R26,R30
	CALL _lcd_putchar
; 0000 0059             lcd_puts(" people inside");
	__POINTW2MN _0xB,45
	CALL SUBOPT_0x3
; 0000 005A             fire2 = 1;
	MOVW R6,R30
; 0000 005B             PORTD.7 =1;
	SBI  0x12,7
; 0000 005C             PORTD.6 = 0;
	CALL SUBOPT_0x5
; 0000 005D             delay_ms(5);
; 0000 005E             putchar('X');
	LDI  R26,LOW(88)
	CALL SUBOPT_0x6
; 0000 005F             delay_ms(5);
; 0000 0060             PORTD.6 = 1;
; 0000 0061             }
; 0000 0062 
; 0000 0063 
; 0000 0064 }
_0x12:
	RJMP _0xAB
; .FEND

	.DSEG
_0xB:
	.BYTE 0x3C
;
;
;#define DATA_REGISTER_EMPTY (1<<UDRE)
;#define RX_COMPLETE (1<<RXC)
;#define FRAMING_ERROR (1<<FE)
;#define PARITY_ERROR (1<<UPE)
;#define DATA_OVERRUN (1<<DOR)
;
;// USART Receiver buffer
;#define RX_BUFFER_SIZE 12
;char rx_buffer[RX_BUFFER_SIZE];
;
;#if RX_BUFFER_SIZE <= 256
;unsigned char rx_wr_index=0,rx_rd_index=0;
;#else
;unsigned int rx_wr_index=0,rx_rd_index=0;
;#endif
;
;#if RX_BUFFER_SIZE < 256
;unsigned char rx_counter=0;
;#else
;unsigned int rx_counter=0;
;#endif
;
;// This flag is set on USART Receiver buffer overflow
;bit rx_buffer_overflow;
;int inside_counter = 0;
;char shift[4] = {0xFE, 0xFD, 0xFB, 0xF7 };
;char layout[16]= {'1','2','3','x',
;                        '4','5','6','x',
;                        '7','8','9','x',
;                        'x','0','x','x'};
;char position;
;
;// USART Receiver interrupt service routine
;interrupt [USART_RXC] void usart_rx_isr(void)
; 0000 0089 {

	.CSEG
_usart_rx_isr:
; .FSTART _usart_rx_isr
	CALL SUBOPT_0x0
; 0000 008A 
; 0000 008B char status,data;
; 0000 008C status=UCSRA;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R17
;	data -> R16
	IN   R17,11
; 0000 008D data=UDR;
	IN   R16,12
; 0000 008E 
; 0000 008F if (data == 'x'){
	CPI  R16,120
	BRNE _0x1D
; 0000 0090     lcd_clear();
	CALL _lcd_clear
; 0000 0091     lcd_puts("floor1 on fire!");
	__POINTW2MN _0x1E,0
	CALL _lcd_puts
; 0000 0092     rx_counter = 0;
	CLR  R11
; 0000 0093     rx_wr_index = 0;
	CLR  R9
; 0000 0094     rx_rd_index=0;
	CLR  R8
; 0000 0095     }
; 0000 0096 if (data == 'X'){
_0x1D:
	CPI  R16,88
	BRNE _0x1F
; 0000 0097     lcd_clear();
	CALL _lcd_clear
; 0000 0098     lcd_puts("floor2 on fire!");
	__POINTW2MN _0x1E,16
	CALL _lcd_puts
; 0000 0099     rx_counter = 0;
	CLR  R11
; 0000 009A     rx_wr_index = 0;
	CLR  R9
; 0000 009B     rx_rd_index=0;
	CLR  R8
; 0000 009C     }
; 0000 009D if (data == 'z'){
_0x1F:
	CPI  R16,122
	BRNE _0x20
; 0000 009E     lcd_clear();
	CALL _lcd_clear
; 0000 009F     lcd_puts("Evacuated");
	__POINTW2MN _0x1E,32
	CALL _lcd_puts
; 0000 00A0     }
; 0000 00A1 if (data == 'y'){
_0x20:
	CPI  R16,121
	BRNE _0x21
; 0000 00A2     lcd_clear();
	CALL _lcd_clear
; 0000 00A3     lcd_puts("System off.");
	__POINTW2MN _0x1E,42
	CALL _lcd_puts
; 0000 00A4     }
; 0000 00A5 
; 0000 00A6 if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
_0x21:
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BRNE _0x22
; 0000 00A7    {
; 0000 00A8    rx_buffer[rx_wr_index++]=data;
	MOV  R30,R9
	INC  R9
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer)
	SBCI R31,HIGH(-_rx_buffer)
	ST   Z,R16
; 0000 00A9 
; 0000 00AA #if RX_BUFFER_SIZE == 256
; 0000 00AB    // special case for receiver buffer size=256
; 0000 00AC    if (++rx_counter == 0) rx_buffer_overflow=1;
; 0000 00AD #else
; 0000 00AE    if (rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
	LDI  R30,LOW(12)
	CP   R30,R9
	BRNE _0x23
	CLR  R9
; 0000 00AF    if (++rx_counter == RX_BUFFER_SIZE)
_0x23:
	INC  R11
	LDI  R30,LOW(12)
	CP   R30,R11
	BRNE _0x24
; 0000 00B0       {
; 0000 00B1       rx_counter=0;
	CLR  R11
; 0000 00B2       rx_buffer_overflow=1;
	SET
	BLD  R2,0
; 0000 00B3       }
; 0000 00B4 #endif
; 0000 00B5    }
_0x24:
; 0000 00B6 }
_0x22:
	LD   R16,Y+
	LD   R17,Y+
	RJMP _0xAB
; .FEND

	.DSEG
_0x1E:
	.BYTE 0x36
;
;#ifndef _DEBUG_TERMINAL_IO_
;// Get a character from the USART Receiver buffer
;#define _ALTERNATE_GETCHAR_
;#pragma used+
;char getchar(void)
; 0000 00BD {

	.CSEG
; 0000 00BE char data;
; 0000 00BF while (rx_counter==0);
;	data -> R17
; 0000 00C0 data=rx_buffer[rx_rd_index++];
; 0000 00C1 #if RX_BUFFER_SIZE != 256
; 0000 00C2 if (rx_rd_index == RX_BUFFER_SIZE) rx_rd_index=0;
; 0000 00C3 #endif
; 0000 00C4 #asm("cli")
; 0000 00C5 --rx_counter;
; 0000 00C6 #asm("sei")
; 0000 00C7 return data;
; 0000 00C8 }
;#pragma used-
;#endif
;
;// USART Transmitter buffer
;#define TX_BUFFER_SIZE 16
;char tx_buffer[TX_BUFFER_SIZE];
;
;#if TX_BUFFER_SIZE <= 256
;unsigned char tx_wr_index=0,tx_rd_index=0;
;#else
;unsigned int tx_wr_index=0,tx_rd_index=0;
;#endif
;
;#if TX_BUFFER_SIZE < 256
;unsigned char tx_counter=0;
;#else
;unsigned int tx_counter=0;
;#endif
;
;// USART Transmitter interrupt service routine
;interrupt [USART_TXC] void usart_tx_isr(void)
; 0000 00DE {
_usart_tx_isr:
; .FSTART _usart_tx_isr
	ST   -Y,R26
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 00DF if (tx_counter)
	LDS  R30,_tx_counter
	CPI  R30,0
	BREQ _0x29
; 0000 00E0    {
; 0000 00E1    --tx_counter;
	SUBI R30,LOW(1)
	STS  _tx_counter,R30
; 0000 00E2    UDR=tx_buffer[tx_rd_index++];
	LDS  R30,_tx_rd_index
	SUBI R30,-LOW(1)
	STS  _tx_rd_index,R30
	SUBI R30,LOW(1)
	LDI  R31,0
	SUBI R30,LOW(-_tx_buffer)
	SBCI R31,HIGH(-_tx_buffer)
	LD   R30,Z
	OUT  0xC,R30
; 0000 00E3 #if TX_BUFFER_SIZE != 256
; 0000 00E4    if (tx_rd_index == TX_BUFFER_SIZE) tx_rd_index=0;
	LDS  R26,_tx_rd_index
	CPI  R26,LOW(0x10)
	BRNE _0x2A
	LDI  R30,LOW(0)
	STS  _tx_rd_index,R30
; 0000 00E5 #endif
; 0000 00E6    }
_0x2A:
; 0000 00E7 }
_0x29:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R26,Y+
	RETI
; .FEND
;
;#ifndef _DEBUG_TERMINAL_IO_
;// Write a character to the USART Transmitter buffer
;#define _ALTERNATE_PUTCHAR_
;#pragma used+
;void putchar(char c)
; 0000 00EE {
_putchar:
; .FSTART _putchar
; 0000 00EF while (tx_counter == TX_BUFFER_SIZE);
	ST   -Y,R26
;	c -> Y+0
_0x2B:
	LDS  R26,_tx_counter
	CPI  R26,LOW(0x10)
	BREQ _0x2B
; 0000 00F0 #asm("cli")
	cli
; 0000 00F1 if (tx_counter || ((UCSRA & DATA_REGISTER_EMPTY)==0))
	LDS  R30,_tx_counter
	CPI  R30,0
	BRNE _0x2F
	SBIC 0xB,5
	RJMP _0x2E
_0x2F:
; 0000 00F2    {
; 0000 00F3    tx_buffer[tx_wr_index++]=c;
	LDS  R30,_tx_wr_index
	SUBI R30,-LOW(1)
	STS  _tx_wr_index,R30
	SUBI R30,LOW(1)
	LDI  R31,0
	SUBI R30,LOW(-_tx_buffer)
	SBCI R31,HIGH(-_tx_buffer)
	LD   R26,Y
	STD  Z+0,R26
; 0000 00F4 #if TX_BUFFER_SIZE != 256
; 0000 00F5    if (tx_wr_index == TX_BUFFER_SIZE) tx_wr_index=0;
	LDS  R26,_tx_wr_index
	CPI  R26,LOW(0x10)
	BRNE _0x31
	LDI  R30,LOW(0)
	STS  _tx_wr_index,R30
; 0000 00F6 #endif
; 0000 00F7    ++tx_counter;
_0x31:
	LDS  R30,_tx_counter
	SUBI R30,-LOW(1)
	STS  _tx_counter,R30
; 0000 00F8    }
; 0000 00F9 else
	RJMP _0x32
_0x2E:
; 0000 00FA    UDR=c;
	LD   R30,Y
	OUT  0xC,R30
; 0000 00FB #asm("sei")
_0x32:
	sei
; 0000 00FC }
	JMP  _0x2080001
; .FEND
;#pragma used-
;#endif
;
;
;
; unsigned char keypad(){
; 0000 0102 unsigned char keypad(){
_keypad:
; .FSTART _keypad
; 0000 0103   unsigned char r,b;
; 0000 0104       while(1){
	ST   -Y,R17
	ST   -Y,R16
;	r -> R17
;	b -> R16
_0x33:
; 0000 0105         for (r=0; r<4; r++){
	LDI  R17,LOW(0)
_0x37:
	CPI  R17,4
	BRSH _0x38
; 0000 0106          b=4;
	LDI  R16,LOW(4)
; 0000 0107          PORTC=shift[r];
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_shift)
	SBCI R31,HIGH(-_shift)
	LD   R30,Z
	OUT  0x15,R30
; 0000 0108          if(c1==0) b=0;
	SBIS 0x13,4
	LDI  R16,LOW(0)
; 0000 0109          if(c2==0) b=1;
	SBIS 0x13,5
	LDI  R16,LOW(1)
; 0000 010A          if(c3==0) b=2;
	SBIS 0x13,6
	LDI  R16,LOW(2)
; 0000 010B          if(c4==0) b=3;
	SBIS 0x13,7
	LDI  R16,LOW(3)
; 0000 010C 
; 0000 010D           if (!(b==4)){
	CPI  R16,4
	BREQ _0x3D
; 0000 010E            position=layout[(r*4)+b];
	LDI  R30,LOW(4)
	MUL  R30,R17
	MOVW R30,R0
	MOVW R26,R30
	MOV  R30,R16
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	SUBI R30,LOW(-_layout)
	SBCI R31,HIGH(-_layout)
	LD   R10,Z
; 0000 010F            while(c1==0);
_0x3E:
	SBIS 0x13,4
	RJMP _0x3E
; 0000 0110            while(c2==0);
_0x41:
	SBIS 0x13,5
	RJMP _0x41
; 0000 0111            while(c3==0);
_0x44:
	SBIS 0x13,6
	RJMP _0x44
; 0000 0112            while(c4==0);
_0x47:
	SBIS 0x13,7
	RJMP _0x47
; 0000 0113            delay_ms(50);
	LDI  R26,LOW(50)
	LDI  R27,0
	CALL _delay_ms
; 0000 0114            return position;
	MOV  R30,R10
	RJMP _0x2080003
; 0000 0115           }
; 0000 0116         }
_0x3D:
	SUBI R17,-1
	RJMP _0x37
_0x38:
; 0000 0117       }
	RJMP _0x33
; 0000 0118  }
; .FEND
;
;void clear_buffer(){
; 0000 011A void clear_buffer(){
_clear_buffer:
; .FSTART _clear_buffer
; 0000 011B     int i=0;
; 0000 011C      for (i=0;i<12;i++){
	ST   -Y,R17
	ST   -Y,R16
;	i -> R16,R17
	__GETWRN 16,17,0
	__GETWRN 16,17,0
_0x4B:
	__CPWRN 16,17,12
	BRGE _0x4C
; 0000 011D                 rx_buffer[i]='0';
	LDI  R26,LOW(_rx_buffer)
	LDI  R27,HIGH(_rx_buffer)
	ADD  R26,R16
	ADC  R27,R17
	LDI  R30,LOW(48)
	ST   X,R30
; 0000 011E                 }
	__ADDWRN 16,17,1
	RJMP _0x4B
_0x4C:
; 0000 011F      }
_0x2080003:
	LD   R16,Y+
	LD   R17,Y+
	RET
; .FEND
;
;      int entrance_status1[2]= {0};
;    //Sara, Atieh
;      int entrance_status2[3]= {0};
;    //Zahra, Jack, Shakiba
;    int people_inside1(){
; 0000 0125 int people_inside1(){
_people_inside1:
; .FSTART _people_inside1
; 0000 0126             int j= 0;
; 0000 0127             int counter= 0;
; 0000 0128             for(j=0;j<2;j++){
	CALL SUBOPT_0x7
;	j -> R16,R17
;	counter -> R18,R19
_0x4E:
	__CPWRN 16,17,2
	BRGE _0x4F
; 0000 0129                 if(entrance_status1[j] == 1)
	MOVW R30,R16
	LDI  R26,LOW(_entrance_status1)
	LDI  R27,HIGH(_entrance_status1)
	CALL SUBOPT_0x8
	BRNE _0x50
; 0000 012A                     counter++; }
	__ADDWRN 18,19,1
_0x50:
	__ADDWRN 16,17,1
	RJMP _0x4E
_0x4F:
; 0000 012B             return counter;
	RJMP _0x2080002
; 0000 012C             }
; .FEND
;    int people_inside2(){
; 0000 012D int people_inside2(){
_people_inside2:
; .FSTART _people_inside2
; 0000 012E             int j= 0;
; 0000 012F             int counter= 0;
; 0000 0130             for(j=0;j<3;j++){
	CALL SUBOPT_0x7
;	j -> R16,R17
;	counter -> R18,R19
_0x52:
	__CPWRN 16,17,3
	BRGE _0x53
; 0000 0131                 if(entrance_status2[j] == 1)
	MOVW R30,R16
	LDI  R26,LOW(_entrance_status2)
	LDI  R27,HIGH(_entrance_status2)
	CALL SUBOPT_0x8
	BRNE _0x54
; 0000 0132                     counter++; }
	__ADDWRN 18,19,1
_0x54:
	__ADDWRN 16,17,1
	RJMP _0x52
_0x53:
; 0000 0133             return counter;
_0x2080002:
	MOVW R30,R18
	CALL __LOADLOCR4
	ADIW R28,4
	RET
; 0000 0134             }
; .FEND
;    int keypad_w_index=0;
;    char keypad_buffer[3];
;// External Interrupt 2 service routine
; interrupt [EXT_INT2] void ext_int2_isr(void)
; 0000 0139 {
_ext_int2_isr:
; .FSTART _ext_int2_isr
	CALL SUBOPT_0x0
; 0000 013A            unsigned char ch;
; 0000 013B            ch = keypad();
	ST   -Y,R17
;	ch -> R17
	RCALL _keypad
	MOV  R17,R30
; 0000 013C            if (keypad_w_index == 0)
	LDS  R30,_keypad_w_index
	LDS  R31,_keypad_w_index+1
	SBIW R30,0
	BRNE _0x55
; 0000 013D             lcd_clear();
	CALL _lcd_clear
; 0000 013E            lcd_putchar(ch);
_0x55:
	MOV  R26,R17
	CALL _lcd_putchar
; 0000 013F            PORTC = 0xF0;
	LDI  R30,LOW(240)
	OUT  0x15,R30
; 0000 0140            keypad_buffer[keypad_w_index++] = ch;
	LDI  R26,LOW(_keypad_w_index)
	LDI  R27,HIGH(_keypad_w_index)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	SUBI R30,LOW(-_keypad_buffer)
	SBCI R31,HIGH(-_keypad_buffer)
	ST   Z,R17
; 0000 0141            if(keypad_w_index > 2){
	LDS  R26,_keypad_w_index
	LDS  R27,_keypad_w_index+1
	SBIW R26,3
	BRGE PC+2
	RJMP _0x56
; 0000 0142            keypad_w_index=0;
	LDI  R30,LOW(0)
	STS  _keypad_w_index,R30
	STS  _keypad_w_index+1,R30
; 0000 0143 
; 0000 0144            if(keypad_buffer[0] == '3' && keypad_buffer[1] == '3' && keypad_buffer[2] == '3' && fire1 == 1 && adc_data[0] ...
	LDS  R26,_keypad_buffer
	CPI  R26,LOW(0x33)
	BRNE _0x58
	__GETB2MN _keypad_buffer,1
	CPI  R26,LOW(0x33)
	BRNE _0x58
	__GETB2MN _keypad_buffer,2
	CPI  R26,LOW(0x33)
	BRNE _0x58
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R4
	CPC  R31,R5
	BRNE _0x58
	LDS  R26,_adc_data
	LDS  R27,_adc_data+1
	CPI  R26,LOW(0x27F)
	LDI  R30,HIGH(0x27F)
	CPC  R27,R30
	BRLO _0x59
_0x58:
	RJMP _0x57
_0x59:
; 0000 0145            lcd_clear();
	CALL _lcd_clear
; 0000 0146            lcd_puts("System OFF.");
	__POINTW2MN _0x5A,0
	CALL _lcd_puts
; 0000 0147            PORTD.4 = 0;
	CBI  0x12,4
; 0000 0148            PORTD.7 = 0;
	CBI  0x12,7
; 0000 0149            fire1 = 0;
	CLR  R4
	CLR  R5
; 0000 014A            putchar('y');
	LDI  R26,LOW(121)
	RCALL _putchar
; 0000 014B            }
; 0000 014C 
; 0000 014D            if(keypad_buffer[0] == '3' && keypad_buffer[1] == '3' && keypad_buffer[2] == '3' && fire2 == 1 &&  adc_data[1 ...
_0x57:
	LDS  R26,_keypad_buffer
	CPI  R26,LOW(0x33)
	BRNE _0x60
	__GETB2MN _keypad_buffer,1
	CPI  R26,LOW(0x33)
	BRNE _0x60
	__GETB2MN _keypad_buffer,2
	CPI  R26,LOW(0x33)
	BRNE _0x60
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R6
	CPC  R31,R7
	BRNE _0x60
	__GETW2MN _adc_data,2
	CPI  R26,LOW(0x27F)
	LDI  R30,HIGH(0x27F)
	CPC  R27,R30
	BRLO _0x61
_0x60:
	RJMP _0x5F
_0x61:
; 0000 014E            lcd_clear();
	CALL _lcd_clear
; 0000 014F            lcd_puts("System OFF.");
	__POINTW2MN _0x5A,12
	CALL _lcd_puts
; 0000 0150            PORTD.4 = 0;
	CBI  0x12,4
; 0000 0151            PORTD.4 = 7;
	SBI  0x12,4
; 0000 0152            fire2 = 0;
	CLR  R6
	CLR  R7
; 0000 0153            putchar('y');
	LDI  R26,LOW(121)
	RCALL _putchar
; 0000 0154            }
; 0000 0155 
; 0000 0156             if(keypad_w_index == 0 && (keypad_buffer[0] != '3' || keypad_buffer[1] != '3' || keypad_buffer[2] != '3') ){
_0x5F:
	LDS  R26,_keypad_w_index
	LDS  R27,_keypad_w_index+1
	SBIW R26,0
	BRNE _0x67
	LDS  R26,_keypad_buffer
	CPI  R26,LOW(0x33)
	BRNE _0x68
	__GETB2MN _keypad_buffer,1
	CPI  R26,LOW(0x33)
	BRNE _0x68
	__GETB2MN _keypad_buffer,2
	CPI  R26,LOW(0x33)
	BREQ _0x67
_0x68:
	RJMP _0x6A
_0x67:
	RJMP _0x66
_0x6A:
; 0000 0157             lcd_clear();
	CALL _lcd_clear
; 0000 0158             lcd_puts("invalid code");
	__POINTW2MN _0x5A,24
	CALL _lcd_puts
; 0000 0159 
; 0000 015A 
; 0000 015B            if(keypad_buffer[0] == '9' && keypad_buffer[1] == '9' && keypad_buffer[2] == '9'){
	LDS  R26,_keypad_buffer
	CPI  R26,LOW(0x39)
	BRNE _0x6C
	__GETB2MN _keypad_buffer,1
	CPI  R26,LOW(0x39)
	BRNE _0x6C
	__GETB2MN _keypad_buffer,2
	CPI  R26,LOW(0x39)
	BREQ _0x6D
_0x6C:
	RJMP _0x6B
_0x6D:
; 0000 015C            lcd_clear();
	CALL _lcd_clear
; 0000 015D            lcd_puts("Test mode");
	__POINTW2MN _0x5A,37
	CALL _lcd_puts
; 0000 015E            delay_ms(1000);
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	CALL _delay_ms
; 0000 015F            lcd_clear();
	CALL _lcd_clear
; 0000 0160             lcd_puts("floor1 on fire");
	__POINTW2MN _0x5A,47
	CALL SUBOPT_0x1
; 0000 0161             lcd_gotoxy(0,1);
; 0000 0162             lcd_putchar(people_inside1()+'0');
	CALL SUBOPT_0x2
; 0000 0163             lcd_puts(" people inside");
	__POINTW2MN _0x5A,62
	CALL SUBOPT_0x3
; 0000 0164             fire1 = 1;
	CALL SUBOPT_0x4
; 0000 0165             PORTD.7 = 1;
; 0000 0166             PORTD.6 = 0;
; 0000 0167             delay_ms(5);
; 0000 0168             putchar('x');
; 0000 0169             delay_ms(5);
; 0000 016A             PORTD.6 = 1;
; 0000 016B            }
; 0000 016C 
; 0000 016D           }
_0x6B:
; 0000 016E  }
_0x66:
; 0000 016F 
; 0000 0170 }
_0x56:
	LD   R17,Y+
_0xAB:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
; .FEND

	.DSEG
_0x5A:
	.BYTE 0x4D
;
;void lcd_show(){
; 0000 0172 void lcd_show(){

	.CSEG
_lcd_show:
; .FSTART _lcd_show
; 0000 0173 
; 0000 0174                 lcd_clear();
	CALL _lcd_clear
; 0000 0175                 inside_counter = people_inside1();
	RCALL _people_inside1
	MOVW R12,R30
; 0000 0176                 lcd_puts("1st floor: ");
	__POINTW2MN _0x74,0
	CALL SUBOPT_0x9
; 0000 0177                 lcd_putchar(inside_counter+'0');
; 0000 0178                 inside_counter = people_inside2();
	RCALL _people_inside2
	MOVW R12,R30
; 0000 0179                 lcd_gotoxy(0,1);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(1)
	CALL _lcd_gotoxy
; 0000 017A                 lcd_puts("2nd floor: ");
	__POINTW2MN _0x74,12
	CALL SUBOPT_0x9
; 0000 017B                 lcd_putchar(inside_counter+'0');
; 0000 017C                 lcd_gotoxy(0,0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _lcd_gotoxy
; 0000 017D                 }
	RET
; .FEND

	.DSEG
_0x74:
	.BYTE 0x18
;
;void main(void)
; 0000 0180 {

	.CSEG
_main:
; .FSTART _main
; 0000 0181 int inside_counter1,inside_counter2 = 0;
; 0000 0182 
; 0000 0183 DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (1<<DDA3) | (1<<DDA2) | (0<<DDA1) | (0<<DDA0);
;	inside_counter1 -> R16,R17
;	inside_counter2 -> R18,R19
	__GETWRN 18,19,0
	LDI  R30,LOW(12)
	OUT  0x1A,R30
; 0000 0184 PORTA=(1<<PORTA7) | (1<<PORTA6) | (1<<PORTA5) | (1<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (1<<PORTA1) | (1<<PORTA0);
	LDI  R30,LOW(243)
	OUT  0x1B,R30
; 0000 0185 
; 0000 0186 DDRB=(1<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (1<<DDB0);
	LDI  R30,LOW(129)
	OUT  0x17,R30
; 0000 0187 PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (1<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	LDI  R30,LOW(4)
	OUT  0x18,R30
; 0000 0188 
; 0000 0189 DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
	LDI  R30,LOW(15)
	OUT  0x14,R30
; 0000 018A PORTC=(1<<PORTC7) | (1<<PORTC6) | (1<<PORTC5) | (1<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	LDI  R30,LOW(240)
	OUT  0x15,R30
; 0000 018B 
; 0000 018C DDRD=(1<<DDD7) | (1<<DDD6) | (0<<DDD5) | (1<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	LDI  R30,LOW(208)
	OUT  0x11,R30
; 0000 018D PORTD=(0<<PORTD7) | (1<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (1<<PORTD3) | (1<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	LDI  R30,LOW(76)
	OUT  0x12,R30
; 0000 018E 
; 0000 018F 
; 0000 0190 // Timer/Counter 1 initialization
; 0000 0191 // Clock source: System Clock
; 0000 0192 // Clock value: 125.000 kHz
; 0000 0193 // Mode: Normal top=0xFFFF
; 0000 0194 // OC1A output: Disconnected
; 0000 0195 // OC1B output: Disconnected
; 0000 0196 // Noise Canceler: Off
; 0000 0197 // Input Capture on Falling Edge
; 0000 0198 // Timer Period: 0.125 s
; 0000 0199 // Timer1 Overflow Interrupt: On
; 0000 019A // Input Capture Interrupt: Off
; 0000 019B // Compare A Match Interrupt: Off
; 0000 019C // Compare B Match Interrupt: Off
; 0000 019D TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	LDI  R30,LOW(0)
	OUT  0x2F,R30
; 0000 019E TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (1<<CS11) | (1<<CS10);
	LDI  R30,LOW(3)
	OUT  0x2E,R30
; 0000 019F TCNT1H=0xC2;
	LDI  R30,LOW(194)
	OUT  0x2D,R30
; 0000 01A0 TCNT1L=0xF7;
	LDI  R30,LOW(247)
	OUT  0x2C,R30
; 0000 01A1 ICR1H=0x00;
	LDI  R30,LOW(0)
	OUT  0x27,R30
; 0000 01A2 ICR1L=0x00;
	OUT  0x26,R30
; 0000 01A3 OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 01A4 OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 01A5 OCR1BH=0x00;
	OUT  0x29,R30
; 0000 01A6 OCR1BL=0x00;
	OUT  0x28,R30
; 0000 01A7 
; 0000 01A8 // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 01A9 TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (1<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);
	LDI  R30,LOW(4)
	OUT  0x39,R30
; 0000 01AA 
; 0000 01AB // ADC initialization
; 0000 01AC // ADC Clock frequency: 1000.000 kHz
; 0000 01AD // ADC Voltage Reference: AREF pin
; 0000 01AE // ADC Auto Trigger Source: Timer1 Overflow
; 0000 01AF ADMUX=FIRST_ADC_INPUT | ADC_VREF_TYPE;
	LDI  R30,LOW(0)
	OUT  0x7,R30
; 0000 01B0 ADCSRA=(1<<ADEN) | (0<<ADSC) | (1<<ADATE) | (0<<ADIF) | (1<<ADIE) | (0<<ADPS2) | (1<<ADPS1) | (1<<ADPS0);
	LDI  R30,LOW(171)
	OUT  0x6,R30
; 0000 01B1 SFIOR=(1<<ADTS2) | (1<<ADTS1) | (0<<ADTS0);
	LDI  R30,LOW(192)
	OUT  0x30,R30
; 0000 01B2 
; 0000 01B3 
; 0000 01B4 // External Interrupt(s) initialization
; 0000 01B5 // INT0: On
; 0000 01B6 // INT0 Mode: Falling Edge
; 0000 01B7 // INT1: On
; 0000 01B8 // INT1 Mode: Falling Edge
; 0000 01B9 // INT2: On
; 0000 01BA // INT2 Mode: Falling Edge
; 0000 01BB GICR|=(1<<INT1) | (1<<INT0) | (1<<INT2);
	IN   R30,0x3B
	ORI  R30,LOW(0xE0)
	OUT  0x3B,R30
; 0000 01BC MCUCR=(1<<ISC11) | (0<<ISC10) | (1<<ISC01) | (0<<ISC00);
	LDI  R30,LOW(10)
	OUT  0x35,R30
; 0000 01BD MCUCSR=(0<<ISC2);
	LDI  R30,LOW(0)
	OUT  0x34,R30
; 0000 01BE GIFR=(1<<INTF1) | (1<<INTF0) | (1<<INTF2);
	LDI  R30,LOW(224)
	OUT  0x3A,R30
; 0000 01BF 
; 0000 01C0 
; 0000 01C1 
; 0000 01C2 // USART initialization
; 0000 01C3 // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 01C4 // USART Receiver: On
; 0000 01C5 // USART Transmitter: On
; 0000 01C6 // USART Mode: Asynchronous
; 0000 01C7 // USART Baud Rate: 9600
; 0000 01C8 UCSRA=(0<<RXC) | (0<<TXC) | (0<<UDRE) | (0<<FE) | (0<<DOR) | (0<<UPE) | (0<<U2X) | (0<<MPCM);
	LDI  R30,LOW(0)
	OUT  0xB,R30
; 0000 01C9 UCSRB=(1<<RXCIE) | (1<<TXCIE) | (0<<UDRIE) | (1<<RXEN) | (1<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
	LDI  R30,LOW(216)
	OUT  0xA,R30
; 0000 01CA UCSRC=(1<<URSEL) | (0<<UMSEL) | (0<<UPM1) | (0<<UPM0) | (0<<USBS) | (1<<UCSZ1) | (1<<UCSZ0) | (0<<UCPOL);
	LDI  R30,LOW(134)
	OUT  0x20,R30
; 0000 01CB UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
; 0000 01CC UBRRL=0x33;
	LDI  R30,LOW(51)
	OUT  0x9,R30
; 0000 01CD 
; 0000 01CE 
; 0000 01CF // Alphanumeric LCD initialization
; 0000 01D0 // Connections are specified in the
; 0000 01D1 // Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
; 0000 01D2 // RS - PORTB Bit 0
; 0000 01D3 // RD - PORTB Bit 1
; 0000 01D4 // EN - PORTB Bit 3
; 0000 01D5 // D4 - PORTB Bit 4
; 0000 01D6 // D5 - PORTB Bit 5
; 0000 01D7 // D6 - PORTB Bit 6
; 0000 01D8 // D7 - PORTB Bit 7
; 0000 01D9 // Characters/line: 16
; 0000 01DA lcd_init(16);
	LDI  R26,LOW(16)
	CALL _lcd_init
; 0000 01DB 
; 0000 01DC // Global enable interrupts
; 0000 01DD #asm("sei")
	sei
; 0000 01DE 
; 0000 01DF lcd_puts("1st floor: 0\n");
	__POINTW2MN _0x75,0
	CALL _lcd_puts
; 0000 01E0 lcd_puts("2nd floor: 0");
	__POINTW2MN _0x75,14
	CALL _lcd_puts
; 0000 01E1 
; 0000 01E2 while (1)
_0x76:
; 0000 01E3       {
; 0000 01E4             inside_counter1 = people_inside1();
	RCALL _people_inside1
	MOVW R16,R30
; 0000 01E5             inside_counter2 = people_inside2();
	RCALL _people_inside2
	MOVW R18,R30
; 0000 01E6 
; 0000 01E7             if (!PORTD.4 && fire1 == 1 && inside_counter1 == 0){
	SBIC 0x12,4
	RJMP _0x7A
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R4
	CPC  R31,R5
	BRNE _0x7A
	CLR  R0
	CP   R0,R16
	CPC  R0,R17
	BREQ _0x7B
_0x7A:
	RJMP _0x79
_0x7B:
; 0000 01E8             lcd_clear();
	CALL _lcd_clear
; 0000 01E9             lcd_puts("Evacuated!");
	__POINTW2MN _0x75,27
	CALL _lcd_puts
; 0000 01EA             PORTD.4 = 1;
	SBI  0x12,4
; 0000 01EB             PORTD.7 = 0;
	CBI  0x12,7
; 0000 01EC             PORTD.6 = 0;
	CALL SUBOPT_0x5
; 0000 01ED             delay_ms(5);
; 0000 01EE             putchar('z');
	LDI  R26,LOW(122)
	CALL SUBOPT_0x6
; 0000 01EF             delay_ms(5);
; 0000 01F0             PORTD.6 = 1;
; 0000 01F1             }
; 0000 01F2             if (!PORTD.4 && fire2 == 1 && inside_counter2 == 0){
_0x79:
	SBIC 0x12,4
	RJMP _0x85
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R6
	CPC  R31,R7
	BRNE _0x85
	CLR  R0
	CP   R0,R18
	CPC  R0,R19
	BREQ _0x86
_0x85:
	RJMP _0x84
_0x86:
; 0000 01F3             lcd_clear();
	CALL _lcd_clear
; 0000 01F4             lcd_puts("Evacuated!");
	__POINTW2MN _0x75,38
	CALL _lcd_puts
; 0000 01F5             PORTD.7 = 0;
	CBI  0x12,7
; 0000 01F6             PORTD.4 = 1;
	SBI  0x12,4
; 0000 01F7             PORTD.6 = 0;
	CALL SUBOPT_0x5
; 0000 01F8             delay_ms(5);
; 0000 01F9             putchar('z');
	LDI  R26,LOW(122)
	CALL SUBOPT_0x6
; 0000 01FA             delay_ms(5);
; 0000 01FB             PORTD.6 = 1;
; 0000 01FC             }
; 0000 01FD 
; 0000 01FE         switch (rx_buffer[8]){
_0x84:
	__GETB1MN _rx_buffer,8
	LDI  R31,0
; 0000 01FF                 case '3': {
	CPI  R30,LOW(0x33)
	LDI  R26,HIGH(0x33)
	CPC  R31,R26
	BRNE _0x92
; 0000 0200                     lcd_clear();
	CALL _lcd_clear
; 0000 0201                     if (entrance_status1[0]){
	LDS  R30,_entrance_status1
	LDS  R31,_entrance_status1+1
	SBIW R30,0
	BREQ _0x93
; 0000 0202                          lcd_puts("Sara exited.");
	__POINTW2MN _0x75,49
	CALL _lcd_puts
; 0000 0203                          entrance_status1[0] = 0;
	LDI  R30,LOW(0)
	STS  _entrance_status1,R30
	STS  _entrance_status1+1,R30
; 0000 0204                     }else if(!fire1){
	RJMP _0x94
_0x93:
	MOV  R0,R4
	OR   R0,R5
	BRNE _0x95
; 0000 0205                          lcd_puts("Sara entered.");
	__POINTW2MN _0x75,62
	CALL SUBOPT_0x3
; 0000 0206                          entrance_status1[0] = 1;
	STS  _entrance_status1,R30
	STS  _entrance_status1+1,R31
; 0000 0207                          }
; 0000 0208                     clear_buffer();
_0x95:
_0x94:
	RJMP _0xA7
; 0000 0209                     delay_ms(1000);
; 0000 020A                     lcd_show();
; 0000 020B                     break;
; 0000 020C                     }
; 0000 020D                 case '7':  {
_0x92:
	CPI  R30,LOW(0x37)
	LDI  R26,HIGH(0x37)
	CPC  R31,R26
	BRNE _0x96
; 0000 020E                     lcd_clear();
	CALL _lcd_clear
; 0000 020F                     if (entrance_status1[1]){
	__GETW1MN _entrance_status1,2
	SBIW R30,0
	BREQ _0x97
; 0000 0210                          lcd_puts("Atieh exited.");
	__POINTW2MN _0x75,76
	CALL _lcd_puts
; 0000 0211                          entrance_status1[1] = 0;
	__POINTW1MN _entrance_status1,2
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	RJMP _0xA8
; 0000 0212                     }else if(!fire1) {
_0x97:
	MOV  R0,R4
	OR   R0,R5
	BRNE _0x99
; 0000 0213                          lcd_puts("Atieh entered.");
	__POINTW2MN _0x75,90
	CALL _lcd_puts
; 0000 0214                          entrance_status1[1] = 1;
	__POINTW1MN _entrance_status1,2
	LDI  R26,LOW(1)
	LDI  R27,HIGH(1)
_0xA8:
	STD  Z+0,R26
	STD  Z+1,R27
; 0000 0215                          }
; 0000 0216                     clear_buffer();
_0x99:
	RJMP _0xA7
; 0000 0217                     delay_ms(1000);
; 0000 0218                     lcd_show();
; 0000 0219                     break;
; 0000 021A                     }
; 0000 021B                 case '1': {
_0x96:
	CPI  R30,LOW(0x31)
	LDI  R26,HIGH(0x31)
	CPC  R31,R26
	BRNE _0x9A
; 0000 021C                     lcd_clear();
	CALL _lcd_clear
; 0000 021D                     if (entrance_status2[0]){
	LDS  R30,_entrance_status2
	LDS  R31,_entrance_status2+1
	SBIW R30,0
	BREQ _0x9B
; 0000 021E                          lcd_puts("Zahra exited.");
	__POINTW2MN _0x75,105
	CALL _lcd_puts
; 0000 021F                          entrance_status2[0] = 0;
	LDI  R30,LOW(0)
	STS  _entrance_status2,R30
	STS  _entrance_status2+1,R30
; 0000 0220                     }else if(!fire2) {
	RJMP _0x9C
_0x9B:
	MOV  R0,R6
	OR   R0,R7
	BRNE _0x9D
; 0000 0221                          lcd_puts("Zahra entered.");
	__POINTW2MN _0x75,119
	CALL SUBOPT_0x3
; 0000 0222                          entrance_status2[0] = 1;
	STS  _entrance_status2,R30
	STS  _entrance_status2+1,R31
; 0000 0223                          }
; 0000 0224                     clear_buffer();
_0x9D:
_0x9C:
	RJMP _0xA7
; 0000 0225                     delay_ms(1000);
; 0000 0226                     lcd_show();
; 0000 0227                     break;
; 0000 0228                     }
; 0000 0229                 case 'F': {
_0x9A:
	CPI  R30,LOW(0x46)
	LDI  R26,HIGH(0x46)
	CPC  R31,R26
	BRNE _0x9E
; 0000 022A                     lcd_clear();
	CALL _lcd_clear
; 0000 022B                     if (entrance_status2[1]){
	__GETW1MN _entrance_status2,2
	SBIW R30,0
	BREQ _0x9F
; 0000 022C                          lcd_puts("Jack exited.");
	__POINTW2MN _0x75,134
	CALL _lcd_puts
; 0000 022D                          entrance_status2[1] = 0;
	__POINTW1MN _entrance_status2,2
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	RJMP _0xA9
; 0000 022E                     }else if(!fire2) {
_0x9F:
	MOV  R0,R6
	OR   R0,R7
	BRNE _0xA1
; 0000 022F                          lcd_puts("Jack entered.");
	__POINTW2MN _0x75,147
	CALL _lcd_puts
; 0000 0230                          entrance_status2[1] = 1;
	__POINTW1MN _entrance_status2,2
	LDI  R26,LOW(1)
	LDI  R27,HIGH(1)
_0xA9:
	STD  Z+0,R26
	STD  Z+1,R27
; 0000 0231                          }
; 0000 0232                     clear_buffer();
_0xA1:
	RJMP _0xA7
; 0000 0233                     delay_ms(1000);
; 0000 0234                     lcd_show();
; 0000 0235                     break;
; 0000 0236                     }
; 0000 0237                 case 'A': {
_0x9E:
	CPI  R30,LOW(0x41)
	LDI  R26,HIGH(0x41)
	CPC  R31,R26
	BRNE _0x91
; 0000 0238                     lcd_clear();
	CALL _lcd_clear
; 0000 0239                     if (entrance_status2[2]){
	__GETW1MN _entrance_status2,4
	SBIW R30,0
	BREQ _0xA3
; 0000 023A                          lcd_puts("Shakiba exited.");
	__POINTW2MN _0x75,161
	CALL _lcd_puts
; 0000 023B                          entrance_status2[2] = 0;
	__POINTW1MN _entrance_status2,4
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	RJMP _0xAA
; 0000 023C                     }else if(!fire2) {
_0xA3:
	MOV  R0,R6
	OR   R0,R7
	BRNE _0xA5
; 0000 023D                          lcd_puts("Shakiba entered.");
	__POINTW2MN _0x75,177
	CALL _lcd_puts
; 0000 023E                          entrance_status2[2] = 1;
	__POINTW1MN _entrance_status2,4
	LDI  R26,LOW(1)
	LDI  R27,HIGH(1)
_0xAA:
	STD  Z+0,R26
	STD  Z+1,R27
; 0000 023F                          }
; 0000 0240                     clear_buffer();
_0xA5:
_0xA7:
	RCALL _clear_buffer
; 0000 0241                     delay_ms(1000);
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	CALL _delay_ms
; 0000 0242                     lcd_show();
	RCALL _lcd_show
; 0000 0243                     break;
; 0000 0244                     }
; 0000 0245                 }
_0x91:
; 0000 0246 
; 0000 0247 
; 0000 0248 
; 0000 0249 
; 0000 024A 
; 0000 024B         }
	RJMP _0x76
; 0000 024C 
; 0000 024D 
; 0000 024E 
; 0000 024F 
; 0000 0250 }
_0xA6:
	RJMP _0xA6
; .FEND

	.DSEG
_0x75:
	.BYTE 0xC2
;
;
;
;
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G101:
; .FSTART __lcd_write_nibble_G101
	ST   -Y,R26
	IN   R30,0x18
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LD   R30,Y
	ANDI R30,LOW(0xF0)
	OR   R30,R26
	OUT  0x18,R30
	__DELAY_USB 13
	SBI  0x18,3
	__DELAY_USB 13
	CBI  0x18,3
	__DELAY_USB 13
	RJMP _0x2080001
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G101
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G101
	__DELAY_USB 133
	RJMP _0x2080001
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G101)
	SBCI R31,HIGH(-__base_y_G101)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	RCALL __lcd_write_data
	LDD  R30,Y+1
	STS  __lcd_x,R30
	LD   R30,Y
	STS  __lcd_y,R30
	ADIW R28,2
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	CALL SUBOPT_0xA
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	CALL SUBOPT_0xA
	LDI  R30,LOW(0)
	STS  __lcd_y,R30
	STS  __lcd_x,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R26
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2020005
	LDS  R30,__lcd_maxx
	LDS  R26,__lcd_x
	CP   R26,R30
	BRLO _0x2020004
_0x2020005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDS  R26,__lcd_y
	SUBI R26,-LOW(1)
	STS  __lcd_y,R26
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BRNE _0x2020007
	RJMP _0x2080001
_0x2020007:
_0x2020004:
	LDS  R30,__lcd_x
	SUBI R30,-LOW(1)
	STS  __lcd_x,R30
	SBI  0x18,0
	LD   R26,Y
	RCALL __lcd_write_data
	CBI  0x18,0
	RJMP _0x2080001
; .FEND
_lcd_puts:
; .FSTART _lcd_puts
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2020008:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x202000A
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2020008
_0x202000A:
	LDD  R17,Y+0
	ADIW R28,3
	RET
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R26
	IN   R30,0x17
	ORI  R30,LOW(0xF0)
	OUT  0x17,R30
	SBI  0x17,3
	SBI  0x17,0
	SBI  0x17,1
	CBI  0x18,3
	CBI  0x18,0
	CBI  0x18,1
	LD   R30,Y
	STS  __lcd_maxx,R30
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G101,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G101,3
	LDI  R26,LOW(20)
	LDI  R27,0
	CALL _delay_ms
	CALL SUBOPT_0xB
	CALL SUBOPT_0xB
	CALL SUBOPT_0xB
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G101
	__DELAY_USW 200
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x2080001:
	ADIW R28,1
	RET
; .FEND

	.CSEG

	.CSEG

	.DSEG
_adc_data:
	.BYTE 0x4
_input_index_S0000003000:
	.BYTE 0x1
_rx_buffer:
	.BYTE 0xC
_shift:
	.BYTE 0x4
_layout:
	.BYTE 0x10
_tx_buffer:
	.BYTE 0x10
_tx_wr_index:
	.BYTE 0x1
_tx_rd_index:
	.BYTE 0x1
_tx_counter:
	.BYTE 0x1
_entrance_status1:
	.BYTE 0x4
_entrance_status2:
	.BYTE 0x6
_keypad_w_index:
	.BYTE 0x2
_keypad_buffer:
	.BYTE 0x3
__base_y_G101:
	.BYTE 0x4
__lcd_x:
	.BYTE 0x1
__lcd_y:
	.BYTE 0x1
__lcd_maxx:
	.BYTE 0x1

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0x0:
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x1:
	CALL _lcd_puts
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(1)
	JMP  _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2:
	CALL _people_inside1
	SUBI R30,-LOW(48)
	MOV  R26,R30
	JMP  _lcd_putchar

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x3:
	CALL _lcd_puts
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x4:
	MOVW R4,R30
	SBI  0x12,7
	CBI  0x12,6
	LDI  R26,LOW(5)
	LDI  R27,0
	CALL _delay_ms
	LDI  R26,LOW(120)
	CALL _putchar
	LDI  R26,LOW(5)
	LDI  R27,0
	CALL _delay_ms
	SBI  0x12,6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x5:
	CBI  0x12,6
	LDI  R26,LOW(5)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x6:
	CALL _putchar
	LDI  R26,LOW(5)
	LDI  R27,0
	CALL _delay_ms
	SBI  0x12,6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x7:
	CALL __SAVELOCR4
	__GETWRN 16,17,0
	__GETWRN 18,19,0
	__GETWRN 16,17,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x8:
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x9:
	CALL _lcd_puts
	MOV  R26,R12
	SUBI R26,-LOW(48)
	JMP  _lcd_putchar

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xA:
	CALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xB:
	LDI  R26,LOW(48)
	CALL __lcd_write_nibble_G101
	__DELAY_USW 200
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
