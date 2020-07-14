		.data
gogo:	.asciz	"** Please Enter Member %d ID:**\n"
mid:	.asciz	"*****Print Team Member ID and ID Summation*****\n"
input:	.asciz	"*****Input ID*****\n"
what:	.asciz	"** Please Enter Command **\n"
n:		.asciz	"%d"
output:	.asciz	"%d\n"
p:		.asciz	"p"
comp:	.asciz	"%s"
compp:	.asciz	" "
out:	.asciz	"ID Summation = %d\n"
num:	.word	0
num1:	.word	0
num2:	.word	0
num3:	.word	0
summ:	.word	0
		.text
		.globl	idfun
		.globl	num1
		.globl	num2
		.globl	num3
		.globl	summ

idfun:	stmfd	sp!,{lr}
		ldr		r0, =input
		bl		printf
		mov		r5, #0
		
loop:	cmp		r5, #3
		bge		done
		add		r5, r5, #1
		mov		r1, r5
		ldr		r0, =gogo
		bl		printf
		ldr		r0, =n
		ldr		r1, =num
		bl		scanf
		ldr		r1, =num
		ldr		r1, [r1]
		
		ldr		r0, =summ
		ldr		r0, [r0]
		add		r0, r0, r1
		ldr		r3, =summ
		str		r0, [r3]
		
		cmp		r5, #1
		ldrge	r2, =num1
		cmp		r5, #2
		ldrge	r2, =num2
		cmp		r5, #3
		ldrge	r2, =num3
		str		r1, [r2]
		b		loop
		
done:	ldr		r0, =what
		bl		printf
		ldr		r0, =comp
		ldr		r1, =compp
		bl		scanf
		ldr		r0, =compp
		ldrb	r0, [r0]
		ldr		r1, =p
		ldrb	r1, [r1]
		cmp		r0, r1
		ldr		r0, =compp
		ldr		r1, =p
		ldreqb	r0, [r0,#1]
		ldreqb	r1, [r1,#1]
		cmp		r0,	r1
		ldreq	r0, =mid
		bleq	printf
		ldreq	r0, =output
		ldreq	r1, =num1
		ldreq	r1, [r1]
		bleq	printf
		ldreq	r0, =output
		ldreq	r1, =num2
		ldreq	r1, [r1]
		bleq	printf
		ldreq	r0, =output
		ldreq	r1, =num3
		ldreq	r1, [r1]
		bleq	printf
		
		ldreq	r1, =summ
		ldreq	r1, [r1]
		ldreq	r0, =out
		bleq	printf
		
		ldmfd 	sp!,{lr}
		mov		pc, lr
		