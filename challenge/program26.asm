;--------------------------------------
;   演習プログラム26
;--------------------------------------
CW      EQU     90H         ; コントロールワード
CWR     EQU     0F3H        ; コントロールワードレジスタ
PADR    EQU     0F0H        ; PORTAレジスタ
PBDR    EQU     0F1H        ; PORTBレジスタ
PCDR    EQU     0F2H        ; PORTCレジスタ
SP_A    EQU     0C200H      ; SP

        ORG     0C000H
        LD      A, CW       ; コントロールワードをAレジスタへ
        OUT     (CWR), A    ; コントロールワードレジスタへ出力
        LD      SP, SP_A

        LD      E, 100D

LOOP:   LD      A, 0FFH
        OUT     (PCDR), A
        LD      D, E
        CALL    TIM3
        LD      A, 000H
        OUT     (PCDR), A
        LD      D, E
        CALL    TIM3
        LD      A, E
        SUB     A, 5
        LD      E, A
        JP      NZ, LOOP

        LD      A, 0FFH
        OUT     (PCDR), A

        RET

TIM3:   CALL    TIM2
        DEC     D
        JP      NZ, TIM3
        RET

TIM2:   LD      C, 100D     ; 10ms delay loop 
DLOOP2: CALL    TIM1        ; 17 state
        DEC     C
        NOP
        NOP
        JP      NZ, DLOOP2
        RET

TIM1:   LD      B, 31D      ; 100us delay loop
DLOOP1: DEC     B           ; 4 state
        NOP                 ; 4 state
        NOP
        JP      NZ, DLOOP1  ; 10 state
        RET

        END

        
