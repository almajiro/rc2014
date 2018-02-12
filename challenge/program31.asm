;--------------------------------------
;   演習プログラム30
;--------------------------------------
CW      EQU     90H             ; コントロールワード
CWR     EQU     0F3H            ; コントロールワードレジスタ
PADR    EQU     0F0H            ; PORTAレジスタ
PBDR    EQU     0F1H            ; PORTBレジスタ
PCDR    EQU     0F2H            ; PORTCレジスタ
SP_A    EQU     0C200H          ; SP

        ORG     0C000H
        LD      A, CW           ; コントロールワードをAレジスタへ
        OUT     (CWR), A        ; コントロールワードレジスタへ出力
        LD      SP, SP_A

LOOP:	LD	A, 01H
	OUT     (PBDR), A
	LD	B, 01H 	        ; 表示中のセグメント

	IN	A, (PADR)
	LD	E, A	        ; 動く方向の選択
				; 1 右回り
				; 0 左回り

	BIT	0, E
	LD	A, 01H		; 表示パターン
	JP	NZ, ACTION
	LD	A, 20H		; 表示パターン
	JP	ACTION

ACTION:	LD      C, 04H          ; カウンタ

CNT:    OUT     (PCDR), A       ; 表示パターンの変更
        CALL    TIM3

CHK1:   BIT     0, A            ; 01Hの時
        JP      Z, CHK2

        DEC     C
        JP      Z, NEXT         ; カウンタが0の場合

        BIT     0, E
        JP      Z, CHK1S
        CALL    SEGR
        JP      CNT
CHK1S:  CALL    SEGL
        JP      CNT
        
CHK2:   BIT     3, A            ; 08Hの時
        JP      Z, NEXT

        DEC     C
        JP      Z, NEXT         ; カウンタが0の場合

        BIT     0, E
        JP      Z, CHK2S
        CALL    SEGL
        JP      CNT
CHK2S:  CALL    SEGR
        JP      CNT

; 次のパターンへの準備
NEXT:   BIT     0, E            ; 方向の判定
        JP      Z, PRE
        SLA     A               ; 左へビットシフト
        LD      D, 40H
        CP      D
        JP      Z, LOOP         ; パターンのシフトが終わったらLOOPへ
        JP      GNEXT           ; 次のパターンへ (CNT)

PRE:    SRL     A
        JP      NZ, GNEXT       ; 次のパターンへ (CNT)
        JP      Z, LOOP         ; パータンのシフトが終わったらLOOPへ

GNEXT:  LD      C, 04H
        JP      CNT

        RET

; その他のサブルーチン
; 左へセグメントをシフト
SEGL:   PUSH    AF
        LD      A, B
        SRL     A
        OUT     (PBDR), A
        LD      B, A
        POP     AF
        RET

; 右へセグメントをシフト
SEGR:   PUSH    AF
        LD      A, B
        SLA     A
        OUT     (PBDR), A
        LD      B,A
        POP     AF
        RET

; タイマールーチン
TIM3:   LD      D, 5D
        PUSH    BC
        PUSH    DE
DLOOP3: CALL    TIM2
        DEC     D
        JP      NZ, DLOOP3
        POP     DE
        POP     BC
        RET

; 10ms Delay
TIM2:   LD      C, 100D 
DLOOP2: CALL    TIM1
        DEC     C
        NOP
        NOP
        JP      NZ, DLOOP2
        RET

; 100ns Delay
TIM1:   LD      B, 31D
DLOOP1: DEC     B 
        NOP 
        NOP
        JP      NZ, DLOOP1
        RET

        END 
