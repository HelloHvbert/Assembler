org 100h

	mov ah,9
	mov dx,reset
	int 21h
	call ent
	mov ah,9
	mov dx,kon
	int 21h
	call ent

start:
	
	mov ah,9
	mov dx,godz
	int 21h

	call hour
	call min
	call sec
	

	call ent

	readKey:
		mov ah, 0
		int 16h
		
		cmp ah,19
		je start
		cmp ah,28
		je start
		cmp ah,63
		je start

		cmp ah, 1
		je koniec
		cmp ah,16
		je koniec
		cmp ah,68
		je koniec
		

		zly:
		mov ah,9
		mov dx,zlykla
		int 21h
		xor ax,ax
		call ent
		jmp readKey





	
koniec:
	mov ax,4C00h
	int 21h
godz db "Jest godzina: $"

reset db "Wcisnij r/R/Enter/F5, aby odswiezyc.$"

kon db "Nacisnij esc/q/Q/F10, zeby wyjsc.$"

zlykla db "Wcisnieto zly klawisz.$"



hour:
	pusha
	pushf
	mov ah,2Ch
	int 21h

	xor ax,ax
	mov al,ch
	call wysw 

	call dwukro
	popf
	popa
ret

min:
	pusha	
	pushf
	mov ah,2Ch
	int 21h

	mov al,cl
	xor ah,ah
	call wysw

	call dwukro
	popf
	popa
ret

sec:
	pusha
	pushf
		mov ah,2Ch
		int 21h
		mov al,dh
		xor ah,ah
		call wysw
	popf
	popa

ent:
	pusha
	mov ah,2
	mov dl,10
	int 21h
	mov dl,13
	int 21h
	popa
ret

dwukro:
	pusha
	pushf
		mov ah,2
		mov dl,58
		int 21h
	popf
	popa
ret
wysw:
	pusha 
	pushf
		xor bx, bx
		xor cx, cx
		xor dx, dx
		
		mov cx, 10
			wysw2:
				div cx ; dziele przez 10 i biore reszte
				inc bx; licznik znakow wyniku
				push dx ; reszta na stos
				xor dx, dx 
				cmp ax, 0 				
				jne wysw2 
				mov cx, bx 				
				xor dx, dx 
			wysw3:
				mov ah, 2 
				pop dx 
				add dx, 48 ;dodaje przesuniecie
				int 21h
				xor dx, dx 
				dec cx
				cmp cx, 0
				jne wysw3 
	popf
	popa 
ret






