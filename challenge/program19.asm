;--------------------------------------
;   演習プログラム19
;--------------------------------------
        ORG     8000H

        ; 準備
        LD      A, (DATA + 1)
        LD      B, A            ; 割る数
        LD      A, (DATA)       ; 割られる数
        LD      C, 00H          ; 商
        LD      D, 01H          ; マスク

LOOP1:  CP      B
        JP      M, NEXT
        SLA     B
        SLA     D
        JP      LOOP1

NEXT:   SRL     B
        SRL     D

LOOP2:  CP      B
        JP      M, FIN
        SUB     B
        CALL    CNTUP
        SRL     B
        SRL     D
        JP      NZ, LOOP2

FIN     LD      (STORE + 1), A
        LD      A, C
        LD      (STORE), A
        HALT

        
CNTUP:  PUSH    AF
        LD      A, C
        ADD     A, D
        LD      C, A
        POP     AF
        RET

        ORG     9C00H
DATA    DEFB    52H
        DEFB    0BH
STORE   DEFS    2
        END
