;--------------------------------------
;   演習プログラム30
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

        LD      A, 01H
        OUT     (PBDR), A

LOOP:   IN      A, (PADR)
        LD      H, A
        LD      A, 01H      ; 表示パターン
        LD      B, 01H      ; 表示中のセグメント
        LD      C, 04H

CNT:    OUT     (PCDR), A   ; 表示パターンの変更

        PUSH    BC
        PUSH    DE
        CALL    TIM3
        POP     DE
        POP     BC

CHK1:   BIT     0, A
        JP      Z, CHK2

        DEC     C
        JP      Z, NEXT
        
        BIT     0, H
        JP      Z, CHK1C
        CALL    SEGL
        JP      CHK1N

CHK1C:  CALL    SEGR
CHK1N:  
        JP      NZ, CNT
        
CHK2:   BIT     3, A        ; 08Hの時
        JP      Z, NEXT

        DEC     C
        JP      Z, NEXT

        BIT     0, H
        JP      Z, CHK2C
        CALL    SEGR
        JP      CHK2N

CHK2C:  CALL    SEGL
CHK2N:  JP      NZ, CNT

NEXT:   BIT     0, H
        JP      Z, SHIFT
        SRL     A
        JP      GN
SHIFT:  SLA     A
GN:     LD      D, 40H
        CP      D
        JP      Z, LOOP
        LD      C, 04H
        JP      NZ, CNT
        RET

SEGL:   PUSH    AF
        LD      A, B
        SRL     A
        OUT     (PBDR), A
        LD      B, A
        POP     AF
        RET

SEGR:   PUSH    AF
        LD      A, B
        SLA     A
        OUT     (PBDR), A
        LD      B,A
        POP     AF
        RET

TIM3:   LD      D, 50D
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
