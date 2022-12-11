org 100h

start:
	;pobieranie zmiennych
	call ent
	call wczytaj	
	;dodawanie
	call ent
	call dod
	;odejmowanie
	call spacja
	call odj
	;mnozenie
	call spacja
	call mnoz
	;dzielenie
	call spacja
	call dziel
	call ent
koniec:
	mov	ax,4C00h
	int	21h
	
a	db	0
b	db	0

dod:
	pusha
	pushf
		mov ax,[a]
		mov bx,[b]
		push bx
		push ax
		mov bp,sp
		mov al,[bp]
		add bp,2
			add al,48
			add al,[bp]
			mov ah,2
			mov dl,al
			int 21h
		pop ax
		pop ax
	popf
	popa
ret


dziel:
	pusha
	pushf
		mov ax,[a]
		mov bx,[b]
		push bx
		push ax
			xor ax,ax
			xor bx,bx
			mov bp,sp
			mov al,[bp]
			add bp,2
			mov bl,[bp]
				cmp bl,0
				je zero
			notzero:
				div bl
				mov dl,al
				mov ah,2
				add dl,48
				int 21h
				jmp kon
			zero:
				mov ah,2
				mov dl,33
				int 21h
			kon:
		pop ax
		pop ax
	popf
	popa
ret

mnoz:
	pusha
	pushf
		mov ax,[a]
		mov bx,[b]
		push bx
		push ax
		mov bp,sp
		mov al,[bp]
		add bp,2
		mov cl,[bp]
			mul cl
			add al,48
			mov ah,2
			mov dl,al
			int 21h
		pop ax
		pop ax
	popf
	popa
ret

wczytaj:
	pusha
	pushf
		mov ah,1
		int 21h
		sub al,48
		mov [a],al
		
		mov ah,1
		int 21h
		sub al,48
		mov [b],al
	popf
	popa
ret
	
odj:
	pusha
	pushf
		mov ax,[a]
		mov bx,[b]
		push bx
		push ax
		mov bp,sp
		mov al,[bp]
		add bp,2
			add al,48
			sub al,[bp]
			mov ah,2
			mov dl,al
			int 21h
		pop ax
		pop ax
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

spacja:
	mov ah,2
	mov dl,32
	int 21h
ret
