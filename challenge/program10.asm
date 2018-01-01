;--------------------------------------
;   演習プログラム10
;--------------------------------------
        ORG     8000H
        LD      A, (DATA)
        LD      B, A
        LD      A, (DATA + 1)
        
        CP      B
        JP      M, MIN
        LD      A, 0DDH
        JP      FIN
MIN:    LD      A, 0AAH
FIN:    LD      (STORE), A
        HALT

        ORG     9C00H
DATA    DEFB    21H
        DEFB    01H
STORE   DEFS    1

        END
