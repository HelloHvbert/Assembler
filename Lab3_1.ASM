org 100h

start:
	mov ah,2
	mov dl,10
	int 21h	
	
	mov ah,1
	int 21h
	sub al,48
	mov [a],al

	mov ah,1
	int 21h
	sub al,48
	mov [b],al	

	mov ah,2
	mov dl,10
	int 21h

	mov ah,2
	mov dl,13
	int 21h	

;dodawanie
	mov ax,0
	mov dl,[a]
	add dl,[b]
	
	mov ah,2 ;suma a+b
	int 21h

	mov ah,2
	mov dl,32
	int 21h

;odejmowanie
	mov ah,0h
	mov dl,[a]
	sub dl,[b]

	mov ah,2 ;roznica a-b
	int 21h

	mov ah,2
	mov dl,32
	int 21h

;mnozenie
	mov bl,[a]
	mov al,[b]
	mul bl
	mov dl, al
	mov ah,2
	int 21h
	
	mov ah,2
	mov dl,32
	int 21h

;dzielenie
	mov dx,0h
	mov ax,[a]
	mov bx,[b]

	cmp bl,0
	je zero

	div bx
	mov dl,al
	mov dh,ah
	mov ah,2
	int 21h

	mov dl,32
	int 21h

	mov ah,2
	mov dl,dh
	int 21h
	
	jmp koniec 

zero:
	mov ah,2
	mov dl,33
	int 21h
koniec:
	mov ax,4C00h
	int 21h

;zmienne			
	a db 0h
	b db 0h
	wynik db 0h

