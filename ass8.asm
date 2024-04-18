section .data
nline db 10,10 ; Newline characters
nline_len equ $-nline ; Length of newline characters
colon db ":" ; Colon character
rmsg db 10, 'Processor is in Real Mode...'
rmsg_len equ $-rmsg ; Message for real mode
pmsg db 10, 'Processor is in Protected Mode...'
pmsg_len equ $-pmsg ; Message for protected mode
gmsg db 10, "GDTR (Global Descriptor Table Register) : "
gmsg_len equ $-gmsg ; Message for GDTR
imsg db 10, "IDTR (Interrupt Descriptor Table Register) : "
imsg_len equ $-imsg ; Message for IDTR
lmsg db 10, "LDTR (Local Descriptor Table Register) : "
lmsg_len equ $-lmsg ; Message for LDTR
tmsg db 10, "TR (Task Register) : "
tmsg_len equ $-tmsg ; Message for TR
mmsg db 10, "MSW (Machine Status Word) : "
mmsg_len equ $-mmsg ; Message for MSW


section .bss
GDTR resb 6
IDTR resb 6
LDTR resb 2
TR resb 2
MSW resb 2

char_ans resb 4

%macro print 2
mov rax, 1
mov rdi, 1
mov rsi, %1
mov rdx, %2
syscall
%endmacro

%macro Read 2
mov rax, 0
mov rdi, 0
mov rsi, %1
mov rdx, %2
syscall
%endmacro

%macro exit 0
mov rax, 60
mov rdi, 0
syscall
%endmacro

section .text
global _start
_start:

SMSW [MSW]
mov rax, [MSW]
ror rax,1
jc protected

print rmsg,rmsg_len
jmp next

protected:
print pmsg,pmsg_len

next:
print nline,2
SGDT [GDTR]
SIDT [IDTR]
STR [TR]
SLDT [LDTR]
SMSW [MSW]

mov rax,[GDTR+4]
call disp
mov rax,[GDTR+2]
call disp
mov rax,[GDTR+0]
call disp
print nline,2

mov rax,[IDTR+4]
call disp
mov rax,[IDTR+2]
call disp
mov rax,[IDTR+0]
call disp
print nline,2

mov rax,[LDTR]
call disp
print nline,2

mov rax,[TR]
call disp
print nline,2

mov rax,[MSW]
call disp
print nline,2


exit

disp:
mov rbx,16
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


