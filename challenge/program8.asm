;--------------------------------------
;   演習プログラム8
;--------------------------------------
        ORG     8000H

        LD      A, 50H
        LD      (9C00H), A
        LD      A, 32H
        LD      (9C91H), A

        LD      A, (9C00H)
        PUSH    AF
        LD      A, (9C01H)
        LD      (9C00H), A
        POP     AF
        LD      (9C00H), A

        HALT
        END
