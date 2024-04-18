section .data
bmsg db 10,"BCD IS "
bmsg_len equ $-bmsg
errmsg db 10, "Error is "
errmsg_len equ $-errmsg

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
call accept
mov [ans],rbx
print bmsg,bmsg_len
mov rax,[ans]
call display
exit

accept:
read buf,5
mov rsi,buf
mov rcx,4
mov rbx,0

next:
shl bx,4
mov al,[rsi]
cmp al,'0'
jb error
cmp al,'9'
jbe sub30

cmp al,'A'
jb error
cmp al,'F'
jbe sub37

cmp al,'a'
jb error
cmp al,'f'
jbe sub57

error:
print errmsg,errmsg_len
exit

sub57:
sub al,20h

sub37:
sub al,7h

sub30:
sub al,30h

add bx,ax
inc rsi
dec rcx
jnz next

ret

display:
mov rbx,10
mov rcx,4
mov rsi,char_ans+3

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

print char_ans,4
ret