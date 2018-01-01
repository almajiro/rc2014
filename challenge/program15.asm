;--------------------------------------
;   演習プログラム15
;   DATAのビットの1の数をレジスタB
;   0の数をレジスタCに格納
;--------------------------------------
        ORG     8000H
        LD      A, (DATA)
        LD      C, A        ; 対象データ
        LD      A, 00H      ; カウンタ
        LD      B, 08H      ; ループ用カウンタ

        LD      D, 00H      ; 1のカウント (仮
        LD      E, 00H      ; 0のカウント (仮

LOOP:   SRL     C
        JP      NC, BIT0

BIT1:   LD      A, D
        ADD     A, 01H
        LD      D, A
        JP      NEXT

BIT0:   LD      A, E
        ADD     A, 01H
        LD      E, A
NEXT:   DJNZ    LOOP

        LD      B, D        ; 仕上げ
        LD      C, E

        HALT

        ORG     9C00H
DATA    DEFB    0ABH
        END
