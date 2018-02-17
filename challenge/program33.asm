;--------------------------------------
;   演習プログラム32
;--------------------------------------
CW      EQU     90H             ; コントロールワード
CWR     EQU     0F3H            ; コントロールワードレジスタ
PADR    EQU     0F0H            ; PORTAレジスタ
PBDR    EQU     0F1H            ; PORTBレジスタ
PCDR    EQU     0F2H            ; PORTCレジスタ
SP_A    EQU     0C200H          ; SP

        ORG     0C000H
        LD      A, CW           ; コントロールワードをAレジスタへ
        OUT     (CWR), A        ; コントロールワードレジスタへ出力
        LD      SP, SP_A

        LD      C, 255D
        LD      E, 0D

LOOP:   LD      A, 01H
LEFT:   OUT     (PCDR), A
        CALL    TIM3
        SLA     A
        JP      NZ, LEFT

        LD      A, 80H
RIGHT:  OUT     (PCDR), A
        CALL    TIM3
        SRL     A
        JP      NZ, RIGHT

CHECK:  BIT     0, E
        JP      NZ, SLOWER

FASTER: LD      A, C
        CP      100D
        JP      Z, TSLOW
        LD      A, C
        SUB     A, 5D
        LD      C, A
        JP      LOOP

SLOWER: LD      A, C
        CP      255D
        JP      Z, TFAST
        LD      A, C
        ADD     A, 5D
        LD      C, A
        JP      LOOP

TSLOW:  SET     0, E
        JP      CHECK
TFAST:  RES     0, E
        JP      CHECK

        RET

TIM3:   LD      D, C
DLOOP3: CALL    TIM1
        DEC     D
        JP      NZ, DLOOP3
        RET

TIM1:   LD      B, 31D          ; 100us delay loop
DLOOP1: DEC     B               ; 4 state
        NOP                     ; 4 state
        NOP
        JP      NZ, DLOOP1      ; 10 state
        RET

        END

        
