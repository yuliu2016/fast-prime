		;		New remainder algorithm
		
Num		DCD		4421
Den		DCD		19
		
		ADR		R5, Num
		LDR		R0, [R5]
		ADR		R5, Den
		LDR		R1, [R5]
		
		MOV		R6, #7 ; T = 7
		
		LSL		R2, R1, R6 ; D = Den << T
		
		MOV		R3, R0 ; R = N
		
modulo	CMP		R3, R2 ; (R > D)
		SUBGE	R3, R3, R2 ; R=R-D
		LSR		R2, R2, #1 ; D=D>>1
		CMP		R1, R2
		BNE		modulo
		
		CMP		R3, R2 ; (R > D)
		SUBGE	R3, R3, R2 ; R=R-D
		
		END
