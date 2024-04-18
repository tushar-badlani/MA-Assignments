section .data
pmsg db 10,"Number of positive numbers are: "
pmsg_len equ $-pmsg
nmsg db 10,"Number of negative numbers are: "
nmsg_len equ $-nmsg
arr64 db -5h,22h,40h,-20h,10h
n equ 5

section .bss
p_count resb 1
n_count resb 1
char_ans resb 2

%macro print 2
mov rax,1
mov rdi,1
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro read 2
mov rax,0
mov rdi,0
mov rsi,%1
mov rdx,%2
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


mov rsi,arr_64
mov rbx,0
mov rdx,0
mov rcx, n

next_num:
mov rax, [rsi]
rol rax,1
jc neg

pos:
inc rbx
jmp next 

neg:
inc rdx

next:
add rsi,1
dec rcx
jnz next_num


mov [p_count], rbx
mov [n_count], rdx

print pmsg, pmsg_len
mov rax, [p_count]
call disp

print nmsg, nmsg_len
mov rax, [n_count]
call disp

exit


disp:
mov rbx,10
mov rcx, 2
mov rsi, char_ans+1

cnt:
mov rdx,0
div rbx;
cmp dl,09h
jbe add30

add dl,07h

add30:
add dl,30h

mov [rsi],dl
dec rcx
dec rsi
jnz cnt 

ret