.model small
.data
  b_a equ 0e880h
  p_a equ b_a+00h
  p_b equ b_a+01h
  p_c equ b_a+02h
  cwr equ b_a+03h
  x db ?
  y db ?
  m1 db "Enter the value of x$"
  m2 db 10,13,"enter value of y$"
.code
  mov ax,@data
  mov ds,ax
  mov al,82h
  mov dx,cwr
  out dx,al
  lea dx,m1
   call prints
  mov ah,08h
  int 21h
  mov dx,p_b
  in al,dx
  mov x,al
  lea dx,m2
  call prints
  mov ah,08h
  int 21h
  mov dx,p_b
  in al,dx
  mov y,al
  xor ah,ah
  mul byte ptr x
  mov cx,ax
  call delay
  mov al,ch
  mov dx,p_a
  out dx,al
  mov al,cl
  mov dx,p_a
  out dx,al
  mov ah,4ch
  int 21h
  prints proc near
     mov ah,09h
     int 21h
     ret
    prints endp
    delay proc near
        push cx
        push bx
        mov cx,0ffffh
   loop1:     mov bx,0ffffh
               in1: dec bx
                     jnz in1
                     loop loop1
                     pop bx
                     pop cx
                     ret
                     delay  endp
                     end



