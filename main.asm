.model small
.stack
.data
    mensaje db "Hola mundo, estoy aprendiendo assembler$"
.code

    main PROC
    ;CARGANDO DE SEGMENTO DE DATOS A SEGMENTO DE CODIGO
    mov ax, @data
    mov ds, ax

    ; imprimir en consola
    mov dx, offset mensaje
    mov ah, 9
    int 21h
    .exit

    main ENDP

end main
