org 100h

start:
	FINIT
	call ent
	call wczytaj1
	call wczytaj2
	call ent
	call dodaj
	call odejmij
	call mnoz
	call dziel
	
	call koniec

koniec:
	mov ax,4C00h
	int 21h
ret

a dw 0
b dw 0
suma db "  Wynik dodawania: $"
roznica db "Wynik odejmowania: $"
iloczyn db "Wynik mnozenia: $"
iloraz db "Wynik dzielenia: $"
modulo db "Wynik reszty z dzielenia: $"

wczytaj1:
	pop cx
		mov ah,1
		int 21h
		mov dl,al
		sub dl,48
		xor dh,dh
		push dx
	push cx
ret

wczytaj2:
	pop cx
		mov ah,1
		int 21h
		mov dl,al
		sub dl,48
		xor dh,dh
		push dx
	push cx
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
		mov ah,9
		mov dx,suma+2
		int 21h
		xor ax,ax
		xor dx,dx

		mov bp,sp
		FILD word [bp+22]
		FILD word [bp+20]
		FADDP
		FISTP word [bx]
		mov ax, [bx]
		call wysw
		call ent
	popf
	popa
ret

odejmij:
	pusha
	pushf
		mov ah,9
		mov dx,roznica
		int 21h
		xor ax,ax
		xor dx,dx
		
		mov bp,sp
		FILD word [bp+22]
		FILD word [bp+20]
		FSUBP
		FISTP word [bx]
		mov ax, [bx]
		call wysw
		call ent
	popf
	popa
ret

mnoz:
	pusha
	pushf
		mov ah,9
		mov dx,iloczyn
		int 21h
		xor ax,ax
		xor dx,dx
		
		mov bp,sp
		FILD word [bp+22]
		FIMUL word [bp+20]
		FISTP word [bx]
		mov ax, [bx]
		call wysw
		call ent
		FFREEP
	popf
	popa
ret

dziel:
	pusha
	pushf

		mov ah,9
		mov dx,iloraz
		int 21h
		xor ax,ax
		xor dx,dx

		mov bp,sp
		mov bx,[bp+20]
		cmp bx, 0
		jne notzero
		mov ah,2
		mov dl,33
		int 21h
		jmp exit
		
		notzero:
		FILD word [bp+22]
		FILD word [bp+20]
		FDIVP st1,st0
		FISTP word [bx]
		mov ax, [bx]
		call wysw
		call ent

		;modulo
		mov ah,9
		mov dx,modulo
		int 21h
		FILD word [bp+20]
		FILD word [bp+22]
		FPREM
		FISTP word [bx]
		mov ax, [bx]	
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







