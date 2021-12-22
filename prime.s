candidate	DCD		122011     ; The input prime candidate
out		DCD		0          ; The output
		
		;		Fast Prime Checker
		;
		;		Runtime benchmarks (in VisUAL assembler):
		;		N = 499    : 500   clock cycles
		;		N = 4421   : 1812  clock cycles
		;		N = 122011 : 11104 clock cycles
		;		(All primes, all under 1000 iterations)
		
		
		ADR		R5, candidate
		LDR		R0, [R5]   ; N := *candidate
		
		
		;		Special case: N <=2
		CMP		R0, #2
		BLT		notprime
		BEQ		prime
		
		
		;		Special case: N % 2 == 0
		;		Check whether the last bit is set.
		;		This eliminates all even factors.
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
		
		
		;		Special case: N % 3 == 0
		;
		;		Use the fact that in base-4, if the
		;		sum of all digits is a multiple of 3,
		;		then the number is also a multiple of 3.
		;		In binary, shifting by 2 has the same
		;		effect as base-4. The code continuously
		;		replaces x with the sum of its digits
		;		in base-4 until x is less than 3. Then,
		;		if x *is* equal to 3, N cannot be prime.
		MOV		R1, R0	 ; x    := N
		
triswap	MOV		R3, #0     ; S    := 0
trisum	AND		R5, R1, #3 ; temp := x & 3
		ADD		R3, R3, R5 ; S    := S + temp
		LSRS		R1, R1, #2 ; if (x:=x>>2 != 0)
		BNE		trisum     ;    goto trisum
		MOV		R1, R3     ; x    := S
		CMP		R1, #3     ; if (x > 3)
		BGT		triswap    ;    goto triswap
		;		|          ; if (x == 3)
		BEQ		notprime   ;    goto notprime
		
		
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
		;		|            M    := temp | (M << 1)
		ORR		R2, R5, R2, LSL #1
		ADD		R6, R6, #1 ; G    := G + 1
		LSRS		R1, R1, #1 ; if (n:=n>>1 != 0)
		BNE		reverse    ;    goto reverse
		
		
		;		Find sqrt(N), the upper bound for
		;		any potential factors
		;
		;		Use the square root abacus method
		;		developed by Martin W. Guy (1985).
		;		Given a 32 bit int X, it finds int Q
		;		such that Q^2 <= X < (Q+1)^2.
		;
		;		Originally E was calculated in a loop,
		;		but here it can directly be found from
		;		G, so this loop is eliminated. E must
		;		be even so the last bit is masked off.
		MOV		R1, #0     ; Q    := 0
		MOV		R3, #1     ; E    := 1
		;		|            temp := G & ~1
		AND		R5, R6, #0xFFFFFFFE
		LSL		R3, R3, R5 ; E    := E << temp
		MOV		R4, R0     ; X    := N
		
		
		CMP		R3, #0     ; if (E == 0)
sqrt		BEQ		preload    ;    goto preload
		ADD		R5, R1, R3 ; temp := Q + E
		CMP		R4, R5     ; if (X >= temp)
		SUBGE	R4, R4, R5 ;    X := X - temp
		ADDGE	R1, R5, R3 ;    Q := temp + E
		LSR		R1, R1, #1 ; Q    := Q >> 1
		LSRS		R3, R3, #2 ; E    := E >> 2
		B		sqrt       ; goto sqrt
		
		
		;		Swap Q into U as the upper bound
preload	MOV		R6, R1     ; U    := Q
		
		;		Get ready to compute modulo by first
		;		initializing a pair of factors (5,7)
		;		to be calculated simultaneously.
		;
		;		From this point on, it is known that
		;		N % 2 != 0 and N % 3 != 0. This means
		;		that for every group of 6 consecutive
		;		numbers starting from 5, only two of
		;		them can possibly be a factor of N.
		;		The other 4 checked cases are:
		;		|   5 + 6k + 1 -> Multiple of 2
		;		|   5 + 6k + 3 -> Multiple of 2
		;		|   5 + 6k + 4 -> Multiple of 3
		;		|   5 + 6k + 5 -> Multiple of 2
		;		This means that only theses cases need
		;		to be checked for testing primality:
		;		|   5 + 6k
		;		|   5 + 6k + 2
		MOV		R1, #5     ; D1   := 5
		MOV		R7, #7     ; D2   := 7
		
		
		;		Use long division to efficiently
		;		calculate modulo R := N % D
		;		i.e. shift remainder 1 left, bring down
		;		1 (binary) digit, then subtract the
		;		divisor if less than the ramainder.
		;		Repeat for all binary digits up to M.
reset	MOV		R3, #1     ; R1   := 1
		MOV		R8, #1     ; R2   := 1
		LSR		R4, R2, #1 ; m    := M >> 1
		
		
modulo	AND		R5, R4, #1 ; temp := m & 1
		
		;		|            R1   := temp | (R1 << 1)
		ORR		R3, R5, R3, LSL #1
		CMP		R3, R1     ; if (R1 > D1)
		SUBGE	R3, R3, R1 ;   R1 := R1 - D1
		
		;		|            R2   := temp | (R2 << 1)
		ORR		R8, R5, R8, LSL #1
		CMP		R8, R7     ; if (R2 > D2)
		SUBGE	R8, R8, R7 ;    R2 := R2 - D2
		
		LSRS		R4, R4, #1 ; if ((m:=m>>1) != 0)
		BNE		modulo     ;    goto modulo
		
		CMP		R3, #0     ; if (R1 == 0)
		CMPNE	R8, #0     ; if (R2 == 0)
		BEQ		notprime   ;    goto notprime
		
		;		Increment the test factors, and if
		;		they are under the upper bound, reset
		;		the modulo registers and restart.
		;		Otherwise N must be prime.
		ADD		R1, R1, #6 ; D1   := D1 + 6
		CMP		R1, R6     ; if (D <= U)
		ADDLE	R7, R7, #6 ;    D2 := D2 + 6
		BLE		reset   ;    goto reset
		
		
		;		Finally, store the results
prime	MOV		R2, #1
		ADR		R5, out
		STR		R2, [R5]   ; *out := 1
		END
		
		
notprime	MOV		R2, #0
		ADR		R5, out
		STR		R2, [R5]   ; *out := 0
		END
