;--------------------------------------
;   演習プログラム12
;--------------------------------------
        ORG     8000H
        LD      A, (DATA)
        SLA     A
        SLA     A
        LD      (STORE), A
        HALT

        ORG     9C00H
DATA    DEFB    04H
STORE   DEFS    1

        END
