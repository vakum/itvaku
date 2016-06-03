.model small
.stack 64h
.data
table db 127,140,153,166,178,190,201,211,221,229,236,243,247,251,253,254,253,251,247,243,236,229,221,211,201,190,178,166,153,140,127
.code

mov ax,@data
mov ds,ax

mov al,80h
mov dx,0E803h
out dx,al

begin: mov dx,0E880h
       lea si,table
       mov cx,31

back: mov al,[si]
      out dx,al
      call delay
      inc si
      loop back

      mov ah,06h
      mov dl,0ffh
      int 21h
      jz begin

      mov ah,4ch
      int 21h

delay proc near
      push cx
      push bx
      mov cx,0ffh
loop2:mov bx,0ff5h
loop1:dec bx
      jnz loop1
      loop loop2
      pop bx
      pop cx
      ret
      delay endp
      end

