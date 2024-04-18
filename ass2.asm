section .data

amsg db 10,"Enter String: "
amsg_len equ $-amsg

smsg db 10,10,"Lenght is "
smsg_len equ $-smsg

section .bss

string resb 50
stringl equ $-string
count resb 1
char_ans resb 1


%macro print 2
mov rax,1
mov rdi,1
mov rsi, %1
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

print amsg,amsg_len
read string, stringl

mov [count],rax
print smsg, smsg_len
mov rax, [count]
dec rax
call display

exit


display:
mov rbx,10
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

print char_ans,2
ret