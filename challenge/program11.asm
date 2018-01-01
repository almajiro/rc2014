;-----------------------------------------------------------------------
;   演習プログラム11
;   AND, OR, XOR, NAND, NORの順
;-----------------------------------------------------------------------
        ORG     8000H
        LD      A, (DATA + 1)
        LD      B, A
        LD      A, (DATA)
        LD      C, A            ; レジスタCへレジスタAの内容をコピー

        AND     B               ; AND
        LD      (STORE), A

        CPL                     ; NAND
        LD      (STORE + 3), A

        LD      A, C
        OR      B               ; OR
        LD      (STORE + 1), A

        CPL                     ; NOR
        LD      (STORE + 4), A

        LD      A, C
        XOR     B               ; XOR
        LD      (STORE + 2), A
        
        HALT

        ORG     9C00H
DATA    DEFB    0BCH
        DEFB    69H
STORE   DEFS    5

        END
