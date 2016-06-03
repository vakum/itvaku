NAME  SINEWAVE
TITLE PROGRAM TO GENERATE SINE WAVE
.MODEL SMALL
.STACK 20
.DATA
BASE_ADDRESS    EQU     0E880h
CONTROL EQU     0E883H
PORTA   EQU     0E880H
PORTB   EQU     0E881H
PORTC   EQU     0E882H

TIMCTL   EQU     0E891H
TIMER0   EQU     0E888H
TIMER1   EQU     0E889H
TIMER2   EQU     0E890H
STATUSRD        EQU     BASE_ADDRESS+1AH
CLEARFF         EQU     BASE_ADDRESS+19H
LOOK_UP_TBL   DB   80H,90H,0A1H,0B1H,0C0H,0CDH,0DAH,0E5H,0EEH,0F6H,0FBH,0FEH,0FFH

        DB    0FEH,0FBH,0F6H,0EEH,0E5H,0DAH,0CDH,0C0H,0B1H,0A1H,90H,80H
   DB   80H,90H,0A1H,0B1H,0C0H,0CDH,0DAH,0E5H,0EEH,0F6H,0FBH,0FEH,0FFH

        DB    0FEH,0FBH,0F6H,0EEH,0E5H,0DAH,0CDH,0C0H,0B1H,0A1H,90H,80H


       
OUTSTR  DB      48 DUP(0)
.CODE
ST0:
        MOV     AX,@DATA
        MOV     DS,AX
	MOV	DX,CONTROL	
	MOV	AL,88H		;initialise all ports as output
	OUT	DX,AL		;ports

        MOV     DX,TIMCTL
        MOV     AL,36H
        OUT     DX,AL

        MOV     DX,TIMER0
        MOV     AL, 04H;  0AH;    64H  100msec      ;0AH  for 10 msec
        OUT     DX,AL
        MOV     AL,00
        OUT     DX,AL

        MOV     DX,TIMCTL
        MOV     AL,0B0H
        OUT     DX,AL

RPT:
        MOV     CX,24 ;48   ; NO. OF VALUES IN LOKKUP TBL
        MOV     BX,OFFSET       LOOK_UP_TBL
DA00:   MOV     AL,[BX]
;        CALL    OUTPUT
        MOV  DX,PORTA
	OUT  DX,AL
        MOV  DX,PORTB
	OUT  DX,AL
	CALL	DELAY
        INC     BX
        INC     BX
        LOOP    DA00
        NOP
        NOP
        NOP

        MOV     AH,0BH
        INT     21H
        OR      AL,AL
        JZ      RPT 
;        JMP     RPT
        MOV     DX,TIMCTL
        MOV     AL,36H
        OUT     DX,AL

        MOV     AH,4CH
	INT	21H

        JMP     RPT

;OUTPUT:
;        RET

DELAY:


        MOV     DX,TIMER2
        MOV     AL,15H  ;28H  ;   2AH for 10ms
        OUT     DX,AL
        MOV     AL,00
        OUT     DX,AL
TIME00:
        MOV     DX,STATUSRD
        IN      AL,DX
        AND     AL,02H
        JZ      TIME00
        ; CLEAR FF
        MOV     DX,CLEARFF
        IN      AL,DX


        MOV     DX,TIMCTL

        MOV     AL,0B0H
        OUT     DX,AL

        RET


END  ST0


