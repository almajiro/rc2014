;--------------------------------------
;   演習プログラム2
;--------------------------------------
    ORG     8000H
    LD      A, 00
    INC     A
    LD      B, 05H
    ADD     A, B
    HALT
    END