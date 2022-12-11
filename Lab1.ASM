org 100h

start:				

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

	mov ah,2
	mov dl,32
	int 21h

	mov ah,2
	mov dl,115
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

	mov	ah,1
	int	21h


	mov	ax,4C00h
	int	21h