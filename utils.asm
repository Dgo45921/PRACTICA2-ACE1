printString macro cadena
    mov dx, offset cadena
    mov ah, 09h
    int 21h
endm


searchFile macro path
    mov al, 01h
    mov dx, offset path
    mov ah, 23h
    int 21h

endm