org 100h

start:

	mov ah,2
	mov dl,10
	int 21h

	mov cx,0
	mov bx,varA
petla:
	mov ah,1
	int 21h
	mov [bx],al

	inc cx
	inc bx
	
	cmp cx,5
	jl petla

	mov cx,0
	mov bx,varA
	mov ah,2

	mov dl,10
	int 21h

	mov dl,13
	int 21h

petla1:
	cmp cx,5
	je wypisz

	mov dl,[bx]
	cmp dl,65
	jge wieksza1

	inc cx
	inc bx
	jmp petla1

wieksza1:
	cmp dl,90
	jle wieksza2
	inc cx
	inc bx
	jmp petla1
wieksza2:
	or dl,20h
	mov [bx],dl
	inc cx
	inc bx
	jmp petla1

wypisz:	
	mov cx,0
	mov bx,varA
	mov ah,2

wypisz1:
	mov dl,[bx]
	int 21h

	cmp cx,4
	je koniec

	inc bx
	inc cx
	jmp wypisz1

koniec:
	mov	ax,4C00h ;zakoczenie programu
	int	21h
	
varA	db 0h
	db 0h
	db 0h
	db 0h
	db 0h