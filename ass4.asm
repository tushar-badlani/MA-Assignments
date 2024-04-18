section .data
msg db 10, "Hex is "
msg_len equ $-msg

section .bss
buf resb 6
char_ans resb 5
ans resb 5

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

read buf,6
mov rsi,buf
mov rbp,5
mov rbx,10
mov rax,0

next:
mul bx
mov cl,[rsi]
sub cl,30h
add ax,cx
inc rsi
dec rbp
jnz next

mov [ans],rax
print msg,msg_len
mov rax,[ans]

call disp
exit

disp:
mov rbx,16
mov rcx,2
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

dec rsi
dec rcx
jnz cnt


print char_ans,4
ret
