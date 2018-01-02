;--------------------------------------
;   演習プログラム16
;--------------------------------------
        ORG     8000H
        LD      A, (DATA + 1)
        LD      B, A
        LD      A, (DATA)
        LD      C, A
        LD      A, 00H

LOOP:   ADD     A, C
        DJNZ    LOOP

        LD      (STORE), A

        HALT

        ORG     9C00H
DATA    DEFB    06H
        DEFB    0AH
STORE   DEFS    1
        END
