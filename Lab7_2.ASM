org 100h

start:	
	call ent 
	call pobierz 
	call ent
	call silnia 
	call wysw 
koniec:
	mov ax, 4C00h
	int 21h
	
x db 0 ;liczba
y dd 0 ;wynik silni
temp db 0
mess db "Podana wartosc bledna$"


return:
	mov ax, 4C00h
	int 21h
ret

wysw:
	pusha 
	pushf
		xor ax, ax
		xor bx, bx
		xor cx, cx
		xor dx, dx
		
		mov cx, 10
		mov ax, [y] 
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

silnia:
	pusha 
	pushf 
		FINIT
		mov cx,[x]
		cmp cx,0
		jne notzero
		mov bx,1
		mov [y],bx
		jmp exit

		notzero: 
		mov bx,1
		mov [y],bx
		petla:
			mov [temp],cx
			FILD word [y]		;st1
			FIMUL word [temp]	;st0
			FISTP dword [y]     ;wynik do zmiennej y
			loop petla
	exit:
	popf
	popa
ret


ent:
	pusha
	pushf
	mov ah,2
	mov dl,10
	int 21h
	mov dl,13
	int 21h
	popf
	popa
ret

pobierz:
	pusha
	pushf
		xor dx,dx
		mov ah,2
		mov si, 82h
		mov dl,[si]
		cmp dl,48
		jge przed9
		jmp blad

		przed9:
		cmp dl,57
		jg blad

		sub dl,48
		mov [x],dl
		jmp kon
	
		cmp dl,9
		jle kon
		
		blad:
		mov ah,9
		mov dx,mess
		int 21h
		call ent
		call return
		
		
	kon:
	popf
	popa
ret
	