section .data
msg db 10,"hello",10
msg_len equ $-msg

%macro print 2
mov rax,1
mov rdi,1
mov rsi, %1
mov rdx, %2
syscall
%endmacro

%macro exit 0
mov rax,60
mov rdi,0
syscall
%endmacro

section .text
global _start
_start:
print msg, msg_len
exit