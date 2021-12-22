numb		DCD		579
		
		ADR		R5, numb
		LDR		R0, [R5]
		
		
		
		;		Use the fact that if the sum of the
		;		digits in two bit chunks of n is
		;		divisible by 3, then n % 3 == 0
		;		-- just check if result is equal to 3
		;		-- it can never be 0
		
		MOV		R1, R0	 ; x    := N
		
triswap	MOV		R2, #0     ; S    := 0
trisum	AND		R5, R1, #3 ; temp := x & 3
		ADD		R2, R2, R5 ; S    := S + temp
		LSRS		R1, R1, #2 ; if (x:=x>>2 != 0)
		BNE		trisum     ;    goto trisum
		MOV		R1, R2     ; x    := S
		CMP		R1, #3     ; if (x > 3)
		BGT		triswap    ;    goto triswap
		;		|                  ; if (x == 3)
		BEQ		div3       ;    goto div3
		
		
ndiv3	END
		
div3		END
