candidate	DCD		390043
out		DCD		0
		ADR		R5, candidate
		LDR		R0, [R5]
		CMP		R0, #2
		BLT		notprime
		BEQ		prime
		ANDS		R5, R0, #1
		BEQ		notprime
		CMP		R0, #3
		CMPNE	R0, #5
		CMPNE	R0, #7
		BEQ		prime
		MOV		R1, R0
triswap	MOV		R3, #0
trisum	AND		R5, R1, #3
		ADD		R3, R3, R5
		LSRS		R1, R1, #2
		BNE		trisum
		MOV		R1, R3
		CMP		R1, #3
		BGT		triswap
		BEQ		notprime
		MOV		R2, #0
		MOV		R1, R0
		MOV		R6, #0
reverse	AND		R5, R1, #1
		ORR		R2, R5, R2, LSL #1
		ADD		R6, R6, #1
		LSRS		R1, R1, #1
		BNE		reverse
		MOV		R1, #0
		MOV		R3, #1
		AND		R5, R6, #0xFFFFFFFE
		LSL		R3, R3, R5
		MOV		R4, R0
		CMP		R3, #0
sqrt		BEQ		preload
		ADD		R5, R1, R3
		CMP		R4, R5
		SUBGE	R4, R4, R5
		ADDGE	R1, R5, R3
		LSR		R1, R1, #1
		LSRS		R3, R3, #2
		B		sqrt
preload	MOV		R9, R1
		MOV		R1, #5
		MOV		R7, #7
		MOV		R10, #3
		MOV		R11, #8
		SUB		R12, R6, #3
reset	LSR		R4, R2, R10
		LSR		R3, R0, R12
		MOV		R8, R3
modulo	CMP		R3, R1
		SUBGE	R3, R3, R1
		CMP		R8, R7
		SUBGE	R8, R8, R7
		AND		R5, R4, #1
		ORR		R3, R5, R3, LSL #1
		ORR		R8, R5, R8, LSL #1
		LSRS		R4, R4, #1
		BNE		modulo
		CMP		R3, #0
		CMPNE	R3, R1
		CMPNE	R8, #0
		CMPNE	R8, R7
		BEQ		notprime
		ADD		R1, R1, #6
		CMP		R1, R9
		BGT		prime
		ADD		R7, R7, #6
		ANDS		R5, R1, R11
		BEQ		reset
		ADD		R10, R10, #1
		LSL		R11, R11, #1
		SUB		R12, R6, R10
		B		reset
prime	MOV		R0, #1
		ADR		R5, out
		STR		R0, [R5]
		END
notprime	MOV		R0, #0
		ADR		R5, out
		STR		R0, [R5]
		END
