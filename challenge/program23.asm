;--------------------------------------
;   演習プログラム23
;--------------------------------------
CW      EQU     90H         ; コントロールワード
CWR     EQU     0F3H        ; コントロールワードレジスタ
PADR    EQU     0F0H        ; PORTAレジスタ
PBDR    EQU     0F1H        ; PORTBレジスタ
PCDR    EQU     0F2H        ; PORTCレジスタ
SEG     EQU     01H         ; 表示するセグメント

        ORG     0C000H
        LD      A, CW       ; コントロールワードをAレジスタへ
        OUT     (CWR), A    ; コントロールワードレジスタへ出力

        LD      A, SEG
        OUT     (PBDR), A

        LD      D, 0FH

LOOP:   LD      HL, 0
        IN      A, (PADR)
        AND     A, D
        LD      L, A
        LD      BC, HL
        LD      HL, DISP
        ADD     HL, BC
        LD      A, (HL)
        OUT     (PCDR), A

        JP      LOOP

        RET

DISP    DEFB    3FH, 06H, 5BH, 4FH, 66H, 6DH, 7DH
        DEFB    07H, 7FH, 6FH, 77H, 7CH, 58H, 5EH
        DEFB    79H, 71H

        END

        
