;--------------------------------------
;   演習プログラム17
;--------------------------------------
        ORG     8000H

        ; 準備
        LD      A, (DATA)
        LD      B, A            ; 掛けられる数
        LD      A, (DATA + 1)
        LD      C, A            ; 掛ける数
        LD      A, 00H          ; 計算結果

        ; 計算
LOOP:   BIT     0,C
        JP      Z, NEXT

        ADD     A, B

NEXT    SLA     B
        SRL     C
        JP      NZ, LOOP

        LD      (STORE), A

        HALT

        ORG     9C00H
DATA    DEFB    05H
        DEFB    0BH
STORE   DEFS    1
        END
