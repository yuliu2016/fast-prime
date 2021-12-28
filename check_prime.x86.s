	.file	"check_prime.c"
 # GNU C17 (Rev5, Built by MSYS2 project) version 10.3.0 (x86_64-w64-mingw32)
 #	compiled by GNU C version 10.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.24-GMP

 # GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
 # options passed: 
 # -iprefix C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.3.0/
 # -D_REENTRANT check_prime.c -mtune=generic -march=x86-64 -O3
 # -fverbose-asm
 # options enabled:  -faggressive-loop-optimizations -falign-functions
 # -falign-jumps -falign-labels -falign-loops -fallocation-dce
 # -fasynchronous-unwind-tables -fauto-inc-dec -fbranch-count-reg
 # -fcaller-saves -fcode-hoisting -fcombine-stack-adjustments
 # -fcompare-elim -fcprop-registers -fcrossjumping -fcse-follow-jumps
 # -fdefer-pop -fdelete-null-pointer-checks -fdevirtualize
 # -fdevirtualize-speculatively -fdwarf2-cfi-asm -fearly-inlining
 # -feliminate-unused-debug-symbols -feliminate-unused-debug-types
 # -fexpensive-optimizations -fforward-propagate -ffp-int-builtin-inexact
 # -ffunction-cse -fgcse -fgcse-after-reload -fgcse-lm -fgnu-unique
 # -fguess-branch-probability -fhoist-adjacent-loads -fident
 # -fif-conversion -fif-conversion2 -findirect-inlining -finline
 # -finline-atomics -finline-functions -finline-functions-called-once
 # -finline-small-functions -fipa-bit-cp -fipa-cp -fipa-cp-clone -fipa-icf
 # -fipa-icf-functions -fipa-icf-variables -fipa-profile -fipa-pure-const
 # -fipa-ra -fipa-reference -fipa-reference-addressable -fipa-sra
 # -fipa-stack-alignment -fipa-vrp -fira-hoist-pressure
 # -fira-share-save-slots -fira-share-spill-slots
 # -fisolate-erroneous-paths-dereference -fivopts -fkeep-inline-dllexport
 # -fkeep-static-consts -fleading-underscore -flifetime-dse
 # -floop-interchange -floop-unroll-and-jam -flra-remat -fmath-errno
 # -fmerge-constants -fmerge-debug-strings -fmove-loop-invariants
 # -fomit-frame-pointer -foptimize-sibling-calls -foptimize-strlen
 # -fpartial-inlining -fpeel-loops -fpeephole -fpeephole2 -fpic -fplt
 # -fpredictive-commoning -fprefetch-loop-arrays -free -freg-struct-return
 # -freorder-blocks -freorder-blocks-and-partition -freorder-functions
 # -frerun-cse-after-loop -fsched-critical-path-heuristic
 # -fsched-dep-count-heuristic -fsched-group-heuristic -fsched-interblock
 # -fsched-last-insn-heuristic -fsched-rank-heuristic -fsched-spec
 # -fsched-spec-insn-heuristic -fsched-stalled-insns-dep -fschedule-fusion
 # -fschedule-insns2 -fsemantic-interposition -fset-stack-executable
 # -fshow-column -fshrink-wrap -fshrink-wrap-separate -fsigned-zeros
 # -fsplit-ivs-in-unroller -fsplit-loops -fsplit-paths -fsplit-wide-types
 # -fssa-backprop -fssa-phiopt -fstdarg-opt -fstore-merging
 # -fstrict-aliasing -fstrict-volatile-bitfields -fsync-libcalls
 # -fthread-jumps -ftoplevel-reorder -ftrapping-math -ftree-bit-ccp
 # -ftree-builtin-call-dce -ftree-ccp -ftree-ch -ftree-coalesce-vars
 # -ftree-copy-prop -ftree-cselim -ftree-dce -ftree-dominator-opts
 # -ftree-dse -ftree-forwprop -ftree-fre -ftree-loop-distribute-patterns
 # -ftree-loop-distribution -ftree-loop-if-convert -ftree-loop-im
 # -ftree-loop-ivcanon -ftree-loop-optimize -ftree-loop-vectorize
 # -ftree-parallelize-loops= -ftree-partial-pre -ftree-phiprop -ftree-pre
 # -ftree-pta -ftree-reassoc -ftree-scev-cprop -ftree-sink
 # -ftree-slp-vectorize -ftree-slsr -ftree-sra -ftree-switch-conversion
 # -ftree-tail-merge -ftree-ter -ftree-vrp -funit-at-a-time
 # -funswitch-loops -funwind-tables -fverbose-asm
 # -fversion-loops-for-strides -fzero-initialized-in-bss
 # -m128bit-long-double -m64 -m80387 -maccumulate-outgoing-args
 # -malign-double -malign-stringops -mavx256-split-unaligned-load
 # -mavx256-split-unaligned-store -mfancy-math-387 -mfentry -mfp-ret-in-387
 # -mfxsr -mieee-fp -mlong-double-80 -mmmx -mms-bitfields -mno-sse4
 # -mpush-args -mred-zone -msse -msse2 -mstack-arg-probe -mstackrealign
 # -mvzeroupper

	.text
	.p2align 4
	.globl	check_prime
	.def	check_prime;	.scl	2;	.type	32;	.endef
	.seh_proc	check_prime
