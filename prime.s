candidate	dcd		390043     ; The input prime candidate
out		dcd		0          ; The output
		
		;		Fast Prime Checker
		;
		;		Runtime benchmarks (in VisUAL assembler):
		;		N = 499    : 420   clock cycles
		;		N = 4421   : 1341  clock cycles
		;		N = 122011 : 7142  clock cycles
		;		N = 390043 : 13962 clock cycles
		;		(All primes, all under 1000 iterations)
		
		
		adr		R5, candidate
		ldr		R0, [R5]
		
		
		;		Special case: N <=2
		cmp		R0, #2
		blt		notprime
		beq		prime
		
		
		;		Special case: N % 2 == 0
		;		Check whether the last bit is set.
		;		This eliminates all even factors.
		ands		R5, R0, #1 ; if (N & 1 == 0)
		beq		notprime   ;    goto notprime
		
		
		;		Special case: N == 3, 5, 7
		;		Because these numbers are used as the
		;		starting factors, they must checked
		;		specifically to prevent being treated
		;		as composites when they self-divide
		cmp		R0, #3
		cmpne	R0, #5
		cmpne	R0, #7
		beq		prime
		
		
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
		mov		R1, R0     ; x    := N
		
triswap
		mov		R3, #0     ; S    := 0
trisum
		and		R5, R1, #3 ; temp := x & 3
		add		R3, R3, R5 ; S    := S + temp
		lsrs		R1, R1, #2 ; if (x:=x>>2 != 0)
		bne		trisum     ;    goto trisum
		
		mov		R1, R3     ; x    := S
		cmp		R1, #3     ; if (x > 3)
		bgt		triswap    ;    goto triswap
		;		|          ; if (x == 3)
		beq		notprime   ;    goto notprime
		
		
		;		Calculate  M, equals to N with all
		;		significant digits reversed. This
		;		reduces the instructions needed for
		;		retrieving bits, and also acts as
		;		a counter (the last bit is always 1)
		;		G is the numerical count of bits
		mov		R2, #0     ; M    := 0
		mov		R1, R0     ; n    := N
		mov		R6, #0     ; G    := 0
reverse
		and		R5, R1, #1 ; temp := n & 1
		;		|            M    := temp | (M << 1)
		orr		R2, R5, R2, LSL #1
		add		R6, R6, #1 ; G    := G + 1
		lsrs		R1, R1, #1 ; if (n:=n>>1 != 0)
		bne		reverse    ;    goto reverse
		
		
		;		Find floor(sqrt(N)), the upper bound
		;		for any potential factors of N
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
		mov		R1, #0     ; Q    := 0
		mov		R3, #1     ; E    := 1
		;		|            temp := G & ~1
		and		R5, R6, #0xFFFFFFFE
		lsl		R3, R3, R5 ; E    := E << temp
		mov		R4, R0     ; X    := N
		
		
		cmp		R3, #0     ; if (E == 0)
sqrt
		beq		preload    ;    goto preload
		add		R5, R1, R3 ; temp := Q + E
		cmp		R4, R5     ; if (X >= temp)
		subge	R4, R4, R5 ;    X := X - temp
		addge	R1, R5, R3 ;    Q := temp + E
		lsr		R1, R1, #1 ; Q    := Q >> 1
		lsrs		R3, R3, #2 ; E    := E >> 2
		b		sqrt       ; goto sqrt
		
		
		;		Prepare data for the main loop
		;
		;		Registers that should not change:
		;		| R2 holds M, the reverse of N
		;		| R6 holds G, the # of digits in N
		;		| R9 holds U, the upper bound
		;
		;		Swap Q into U as the upper bound
preload
		mov		R9, R1     ; U    := Q
		
		;		Get ready to compute modulo by first
		;		initializing a pair of factors (5,7)
		;		to be checked simultaneously.
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
		mov		R1, #5     ; D1   := 5
		mov		R7, #7     ; D2   := 7
		
		
		;		Keep track of the number of "preload"
		;		digits prior to entering the main
		;		loop, allowing bits higher than
		;		nbits(N)-nbits(D) to be set into
		;		the remainder registers. Since
		;		R can never be greater than 2*D if R
		;		and D have the same number of bits,
		;		division still works while reducing
		;		the execution time.
		;
		;		Since the lowest possible factor is 5,
		;		there can be at *least* 3 bits loaded
		;		into the remainer (initialized next).
		;		These change when D increases.
		;
		;		| J is the number of loaded bits
		;		| L is G - J, where (N >> L) becomes
		;		|    the first J bits of N shifted.
		mov		R10, #3     ; J    := 3
		sub		R12, R6, #3 ; L    := G - 3
		
		
		;		Reset registers to check for the next
		;		pair of potential factors 5 + 6k and
		;		5 + 6k + 2, taking into account the
		;		offsets J and L for preloading.
reset
		lsr		R4, R2, R10 ; m    := M >> J
		lsr		R3, R0, R12 ; R1   := N >> L
		mov		R8, R3      ; R2   := R1
		
		
		;		Apply long division to calculate
		;		remainders R1 and R2 against their
		;		respective factors D1 and D2.
		;
		;		Steps:
		;		1. Subtract D from R if R > D.
		;		2. Bring down next bit from m
		;		3. If m has more bits, repeat
		;		4. If R==0 or R==D, D is a factor
modulo
		cmp		R3, R1     ; if (R1 >= D1)
		subge	R3, R3, R1 ;    R1 := R1 - D1
		cmp		R8, R7     ; if (R2 >= D2)
		subge	R8, R8, R7 ;    R2 := R2 - D2
		
		
		and		R5, R4, #1 ; temp := m & 1
		
		;		|            R1   := temp | (R1 << 1)
		orr		R3, R5, R3, LSL #1
		;		|            R2   := temp | (R2 << 1)
		orr		R8, R5, R8, LSL #1
		
		
		lsrs		R4, R4, #1 ; if ((m:=m>>1) != 0)
		bne		modulo     ;    goto modulo
		
		cmp		R3, #0     ; if (R1 == 0)
		cmpne	R3, R1     ; if (R1 == D1)
		cmpne	R8, #0     ; if (R2 == 0)
		cmpne	R8, R7     ; if (R1 == D2)
		beq		notprime   ;    goto notprime
		
		
		;		Increment the pair of factors. If the
		;		lower factor is greater than the upper
		;		bound, then N must be prime.
		add		R1, R1, #6 ; D1   := D1 + 6
		cmp		R1, R9     ; if (D1 > U)
		bgt		prime      ;    goto prime
		
		;		Otherwise, continue checking with the
		;		next pair of factors.
		add		R7, R7, #6 ; D2   := D2 + 6
		
		;		Check whether a new bit can be preloaded
		;		next. If so, increase J and decrease L
		lsrs		R5, R1, R10  ; if (D1>>J == 0)
		beq		reset        ;    goto reset
		
		add		R10, R10, #1 ; J    := J + 1
		sub		R12, R6, R10 ; L    := G - J
		b		reset        ; goto reset
		
		
prime
		mov		R0, #1
		adr		R5, out
		str		R0, [R5]
		end
		
		
notprime
		mov		R0, #0
		adr		R5, out
		str		R0, [R5]
		end
