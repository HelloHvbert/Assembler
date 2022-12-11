org 100h

start:
	;komunikat
	mov ah,9
	mov dx,podaj
	int 21h

	call ent

	;wpisywanie znakow
	mov ah,10
	mov dx,znaki
	int 21h

	;kopiowanie
	call kopiuj

	call ent
	;podanie klucza
	call key
	;szyfrowanie
	call ent
	call cezar
	
	;komunikat2
	mov ah,9
	mov dx,podsum
	int 21h
	call ent

	;wypisz zasztfrowany tekst
	call wynik
	
koniec:
	mov ax,4C00h
	int 21h
	
podaj db "Witaj! Podaj 25 znakow: $"
podklu db "Podaj klucz: $"
podsum db "Oto zaszyfrowany tekst: $"
klucz db 0
znaki 	db 26
		db 0
		times 27 db 36
	  
kopia 	db 26
		db 0
		times 27 db 36

ent:
	pusha
	mov ah,2
	mov dl,10
	int 21h
	mov dl,13
	int 21h
	popa
ret

wynik:
	pusha
	pushf
		mov ah,9
		mov dx,kopia
		int 21h
	popf
	popa
ret

cezar:
	pusha
	pushf
		mov bx,kopia
		mov cx,25
		
		petla:
			xor ax,ax
			mov al,[bx]


			cmp al,65 ; czy wieksza rowna od A
			jge wiekA
			jmp spacja

			wiekA: ;wieksza,rowna od A
			cmp al,90
			jle namala ; czyli al<=Z
			
			cmp al,97 ; czy <a
			jl spacja

			cmp al,123 ; czy >z
			jge spacja

			mala:
			add al,[klucz]
			jmp wypisz

			namala:
			add al,32 ;+32
			add al,[klucz]
			cmp al,122
			jg bigger
			jmp wypisz
			bigger:
			sub al,26
		
			wypisz:
				cmp ax,123
				jge wieksza
				jmp przed
				wieksza:
					sub ax,26
					mov [bx],al
					jmp ink
				przed:
					mov [bx],al
					jmp ink
				
				spacja:
					mov al,32
					mov [bx],al
			ink:
			inc bx
			dec cx
			cmp cx,0
			jne petla
			
	popf
	popa
ret

kopiuj:
	pusha
	pushf
		mov cx,29
		mov si,znaki+2
		mov di,kopia
		cld
		rep movsb
	popf
	popa
ret

key:
	pusha
	pushf
		mov ah,9
		mov dx,podklu
		int 21h
		
		call ent
		
		mov ah,1
		int 21h
		mov dl,al
		sub dl,48
		mov [klucz],dl
	popf
	popa
ret




