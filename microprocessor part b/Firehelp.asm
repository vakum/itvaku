NAME DISPLAY
TITLE DISPLAY
.MODEL SMALL
.STACK 20
.DATA
BASE_ADDRESS    EQU     0E880H

           ;port address for 8255
CONTROL EQU     0E883H           ;control port address for 8255
PORTA   EQU     0E880H           ;portb address for 8255
PORTB   EQU     0E881H           ;portb address for 8255
PORTC   EQU     0E882H

DSP_TBL         DB   0,0,79H,77H,06H,71H
                DB   0,0,0,0,0,0
                DB   73H,38H,79H,76H
                DB   0,0,0,0,0,0,0,0,0
                
NPAN    EQU     20

COUNT     DB      ?

   .CODE

ST0:    MOV     AX,@DATA
        MOV     DS,AX

        MOV     AL,80H  ; PORT A - PORTC LOWER O/P
        MOV     DX,CONTROL ;PORT B - PORTC UPPER I/P
        OUT     DX,AL

        MOV     DI,00
        MOV     COUNT,NPAN

DISP05:
        MOV     DX,PORTC    ; DISPABLE ALL DIDIGTS
        MOV     AL,07H
        OUT     DX,AL

        MOV     CX,06H
        MOV     BL,00

        MOV     SI,OFFSET DSP_TBL
        ADD     SI,DI        
DISP00:
        MOV     AL,BL    ; SELECT DEIGIT    0
        MOV     DX,PORTC
        OUT     DX,AL

        MOV     DX,PORTA  ; O/P NUMBER TO SELECTED DIGIT
        LODSB
        OUT     DX,AL

        CALL    DELAY     ; INTRODUCE DELAY

        INC     BL

        CMP     BL,05
        JLE      DISP20

        MOV     BL,00
DISP20:
        LOOP    DISP00

        DEC     COUNT

        JNZ     DISP05

        MOV     COUNT,NPAN

        INC     DI
        CMP     DI,0FH
        JLE     DISP25

        MOV     DI,00
        JMP     DISP25
DISP25:

        MOV     AH,0BH
        INT     21H

        OR      AL,AL
        JZ      DISP05
QUIT:

	MOV	AH,4CH
	INT	21H



DELAY:
        PUSH    BX
        PUSH    CX
        MOV     BX,0FFH
OUTLP:  MOV     CX,0FFFFH
INLP:   DEC     CX
        JNZ     INLP
        DEC     BX
        JNZ     OUTLP
        POP     CX
        POP     BX
        RET
        END     ST0
        END


