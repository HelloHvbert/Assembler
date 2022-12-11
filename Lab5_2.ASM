org 100h

start:	
	call ent
	call pobierz
	call ent
	call silnia
	mov ah,2
	mov dl,[wynik]
	int 21h
	call ent
	call print
	
koniec:
	mov	ax,4C00h ;zakoczenie programu
	int	21h

	
n		db	0
wynik	db 	1



print:
	pusha
	pushf
		xor ax,ax
		xor bx,bx
		xor cx,cx
		xor dx,dx
		
		mov cx,10	;dzielelenie przez 10, aby uzyskac reszte z dzielenie
		mov ax,[wynik]

		cmp ax,2
		jle mniej
		
		jmp nastos

		zerop:

		mniej:
			mov ah,2
			add dl,[wynik]
			int 21h
			jmp exit
		nastos:
			cmp ax,0	;sprawdza czy liczba jest juz podzielona
			je zeruj
			div cx		;ax/cx
			push dx		;wstawia na stos reszte z dzielenia
			xor dx,dx
			inc bx		;licznik ile znaków
			jmp nastos
		zeruj:
			xor dx,dx
		echo:
			cmp bx,0
			je exit
			mov ah,2
			pop dx
			add dx,48
			int 21h
			xor dx,dx
			dec bx
			jmp echo
		
	exit:
	popf
	popa
ret

silnia:
	pusha
	pushf
		mov cx,[n]
		cmp cl,0
		je zero
		
		cmp cl,2
		jle wyp0
	
		cmp cl,8
		je osiem

		xor ax,ax
		mov ax,1

		petla:
			mul cl ; cl*al
			mov [wynik],al	;al do wyniku
			dec cx			;cl--
			cmp cl,0
			je kon
			jmp petla
		osiem:
			mul cx ; cx*ax
			mov [wynik],ax	;al do wyniku
			dec cx			;cl--
			cmp cl,0
			je kon
			jmp petla

		zero:
			mov ax,49
			mov [wynik],ax
			jmp kon 

		wyp0:
			add cx,48
			mov [wynik],cx
			jmp kon
	kon:
	popf
	popa
ret

pobierz:
	pusha
	pushf
		mov ah,1
		int 21h
		sub al,48
		mov [n],al
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

spacja:
	pusha
	pushf
		mov ah,2
		mov dl,32
		int 21h
	popf
	popa
ret