check_prime:
	pushq	%r12	 #
	.seh_pushreg	%r12
	pushq	%rbp	 #
	.seh_pushreg	%rbp
	pushq	%rdi	 #
	.seh_pushreg	%rdi
	pushq	%rsi	 #
	.seh_pushreg	%rsi
	pushq	%rbx	 #
	.seh_pushreg	%rbx
	.seh_endprologue
 # check_prime.c:6:     if (N < 2) return 0;
	xorl	%eax, %eax	 # <retval>
 # check_prime.c:5: int check_prime(uint32_t N) {
	movl	%ecx, %esi	 # tmp138, N
 # check_prime.c:6:     if (N < 2) return 0;
	cmpl	$1, %ecx	 #, N
	jbe	.L1	 #,
 # check_prime.c:7:     if (N == 2) return 1;
	leal	-2(%rcx), %edx	 #, tmp118
 # check_prime.c:7:     if (N == 2) return 1;
	movl	$1, %eax	 #, <retval>
 # check_prime.c:7:     if (N == 2) return 1;
	cmpl	$1, %edx	 #, tmp118
	jbe	.L1	 #,
 # check_prime.c:9:     if (N == 3 || N == 5 || N == 7) return 1;
	movl	%ecx, %edx	 # N, tmp119
	andl	$-3, %edx	 #, tmp119
 # check_prime.c:9:     if (N == 3 || N == 5 || N == 7) return 1;
	cmpl	$5, %edx	 #, tmp119
	je	.L1	 #,
	movl	%ecx, %eax	 # N, x
	.p2align 4,,10
	.p2align 3
.L4:
	movl	%eax, %r8d	 # x, M
 # check_prime.c:14:         S = 0;
	xorl	%eax, %eax	 # x
	.p2align 4,,10
	.p2align 3
.L3:
 # check_prime.c:16:             S += x & 3;
	movl	%r8d, %edx	 # M, tmp120
	andl	$3, %edx	 #, tmp120
 # check_prime.c:16:             S += x & 3;
	addl	%edx, %eax	 # tmp120, x
 # check_prime.c:17:         } while((x = x >> 2));
	shrl	$2, %r8d	 #, M
	jne	.L3	 #,
 # check_prime.c:19:     } while (x > 3);
	cmpl	$3, %eax	 #, x
	ja	.L4	 #,
 # check_prime.c:6:     if (N < 2) return 0;
	movl	$0, %eax	 #, <retval>
 # check_prime.c:20:     if (x == 3) return 0;
	je	.L1	 #,
 # check_prime.c:24:     uint32_t G = 0;
	xorl	%ecx, %ecx	 # G
	movl	%esi, %ebx	 # N, n
	.p2align 4,,10
	.p2align 3
.L5:
 # check_prime.c:26:         M = (M << 1) | (n & 1);
	movl	%ebx, %eax	 # n, tmp121
 # check_prime.c:26:         M = (M << 1) | (n & 1);
	addl	%r8d, %r8d	 # _5
	movl	%ecx, %ebp	 # G, G
 # check_prime.c:26:         M = (M << 1) | (n & 1);
	andl	$1, %eax	 #, tmp121
 # check_prime.c:27:         G = G + 1;
	leal	1(%rcx), %ecx	 #, G
 # check_prime.c:26:         M = (M << 1) | (n & 1);
	orl	%eax, %r8d	 # tmp121, M
 # check_prime.c:28:     } while((n = n >> 1));
	shrl	%ebx	 # n
	jne	.L5	 #,
 # check_prime.c:31:     uint32_t E = 1 << (G & ~1);
	andl	$-2, %ecx	 #, tmp122
 # check_prime.c:31:     uint32_t E = 1 << (G & ~1);
	movl	$1, %eax	 #, tmp123
	sall	%cl, %eax	 # tmp122, E
 # check_prime.c:31:     uint32_t E = 1 << (G & ~1);
	movl	%esi, %ecx	 # N, X
	.p2align 4,,10
	.p2align 3
.L9:
 # check_prime.c:36:         t = Q + E;
	leal	(%rax,%rbx), %edx	 #, t
 # check_prime.c:37:         if (X >= t) {
	cmpl	%ecx, %edx	 # X, t
	ja	.L6	 #,
 # check_prime.c:39:             Q = t + E;
	leal	(%rdx,%rax), %ebx	 #, Q
 # check_prime.c:38:             X = X - t;
	subl	%edx, %ecx	 # t, X
 # check_prime.c:41:         Q = Q >> 1;
	shrl	%ebx	 # n
 # check_prime.c:42:     } while((E = E >> 2));
	shrl	$2, %eax	 #, E
	jne	.L9	 #,
