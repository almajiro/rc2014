;--------------------------------------
;   演習プログラム9
;--------------------------------------
        ORG     8000H
        LD      A, (DATA)
        LD      B, A
        LD      A, (DATA + 1)
        ADD     A, B
        LD      (STORE), A 
        HALT

        ORG     9C00H
DATA    DEFB    28H
        DEFB    74H
STORE   DEFS    1

        END
