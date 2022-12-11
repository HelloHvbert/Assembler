org 100h

start:	
	mov ah,2 ;tryb wypisywania
	mov bx,imie ;adres zmiennej imie=>bx
	mov cx,0 ;licznik

petla:
	mov dl,[bx] ;przeniesienie zawartosci z adresu bx do dl
	int 21h
	
	inc bx	;przejscie do dalszego adresu
	inc cx	;licznik++

	cmp cx,16
	jle petla ;jesli <=16 przejdz na poczatek petli
	

koniec:
	mov	ax,4C00h ;zakoczenie programu
	int	21h
	
imie	dd 65627548h	;Hube
	dd 53207472h    ;rt S
	dd 7772617Ah    ;zarw
	dd 6B736E69h    ;insk
	db 69h    ;i