.section ".text.startup"

.global _start
.global _get_stack_pointer

_start:
	ldr sp, =0x8000
	
	ldr r0, =__bss_start__
	ldr r1, =__bss_end__
	mov r2, #0
bss_wipe:
	strb r2, [r0], #1
	cmp r0, r1
	blt bss_wipe
	
	b kmain

_inf_loop:
	b _inf_loop

_get_stack_pointer:
	str sp, [sp]
	ldr r0, [sp]

	mov pc, lr
