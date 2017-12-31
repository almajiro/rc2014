;*************************************************************************
;   プログラム5.10  ライントレースカープログラム
;*************************************************************************
SP_A    EQU     9000H       ; SPの設定
CW      EQU     90H         ; コントロールワード
CWR     EQU     0F3H        ; コントロールワードレジスタの番地
PADR    EQU     0F0H        ; ポートAデータレジスタの番地
PBDR    EQU     0F1H        ; ポートBデータレジスタの番地
PCDR    EQU     0F2H        ; ポートCデータレジスタの番地

        ORG     8000H
        LD      A, CW       ; コントロールワードのセット
        OUT     (CWR), A    ; コントロールワードレジスタへの出力
        LD      SP, SP_A    ; SPの設定

        LD      A, 00H      ; モータ停止
        OUT     (PCDR), A

STEP1:  CALL    READ1       ; センサ読み込み
        CALL    MOT1        ; モータ制御
        JP      STEP1

        HALT

READ1:  IN      A, (PADR)   ; １回目センサ入力
        LD      B, 03H      ; マスク用データ
        AND     B           ; マスク
        LD      C, A        ; データ退避

        CALL    TIM2        ; タイマサブルーチン呼び出し

        IN      A, (PADR)   ; ２回目センサ入力
        AND     B           ; マスク

        CP      C           ; データの比較
        JP      NZ, READ1   ; 不一致の場合は棄却
        LD      B, A
        RET

MOT1:   BIT     1, B        ; 左センサ黒か
        JP      NZ, MOT2
        BIT     0, B        ; 右センサ黒か
        JP      NZ, MOT3
        LD      A, 03H      ; 直進
        JP      MOT4
MOT2:   LD      A, 01H      ; 左折
        JP      MOT4
MOT3:   LD      A, 02H      ; 右折
MOT4:   OUT     (PCDR), A
        RET

TIM2:   LD      D, 50D      ; 上位のタイマサブルーチン5.129ms
L2:     CALL    TIM1
        DEC     D
        JP      NZ, L2
        RET

TIM1:   LD      E, 67D      ; 下位のタイマサブルーチン100µs
L1:     DEC     E
        NOP
        JP      NZ, L1
        RET

        END
