section .data
bmsg db 10,"HEX IS "
bmsg_len equ $-bmsg

section .bss
buf resb 5
char_ans resb 4
ans resb 4

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
read buf,5
mov rsi,buf
mov rax,0
mov rbp,4
mov rbx,10

next:
mul bx
mov cl,[rsi]
sub cl,30h
add ax,cx
inc rsi
dec rbp
jnz next


call display

exit
display:
mov rbx,16
mov rcx,2
mov rsi,char_ans+1

cnt:
mov rdx,0
div rbx
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