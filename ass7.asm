section .data
bmsg db 10,"Before Transfer "
bmsg_len equ $-bmsg
amsg db 10,"After Transfer "
amsg_len equ $-amsg
smsg db 10,"Source block "
smsg_len equ $-smsg
dmsg db 10,"Destination block "
dmsg_len equ $-dmsg
space db " "
sblock db 11h,22h,33h,44h,55h
dblock times 5 db 0

section .bss
char_ans db 2

%macro print 2
mov rax,1
mov rdi,1
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
print bmsg,bmsg_len

print smsg,smsg_len
mov rsi,sblock
call display_block


print dmsg,dmsg_len
mov rsi,dblock-2
call display_block

call transfer

print amsg,amsg_len

print smsg,smsg_len
mov rsi,sblock
call display_block


print dmsg,dmsg_len
mov rsi,dblock-2
call display_block

exit


transfer:
mov rsi,sblock+4
mov rdi,dblock+2
mov rcx,5

std
rep movsb

ret


display_block:
mov rbp,5

next_val:
mov ax, [rsi]
push rsi
call disp
print space,1
pop rsi
inc rsi
dec rbp
jnz next_val

ret

disp:
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

