include utils.asm
.radix 16
.model small
.stack
.data
    ;mensajes -------------------------------------------------------------------------------------------------------
    mensajeBienvenida db "----------------------------------------------",0A,"Universidad de San Carlos de Guatemala" ,0A , "Facultad de ingenieria", 0A,"Escuela de Vacaciones",0A,"Arquitectura de Computadores y Ensambladores 1",0A,"Diego Andres Huite Alvarez",0A, "202003585",0A, "----------------------------------------------" ,"$"
    credentialFileConfirmation db "EXISTE EL ARCHIVO",0A,"$"
    credentialFileNotExistent  db "CREDENCIALES NO ENCONTRADAS","$"
    lexicalError  db "ERROR LEXICO EN ARCHIVO","$"
    exito  db "ya estoy en el igual","$"
    newLine db 0A, "$"
    quote db '"'
    ; variables para archivos
    auxCounter db 0000
    handlecredentialFile dw 0000
    pathcredentialFile db "asm\pra\PRAII.CON",0 ; la ruta donde asm tiene que buscar
    ; variables proposito general
    trueCond db 1


    ; buffers
    readBuffer db 50 dup(0), "$"

    ; Logged User
    fullName db 20 dup(0), "$"
    username db 10 dup(0), "$"


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

    ;MANEJO DE ARCHIVO CREDENCIALES--------------------------------------------------------------------------------------------

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
        mov CX, 200d
        mov DX, offset readBuffer 
        mov AH, 3F
        int 21
    closeCredentialFile:
        mov BX, [handlecredentialFile]
        mov AH, 3e
        int 21
        ;printString readBuffer  

        xor ah, ah
    ; FIN DE MANEJO DE ARCHIVO DE CREDENCIALES--------------------------------------------------------------------------------
    ; verificando si viene [credenciales]

    headerChecker:
        
        xor si, si
        mov al, readBuffer[si] 
        cmp al, '['            ;verificamos que venga el [     
        jne headerFail
        inc si
        mov al, readBuffer[si]
        cmp al, 'c'            ;verificamos que venga el c     
        jne headerFail
        inc si
        mov al, readBuffer[si]
        cmp al, 'r'            ;verificamos que venga el r     
        jne headerFail
        inc si
        mov al, readBuffer[si]
        cmp al, 'e'            ;verificamos que venga el e     
        jne headerFail
        inc si
        mov al, readBuffer[si]
        cmp al, 'd'            ;verificamos que venga el d     
        jne headerFail
        inc si
        mov al, readBuffer[si]
        cmp al, 'e'            ;verificamos que venga el e     
        jne headerFail
        inc si
        mov al, readBuffer[si]
        cmp al, 'n'            ;verificamos que venga el n     
        jne headerFail
        inc si
        mov al, readBuffer[si]
        cmp al, 'c'            ;verificamos que venga el c     
        jne headerFail
        inc si
        mov al, readBuffer[si]
        cmp al, 'i'            ;verificamos que venga el i     
        jne headerFail
        inc si
        mov al, readBuffer[si]
        cmp al, 'a'            ;verificamos que venga el a     
        jne headerFail
        inc si
        mov al, readBuffer[si]
        cmp al, 'l'            ;verificamos que venga el l     
        jne headerFail
        inc si
        mov al, readBuffer[si]
        cmp al, 'e'            ;verificamos que venga el e     
        jne headerFail
        inc si
        mov al, readBuffer[si]
        cmp al, 's'            ;verificamos que venga el s     
        jne headerFail
        inc si
        mov al, readBuffer[si]
        cmp al, ']'            ;verificamos que venga el ]
        jne headerFail
        inc si
        mov al, readBuffer[si]
        cmp al, 0D            ;verificamos que venga el salto de linea     
        jne headerFail
        

    headerSuccess:
        ; printString readBuffer
        jmp userchecker

    headerFail:
        printString lexicalError
        jmp exit


    
    userchecker:
    inc si
    inc si

    mov al, readBuffer[si]
    cmp al, 'u'            ;verificamos que venga el salto de u     
    jne headerFail

    inc si
    mov al, readBuffer[si]
    cmp al, 's'            ;verificamos que venga el salto de s     
    jne headerFail

    inc si
    mov al, readBuffer[si]
    cmp al, 'u'            ;verificamos que venga el salto de u     
    jne headerFail

    inc si
    mov al, readBuffer[si]
    cmp al, 'a'            ;verificamos que venga el salto de a     
    jne headerFail

    inc si
    mov al, readBuffer[si]
    cmp al, 'r'            ;verificamos que venga el salto de r     
    jne headerFail

    inc si
    mov al, readBuffer[si]
    cmp al, 'i'            ;verificamos que venga el salto de i     
    jne headerFail

    inc si
    mov al, readBuffer[si]
    cmp al, 'o'            ;verificamos que venga el salto de o     
    jne headerFail

    ;EMPEZANDO A CONTAR ESPACIOS EN BLANCO--------------------------------------------------------------------

    mov trueCond, 1b

    whileSpaces:
        cmp trueCond, 1b
        jne EXITWHILE
        
        cmp readBuffer[si], ' '
        jne UPDATECONDITION
        inc si
        jmp whileSpaces
        

        UPDATECONDITION:

        mov trueCond, 0b

    EXITWHILE:

    cmp readBuffer[si], '='
    je equalchecker


    ; aca ya conto espacios y deberia de estar en el =

    equalchecker:

    printString exito


    



    
   exit:
    .exit

    main ENDP

end main


