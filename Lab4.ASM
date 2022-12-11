org 100h

start:
	;pobieranie zmiennych
	call ent
	call wczytaj
	
	;dodawanie
	call ent
	call pushab
	call dod
	call wysw
	call spacja
	;odejmowanie
	call pushab
	call odj
	call wysw
	call spacja
	;mnozenie
	call pushab
	call mnoz
	call wysw
	call spacja
	;dziel
	call pushab
	call dziel
	call wysw
	
	call ent
koniec:
	mov	ax,4C00h
	int	21h
	
a	db	0
b	db	0

dziel:
	pop cx
		pop bx
		pop ax
			cmp bx,0
			je zero
			
			jmp notzero
			zero:
				mov ax,33
				jmp pu
			notzero:
				xor dx,dx
				div bx
				add ax,48
			
		pu:
		push ax
	push cx
ret

mnoz:
	pop cx
		pop bx
		pop ax
			mul bx
			add ax,48
		push ax
	push cx
ret

wczytaj:
	pop cx
		mov ah,1
		int 21h
		sub al,48
		mov [a],al
		
		mov ah,1
		int 21h
		sub al,48
		mov [b],al
	push cx
ret
	
odj:
	pop cx
		pop bx
		pop ax
			add ax,48
			sub ax,bx
		push ax
	push cx
ret


dod:
	pop cx
		pop bx
		pop ax
			add ax,48
			add ax,bx
		push ax
	push cx
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

wysw:
	pop cx
		pop dx
		mov ah,2
		int 21h
	push cx
ret

pushab:
	pop cx
		xor ah,ah
		mov al,[a]
		push ax
		mov al,[b]
		push ax
	push cx
ret