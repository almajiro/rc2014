;--------------------------------------
;   演習プログラム4
;--------------------------------------
        ORG     8000H
        LD      A, 0FH
LOOP:   DEC     A
        JP      NZ, LOOP
        HALT
        END
