;--------------------------------------
;   演習プログラム21
;--------------------------------------
CW      EQU     80H         ; コントロールワード
CWR     EQU     0F3H        ; コントロールワードレジスタ
PADR    EQU     0F0H        ; PORTAレジスタ
PBDR    EQU     0F1H        ; PORTBレジスタ
PCDR    EQU     0F2H        ; PORTCレジスタ
LED     EQU     06DH        ; LED点灯パターン
SEG     EQU     002H        ; セグメント選択

        ORG     0C000H
        LD      A, CW       ; コントロールワードをAレジスタへ
        OUT     (CWR), A    ; コントロールワードレジスタへ出力

        LD      A, LED      ; 点灯パターンをAレジスタへ
        OUT     (PADR), A   ; PORTAレジスタへ出力

        LD      A, SEG      ; 点灯させるセグメントを選択
        OUT     (PCDR), A   ; PORTCレジスタへ出力

        RET

        END

        
