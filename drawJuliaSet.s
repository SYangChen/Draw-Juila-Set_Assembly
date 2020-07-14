		.global	__aeabi_idiv
		.data
n1500:	.word	1500
n40x6:	.word	4000000
n0x4f:	.word	0xffff
		
		.text
		.globl	drawJS
		
drawJS:	stmfd	sp!, {r4-r10,lr}		@ 8*4=32
		str		r0, [sp, #-4]		@ cX
		str		r1, [sp, #-8]		@ cY
		str		r2, [sp, #-12]		@ width
		str		r3, [sp, #-16]		@ height
		mov		r9, #0				@ x
loopf1:	ldr		r4, [sp, #-12]		@ temp width
		cmp		r9, r4
		bge		donef1
		mov		r10, #0				@ y
loopf2:	ldr		r5, [sp, #-16]		@ temp height
		cmp		r10, r5
		bge		donef2
		
		sub		r0, r9, r4, lsr	#1	@x-(width>>1)
		ldr		r1, =n1500			@ mov		r1, #1500
		ldr		r1, [r1]
		mul		r0, r0, r1			@*1500
		mov		r1, r4, lsr #1		@width>>1
		sub		sp, sp, #20			@----------------------------
		bl		__aeabi_idiv
		add		sp, sp, #20			@++++++++++++++++++++++++++++
		mov		r6, r0				@ zx
		
		sub		r0, r10, r5, lsr #1	@y-(height>>1)
		mov		r1, #1000
		mul		r0, r0, r1			@*1000
		mov		r1, r5, lsr #1		@width>>1
		sub		sp, sp, #20			@----------------------------
		bl		__aeabi_idiv
		add		sp, sp, #20			@++++++++++++++++++++++++++++
		mov		r7, r0				@ zy
		
		mov		r8, #255			@ i in while loop
loopw:	mul		r1, r7, r7			@ zy*zy
		mla		r0, r6, r6, r1
		ldr		r5, =n40x6			@ cmp		r0, #4000000
		ldr		r5, [r5]
		cmpal	r0, r5
		bge		donew
		cmplt	r8, #0
		ble		donew
		subgt	r0, r0, r1, lsl #1	@ zx*zx+zy*zy-2(zy*zy)
		mov		r1, #1000
		sub		sp, sp, #20			@----------------------------
		bl		__aeabi_idiv
		add		sp, sp, #20			@++++++++++++++++++++++++++++
		ldr		r1, [sp, #-4]		@ cX
		add		r5, r0, r1
		mul		r0, r6, r7
		add		r0, r0, r0			@*2
		mov		r1, #1000
		sub		sp, sp, #20			@----------------------------
		bl		__aeabi_idiv
		add		sp, sp, #20			@++++++++++++++++++++++++++++
		ldr		r1, [sp, #-8]
		add		r7, r0, r1
		mov		r6, r5
		sub		r8, r8, #1
		b		loopw
donew:	and		r6, r8, #0xFF
		mov		r7, r6, lsl #8
		orr		r6, r6, r7
		mvn		r6, r6
		ldr		r7, =n0x4f
		ldr		r7, [r7]
		and		r6, r6, r7		@ color
		
		add		r7, r10, r10, lsl #2	@ y*5
		mov		r7, r7, lsl #8		@ y*5*256
		add		r7, r7, r9, lsl #1	@ +x*2
		ldr		r8, [sp, #32]
		strh	r6, [r8, r7]	@add		r8, r8, r7
		
		add		r10, r10, #1
		b		loopf2
donef2:	add		r9, r9, #1
		b		loopf1
donef1:	ldmfd	sp!, {r4-r10,lr}		@ 6*4=24
		mov		pc, lr
		