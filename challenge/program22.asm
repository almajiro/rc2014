;--------------------------------------
;   演習プログラム22
;--------------------------------------
CW      EQU     90H         ; コントロールワード
CWR     EQU     0F3H        ; コントロールワードレジスタ
PADR    EQU     0F0H        ; PORTAレジスタ
PBDR    EQU     0F1H        ; PORTBレジスタ
PCDR    EQU     0F2H        ; PORTCレジスタ

        ORG     0C000H
        LD      A, CW       ; コントロールワードをAレジスタへ
        OUT     (CWR), A    ; コントロールワードレジスタへ出力

LOOP:   IN      A, (PADR)
        OUT     (PCDR), A

        JP      LOOP

        RET

        END

        
