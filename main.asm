include utils.asm
.radix 16
.model small
.stack
.data
    ;mensajes -------------------------------------------------------------------------------------------------------
    mensajeBienvenida db "----------------------------------------------",0A,"Universidad de San Carlos de Guatemala" ,0A , "Facultad de ingenieria", 0A,"Escuela de Vacaciones",0A,"Arquitectura de Computadores y Ensambladores 1",0A,"Diego Andres Huite Alvarez",0A, "202003585",0A, "----------------------------------------------" ,"$"
    credentialFileConfirmation db "EXISTE EL ARCHIVO","$"
    credentialFileNotExistent  db "CREDENCIALES NO ENCONTRADAS","$"
    newLine db 0A, "$"
    quote db '"'
    ; variables para archivos

    handlecredentialFile dw 0000
    pathcredentialFile db "asm\pra\PRAII.CON",0 ; la ruta donde asm tiene que buscar


    ; buffers
    readBuffer db 256 dup(0), "$"

    ; ESTRUCTURAS
    codigoProducto db 04 dup(0)
    descProducto db 32 dup(0)
    productPrice db 02 dup(0)
    productUnits db 02 dup(0)
    
.code

    main PROC
    ;CARGANDO DE SEGMENTO DE DATOS A SEGMENTO DE CODIGO
    mov ax, @data
    mov ds, ax

    ; imprimir el encabezado
    printString mensajeBienvenida

    ; ABRE EL ARCHIVO PRAII.CON
    mov AL, 02
	mov AH, 3d
	mov DX, offset pathcredentialFile
	int 21
    ;--------------------------------
	; si no lo logra abrir, entonces imprimimos mensaje de fallo
	jc  credentialFileFailed ; jc - jump if condition met, es decir, salta si se abrio el archivo
	; si lo logra abrir mostramos menu inicial
    mov [handlecredentialFile] , AX
   
	jmp credentialFileSuccess
    
    credentialFileFailed:
        printString newLine
        printString credentialFileNotExistent
        jmp exit
    
    credentialFileSuccess:
        printString newLine
        printString credentialFileConfirmation
        ; guardamos el handle
        
    readCredentialFile:
        mov BX, [handlecredentialFile]
        mov CX, 254d
        mov DX, offset readBuffer 
        mov AH, 3F
        int 21
    closeCredentialFile:
        mov BX, [handlecredentialFile]
        mov AH, 3e
        int 21
        printString readBuffer
    

    
   exit:
    .exit

    main ENDP

end main
