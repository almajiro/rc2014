;--------------------------------------
;   演習プログラム1
;--------------------------------------
    ORG     8000H
    LD      A, 55H
    LD      (9000H), A
    HALT
    END
