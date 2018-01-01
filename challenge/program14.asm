;--------------------------------------
;   演習プログラム14
;--------------------------------------
        ORG     8000H
        LD      A, (DATA)
        LD      C, A
        LD      B, 08H
        LD      A, 00H
LOOP:   SRL     C
        JP      NC, SKIP
        ADD     A, 01H
SKIP:   DJNZ    LOOP
        LD      B, A
        HALT

        ORG     9C00H
DATA    DEFB    0ABH
        END
