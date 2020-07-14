		.data
team:	.asciz	"Team 10\n"
name1:	.asciz	"Tim Chen\n"
name2:	.asciz	"Uchiha Yuan\n"
name3:	.asciz	"Justin Chang\n"
start:	.asciz	"*****Print Name*****\n"
enddd:	.asciz	"*****End Print*****\n"
		.text
		.globl	namefun
		.globl	team
		.globl	name1
		.globl	name2
		.globl	name3
		

namefun:stmfd	sp!,{lr}
		ldr		r0, =start
		bl		printf
		ldr		r0, =team
		bl		printf
		ldr		r0, =name1
		bl		printf
		ldr		r0, =name2
		bl		printf
		ldr		r0, =name3
		bl		printf
		ldr		r0, =enddd
		bl		printf
		ldmfd 	sp!,{lr}
		mov		pc, lr
		
