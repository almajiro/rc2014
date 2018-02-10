;--------------------------------------
;   演習プログラム27
;--------------------------------------
CW      EQU     90H         ; コントロールワード
CWR     EQU     0F3H        ; コントロールワードレジスタ
PADR    EQU     0F0H        ; PORTAレジスタ
PBDR    EQU     0F1H        ; PORTBレジスタ
PCDR    EQU     0F2H        ; PORTCレジスタ
SP_A    EQU     0C200H      ; SP
PATA    EQU     055H        ; PATTERN 1
PATB    EQU     0AAH        ; PATTERN2

        ORG     0C000H
        LD      A, CW       ; コントロールワードをAレジスタへ
        OUT     (CWR), A    ; コントロールワードレジスタへ出力
        LD      SP, SP_A

LOOP:   LD      A, PATA
        OUT     (PCDR), A
        CALL    TIM3
        LD      A, PATB
        OUT     (PCDR), A
        CALL    TIM3
        JP      LOOP

        RET

TIM3:   LD      D, 50D      ; 500ms delay loop
DLOOP3: CALL    TIM2
        DEC     D
        JP      NZ, DLOOP3
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

        