.L8:
 # check_prime.c:48:     uint32_t L = G - 3;
	leal	-2(%rbp), %r12d	 #, L
 # check_prime.c:47:     uint32_t J = 3;
	movl	$3, %edi	 #, J
 # check_prime.c:46:     uint32_t D2 = 7;
	movl	$7, %r11d	 #, D2
 # check_prime.c:45:     uint32_t D1 = 5;
	movl	$5, %r10d	 #, D1
	.p2align 4,,10
	.p2align 3
.L10:
 # check_prime.c:54:         m = M >> J;
	movl	%edi, %ecx	 # J, tmp143
	movl	%r8d, %r9d	 # M, m
 # check_prime.c:55:         R1 = N >> L;
	movl	%esi, %eax	 # N, R1
 # check_prime.c:54:         m = M >> J;
	shrl	%cl, %r9d	 # tmp143, m
 # check_prime.c:55:         R1 = N >> L;
	movl	%r12d, %ecx	 # L, tmp145
	shrl	%cl, %eax	 # tmp145, R1
 # check_prime.c:56:         R2 = R1;
	movl	%eax, %edx	 # R1, R2
	.p2align 4,,10
	.p2align 3
.L13:
 # check_prime.c:59:                 R1 = R1 - D1;
	movl	%eax, %ecx	 # R1, tmp134
	subl	%r10d, %ecx	 # D1, tmp134
	cmpl	%eax, %r10d	 # R1, D1
	cmovbe	%ecx, %eax	 # tmp134,, R1
 # check_prime.c:62:                 R2 = R2 - D2;
	movl	%edx, %ecx	 # R2, tmp136
	subl	%r11d, %ecx	 # D2, tmp136
	cmpl	%edx, %r11d	 # R2, D2
	cmovbe	%ecx, %edx	 # tmp136,, R2
 # check_prime.c:64:             uint32_t temp = m & 1;
	movl	%r9d, %ecx	 # m, temp
 # check_prime.c:65:             R1 = temp | (R1 << 1);
	addl	%eax, %eax	 # _99
 # check_prime.c:64:             uint32_t temp = m & 1;
	andl	$1, %ecx	 #, temp
 # check_prime.c:66:             R2 = temp | (R2 << 1);
	addl	%edx, %edx	 # _96
 # check_prime.c:65:             R1 = temp | (R1 << 1);
	orl	%ecx, %eax	 # temp, R1
 # check_prime.c:66:             R2 = temp | (R2 << 1);
	orl	%ecx, %edx	 # temp, R2
 # check_prime.c:67:         } while ((m = m >> 1));
	shrl	%r9d	 # m
	jne	.L13	 #,
 # check_prime.c:68:         if (R1 == 0 || R1 == D1) {
	testl	%eax, %eax	 # R1
	je	.L20	 #,
	cmpl	%eax, %r10d	 # R1, D1
	je	.L20	 #,
 # check_prime.c:71:         if (R2 == 0 || R2 == D2) {
	testl	%edx, %edx	 # R2
	je	.L20	 #,
	cmpl	%edx, %r11d	 # R2, D2
	je	.L20	 #,
 # check_prime.c:74:         D1 = D1 + 6;
	addl	$6, %r10d	 #, D1
 # check_prime.c:75:         if (D1 > U) return 1;
	cmpl	%ebx, %r10d	 # n, D1
	ja	.L21	 #,
 # check_prime.c:77:         if (D1 >> J) {
	movl	%r10d, %eax	 # D1, tmp132
	movl	%edi, %ecx	 # J, tmp150
 # check_prime.c:76:         D2 = D2 + 6;
	addl	$6, %r11d	 #, D2
 # check_prime.c:77:         if (D1 >> J) {
	shrl	%cl, %eax	 # tmp150, tmp132
 # check_prime.c:77:         if (D1 >> J) {
	testl	%eax, %eax	 # tmp132
	je	.L10	 #,
 # check_prime.c:79:             L = G - J;
	movl	%ebp, %r12d	 # G, L
	subl	%edi, %r12d	 # J, L
 # check_prime.c:78:             J = J + 1;
	addl	$1, %edi	 #, J
	jmp	.L10	 #
.L20:
 # check_prime.c:6:     if (N < 2) return 0;
	xorl	%eax, %eax	 # <retval>
.L1:
 # check_prime.c:84: }
	popq	%rbx	 #
	popq	%rsi	 #
	popq	%rdi	 #
	popq	%rbp	 #
	popq	%r12	 #
	ret	
	.p2align 4,,10
	.p2align 3
.L6:
 # check_prime.c:41:         Q = Q >> 1;
	shrl	%ebx	 # n
 # check_prime.c:42:     } while((E = E >> 2));
	shrl	$2, %eax	 #, E
	jne	.L9	 #,
	jmp	.L8	 #
.L21:
 # check_prime.c:7:     if (N == 2) return 1;
	movl	$1, %eax	 #, <retval>
	jmp	.L1	 #
	.seh_endproc
	.ident	"GCC: (Rev5, Built by MSYS2 project) 10.3.0"
