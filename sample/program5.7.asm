;*************************************************************************
;   プログラム5.7   基本論理ゲートプログラム
;*************************************************************************
CW      EQU     90H         ; コントロールワード
CWR     EQU     0F3H        ; コントロールワードレジスタの番地
PADR    EQU     0F0H        ; ポートAデータレジスタの番地
PBDR    EQU     0F1H        ; ポートBデータレジスタの番地
PCDR    EQU     0F2H        ; ポートCデータレジスタの番地

        ORG     8000H
        LD      A, CW       ; コントロールワードのセット
        OUT     (CWR), A    ; コントロールワードレジスタへの出力

STEP:   IN      A, (PADR)   ; スイッチデータの入力
        LD      B, A        ; レジスタB（作業用）への退避
        LD      C, 00H      ; レジスタC（結果）をクリア

        BIT     0, A        ; NOT
        JP      NZ, NT
        SET     0, C
NT:     NOP

        SRL     A           ; NANDの準備
        SRL     B
        SRL     B

        AND     B           ; NAND
        CPL
        BIT     0, A
        JP      Z, ND
        SET     1, C
ND:     NOP

        LD      A, B        ; NORの準備
        SRL     A
        SRL     B
        SRL     B

        OR      B           ; NOR
        CPL
        BIT     0, A
        JP      Z, NR
        SET     2, C
NR:     NOP

        LD      A, C        ; 点灯データの出力
        OUT     (PCDR), A

        JP      STEP        ; 繰り返し
        END
