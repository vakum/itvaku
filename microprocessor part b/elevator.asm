.model small
.data
b_a equ 0e880h
pa equ b_a+00h
pb equ b_a+01h
pc equ b_a+02h
cwr equ b_a+03h
.code
mov ax,@data
mov ds,ax
mov al,82h
mov dx,cwr
out dx,al
mov dx,pa
mov al,0f0h
out dx,al
out dx,al
loop1:
mov dx,pb
in al,dx
and al,0fh
jz loop1
next:
shr al,01
jnc fflr
shr al,01
jnc sflr
shr al,01
jnc tflr
gflr: mov cl,01h
jmp move
fflr:mov cl,03h
jmp move
sflr :mov cl,06h
jmp move
tflr :mov cl,09h
move:mov al,00
mov bl,cl
lp1:
mov dx,pa
out dx,al
call delay
inc al
dec cl
jnz lp1
mov cl,bl
inc cl
lp2:mov dx,pa
out dx,al
call delay
dec al
dec cl
jnz lp2
mov ah,4ch
int 21h
delay proc
push bx
push cx
mov bx,5fffh
up1:
mov cx,0fffh
here:
loop here
dec bx
jnz up1
pop cx
pop bx
ret
delay endp
end



