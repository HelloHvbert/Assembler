org 100h

start:
	
	mov ah,2 ;spacja
	mov dl,10
	int 21h

	mov ah,2
	mov dl,13
	int 21h

	mov ah,1 ;czeka na znak
	int 21h
	
	cmp al,97 ;a<=
	jge mniejsza
	
	cmp al,65 ;A<=
	jge wieksza

	jmp koniec

mniejsza:
	cmp al,122 ;z>=
	jle mniejsza2

	jmp koniec
mniejsza2:

	mov ah,2 ;spacja
	mov dl,10
	int 21h

	mov ah,2
	mov dl,13
	int 21h
	
	jmp imie

wieksza:
	cmp al,90 ;Z>=
	jle wieksza2
	
	jmp koniec

wieksza2:

	mov ah,2 ;spacja
	mov dl,10
	int 21h

	mov ah,2
	mov dl,13
	int 21h
	
	jmp nazwisko				
	
imie:
	mov	ah,2
	mov     dl,72
	int	21h
	
	mov     ah,2
	mov	dl,117
	int	21h
	
	mov	ah,2
	mov	dl,98
	int	21h
	
	mov	ah,2
	mov	dl,101
	int	21h

	mov 	ah,2
	mov 	dl,114
	int 	21h

	mov	ah,2
	mov	dl,116
	int	21h
	
	jmp koniec

	mov ah,2
	mov dl,32
	int 21h

nazwisko:
	mov ah,2
	mov dl,83
	int 21h

	mov ah,2
	mov dl,122
	int 21h

	mov ah,2
	mov dl,97
	int 21h

	mov ah,2
	mov dl,114
	int 21h
	
	mov ah,2
	mov dl,119
	int 21h	

	mov ah,2
	mov dl,105
	int 21h
	
	mov ah,2
	mov dl,110
	int 21h

	mov ah,2
	mov dl,115
	int 21h

	mov ah,2
	mov dl,107
	int 21h


	mov ah,2
	mov dl,105
	int 21h

	jmp koniec

koniec:
	mov	ax,4C00h
	int	21h