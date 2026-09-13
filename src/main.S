.global _start

.section .text.boot, "ax"
_start:
  ldr x0, =stack_top
  mov sp, x0
  bl kmain

.section .bss.stack, "aw", @nobits
.align 12
stack_bottom:
  .skip 16384
stack_top:
