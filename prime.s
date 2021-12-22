candidate	DCD		122011     ; The input prime candidate
out		DCD		0          ; The output
		
		;		Fast Prime Checker
		;
		;		Runtime benchmarks (in VisUAL assembler):
		;		N = 499    : 541   clock cycles
		;		N = 4421   : 1977  clock cycles
		;		N = 122011 : 10800 clock cycles
		;		(All primes, all under 1000 iterations)
		
		
		ADR		R5, candidate
		LDR		R0, [R5]   ; N := *candidate
		
		
		;		Special case: N <=2
		CMP		R0, #2
		BLT		notprime
		BEQ		prime
		
		
		;		Special case: N % 2 == 0
		;		Allows all future factors that are
		;		multiples of 2 to be eliminated
		ANDS		R5, R0, #1 ; if (N & 1 == 0)
		BEQ		notprime   ;    goto notprime
		
		
		;		Special case: N == 3, 5, 7
		;		Because these numbers are used as the
		;		starting factors, they must checked
		;		specifically to prevent being treated
		;		as composites when they self-divide
		CMP		R0, #3
		CMPNE	R0, #5
		CMPNE	R0, #7
		BEQ		prime
		
		
		;		Calculate  M, equals to N with all
		;		significant digits reversed. This
		;		reduces the instructions needed for
		;		retrieving bits, and also acts as
		;		a counter (the last bit is always 1)
		;		G is the numerical count of bits
		MOV		R2, #0     ; M    := 0
		MOV		R1, R0     ; n    := N
		MOV		R6, #0     ; G    := 0
reverse	AND		R5, R1, #1 ; temp := n & 1
		;		M    := temp | (M << 1)
		ORR		R2, R5, R2, LSL #1
		ADD		R6, R6, #1 ; G    := G + 1
		LSRS		R1, R1, #1 ; if (n:=n>>1 != 0)
		BNE		reverse    ;    goto reverse
		
		
		;		Special case: N % 3 == 0
		;		Use long division and M
		MOV		R3, #0     ; R    := 0
		MOV		R4, R2     ; m    := M
mod3		AND		R5, R4, #1 ; temp := m & 1
		
		;		R    := temp | (R << 1)
		ORR		R3, R5, R3, LSL #1
		CMP		R3, #3     ; if (R > 3)
		SUBGE	R3, R3, #3 ;    R := R - 3
		LSRS		R4, R4, #1 ; if ((m:=m>>1) != 0)
		BNE		mod3       ;    goto mod3
		
		CMP		R3, #0     ; if (R == 0)
		BEQ		notprime   ;    goto notprime
		
		
		;		Find sqrt(N), the upper bound for
		;		any potential factors
		;
		;		Use the square root abacus method
		;		developed by Martin W. Guy (1985).
		;		Given a 32 bit int X, it finds int Q
		;		such that Q^2 <= X < (Q+1)^2.
		;
		;		Originally E is calculated in a loop,
		;		but it can actually be determined from
		;		G, so this loop is eliminated. E must
		;		be even so the last bit is masked off.
		MOV		R1, #0     ; Q    := 0
		MOV		R3, #1     ; E    := 1
		;		|            temp := G & ~1
		AND		R5, R6, #0xFFFFFFFE
		LSL		R3, R3, R5 ; E    := E << temp
		MOV		R4, R0     ; X    := N
		
		
		CMP		R3, #0     ; if (E == 0)
sqrt		BEQ		sqrtfi     ;    goto sqrtfi
		ADD		R5, R1, R3 ; temp := Q + E
		CMP		R4, R5     ; if (X >= temp)
		SUBGE	R4, R4, R5 ;    X := X - temp
		ADDGE	R1, R5, R3 ;    Q := temp + E
		LSR		R1, R1, #1 ; Q    := Q >> 1
		LSRS		R3, R3, #2 ; E    := E >> 2
		B		sqrt       ; goto sqrt
		
		
		;		Put Q into U as the upper bound
		;		and intialize (5,7) sequence pair
sqrtfi	MOV		R6, R1     ; U    := Q
		MOV		R1, #5     ; D    := 5
		MOV		R7, #7     ; D2   := 7
		
		
		;		Use long division to efficiently
		;		calculate modulo R := N % D
		;		i.e. shift remainder 1 left, bring down
		;		1 (binary) digit, then subtract the
		;		divisor if less than the ramainder.
		;		Repeat for all binary digits up to M.
		;
		;		If R is 0 for any chosen factor D,
		;		then the candidate is not prime
		;
		;		Precondition: N%2!=0 and N%3!=0. This
		;		means that for every group of 6
		;		consecutive numbers, there are 4 that
		;		cannot possibly be factors that can be
		;		skipped. This is the 6k+i optimization;
		;		Only 5+6k and 5+2+6k need to be checked.
		;		Here, they are checked in a simutaneous
		;		loop (which allows register sharing)
checfact	MOV		R3, #0     ; R    := 0
		MOV		R8, #0     ; R2   := 0
		MOV		R4, R2     ; m    := M
		
modulo	AND		R5, R4, #1 ; temp := m & 1
		
		;		R    := temp | (R << 1)
		ORR		R3, R5, R3, LSL #1
		CMP		R3, R1     ; if (R > D)
		SUBGE	R3, R3, R1 ;    R := R - D
		
		;		R2   := temp | (R2 << 1)
		ORR		R8, R5, R8, LSL #1
		CMP		R8, R7     ; if (R2 > D2)
		SUBGE	R8, R8, R7 ;   R2 := R2 - D2
		
		LSRS		R4, R4, #1 ; if ((m:=m>>1) != 0)
		BNE		modulo     ;    goto modulo
		
		CMP		R3, #0     ; if (R == 0)
		CMPNE	R8, #0     ; if (R2 == 0)
		BEQ		notprime   ;    goto notprime
		
		;		Check if upper bound has been reached
		ADD		R1, R1, #6 ; D := D + 6
		CMP		R1, R6     ; if (D <= U)
		ADDLE	R7, R7, #6 ;    D2 := D2 + 6
		BLE		checfact   ;    goto checfact
		
		
		;		Finally, store the results
prime	MOV		R2, #1
		ADR		R5, out
		STR		R2, [R5]   ; *out := 1
		END
		
		
notprime	MOV		R2, #0
		ADR		R5, out
		STR		R2, [R5]   ; *out := 0
		END
