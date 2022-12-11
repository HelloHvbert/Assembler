org 100h

start:
	FINIT
	call ent
	call wczytaj
	call dodaj
	call odejmij
	call mnoz
	call dziel

koniec:
	mov ax,4C00h
	int 21h
ret

a dw 0
b dw 0
wynik dw 0
suma db "  Wynik dodawania: $"
roznica db "Wynik odejmowania: $"
iloczyn db "Wynik mnozenia: $"
iloraz db "Wynik dzielenia: $"
modulo db "Wynik reszty z dzielenia: $"

wczytaj:
	pusha
		mov ah,1
		int 21h
		mov dl,al
		sub dl,48
		mov [a],dl
		mov ah,1
		int 21h
		mov dl,al
		sub dl,48
		mov [b],dl
		
		call ent
	popa
ret

spacja:
	pusha
	pushf
		mov ah,2
		mov dl,32
		int 21h
	popf
	popa
ret

dodaj:
	pusha
	pushf
		FILD dword [a]
		FILD dword [b]
		FADDP
		FISTP dword [wynik]
		xor ax,ax
		xor dx,dx
		mov ah,9
		mov dx,suma+2
		int 21h
		call wysw
		call ent
	popf
	popa
ret

odejmij:
	pusha
	pushf
		FILD dword [a]
		FILD dword [b]
		FSUBP
		FISTP dword [wynik]
		mov ah,9
		mov dx,roznica
		int 21h
		call wysw
		call ent
	popf
	popa
ret

mnoz:
	pusha
	pushf
		FILD word [a]
		FIMUL word [b]
		FISTP dword [wynik]
		mov ah,9
		mov dx,iloczyn
		int 21h
		call wysw
		call ent
		FFREEP
	popf
	popa
ret

dziel:
	pusha
	pushf
		mov bx,[b]
		cmp bx, 0
		jne notzero
		mov ah,2
		mov dl,33
		int 21h
		jmp exit
		
		notzero:
		fild word [a]
		fild word [b]
		fdivp st1,st0
		fistp word [wynik]
		mov ah,9
		mov dx,iloraz
		int 21h
		call wysw
		call ent
		fild word [b]
		FILD word [a]
		FPREM
		FISTP word [wynik]
		mov ah,9
		mov dx,modulo
		int 21h
		call wysw
		call ent
	exit:
	popf
	popa
ret

ent:
	mov ah,2
	mov dl,10
	int 21h
	mov dl,13
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
		mov ax, [wynik] 
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







