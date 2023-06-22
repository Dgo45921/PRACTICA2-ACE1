printString macro cadena
    mov dx, offset cadena
    mov ah, 09h
    int 21h
endm


enterkeyHandler macro 
    mov ah, 08h
    int 21h
endm


searchFile macro path1
    mov AL, 02
	mov AH, 3Dh
	mov DX, offset path1
	int 21h
endm

fileCreator macro path2
    mov CX, 0000
	mov DX, offset path2
	mov AH, 3c
	int 21h
endm

saveBufferedInput macro buffer
    mov ah, 0Ah
    mov dx, offset buffer
    int 21h
endm