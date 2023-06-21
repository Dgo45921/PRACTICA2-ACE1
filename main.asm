include utils.asm
.radix 16
.model small
.stack
.data
    ;mensajes -------------------------------------------------------------------------------------------------------
    mensajeBienvenida db "----------------------------------------------",0A,"Universidad de San Carlos de Guatemala" ,0A , "Facultad de ingenieria", 0A,"Escuela de Vacaciones",0A,"Arquitectura de Computadores y Ensambladores 1",0A,"Diego Andres Huite Alvarez",0A, "202003585",0A, "----------------------------------------------" ,"$"
    bienvenido db "BIENVENIDO: ","$"
    credentialFileConfirmation db "EXISTE EL ARCHIVO",0A,"$"
    credentialFileNotExistent  db "CREDENCIALES NO ENCONTRADAS","$"
    lexicalError  db "ERROR LEXICO EN ARCHIVO","$"
    exito  db "ya estoy en la comilla","$"
    newLine db 0A, "$"
    quote db '"'
    ; variables para archivos
    auxCounter db 0000
    handlecredentialFile dw 0000
    pathcredentialFile db "asm\pra\PRAII.CON",0 ; la ruta donde asm tiene que buscar
    ; variables proposito general
    trueCond db 1
    firstquoteIndex dw 0
    secondquoteIndex dw 0


    ; buffers
    readBuffer db 50 dup(0), "$"

    ; Logged User


    realUsername db "dalvarez", "$"
    realPassword db "202003585", "$"
    username db 8 dup('x'), "$"
    password db 9 dup('a'), "$"


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
    inc si
    mov trueCond, 1b

    whileSpaces:
        cmp trueCond, 1b
        jne EXITWHILE
        
        mov al, readBuffer[si]
        cmp al, ' '
        jne UPDATECONDITION
        inc si
        jmp whileSpaces
        

        UPDATECONDITION:

        mov trueCond, 0b

    EXITWHILE:

    mov al, readBuffer[si]
    cmp al , '='
    jne headerFail


    ; aca ya conto espacios y deberia de estar en el =

    equalchecker:
        inc si
        mov trueCond, 1b
    
    whileSpaces2:
        cmp trueCond, 1b
        jne EXITWHILE2
        
        mov al, readBuffer[si]
        cmp al, ' '
        jne UPDATECONDITION2
        inc si
        jmp whileSpaces2
        

        UPDATECONDITION2:

        mov trueCond, 0b

    EXITWHILE2:

    cmp readBuffer[si], '"'
    jne headerFail
    usernameChecker:
        mov firstquoteIndex, si
        inc si
    ; ACA YA ENCONTRE UNA COMILLA Y DEBO DE SEGUIR RECORRIENDO HASTA ENCONTRAR OTRA
     mov trueCond, 1b
     loopToSecondQuote:
        cmp trueCond, 1b
        jne EXITWHILE3
        
        mov al, readBuffer[si]
        cmp readBuffer[si], 0D
        je headerFail
        cmp readBuffer[si], '"'
        je UPDATECONDITION3
        inc si
        jmp loopToSecondQuote
        

        UPDATECONDITION3:

        mov trueCond, 0b

    EXITWHILE3:
    ; verificamos si viene salto de linea
        mov secondquoteIndex, si
       

     
    ; ya guardando el username   
    xor si, si
    xor di, di
    mov si, firstquoteIndex
    inc si ; moviendome al primer caracter luego de la primera comilla
    mov trueCond, 1b

    loopSaveusername:
        cmp trueCond, 1b
        jne exitLoopUsername
  
        cmp readBuffer[si], '"'
        je exitLoopUsername
        mov bh, readBuffer[si]
        mov username[di], bh 

        inc si
        inc di
        jmp loopSaveusername
    exitLoopUsername:
        ;printString username
    
    xor di, di
    mov si, secondquoteIndex
    inc si
    mov al, readBuffer[si]
    cmp al, 0D
    jne headerFail

;manejo clave------------------------------------------------------------------------------------------------------------
    inc si
    inc si

    mov al, readBuffer[si]
    cmp al, 'c'             ;verificamos que venga el salto de c
    jne headerFail

    inc si
    mov al, readBuffer[si]
    cmp al, 'l'            ;verificamos que venga el salto de l
    jne headerFail

    inc si
    mov al, readBuffer[si]
    cmp al, 'a'            ;verificamos que venga el salto de a   
    jne headerFail

    inc si
    mov al, readBuffer[si]
    cmp al, 'v'            ;verificamos que venga el salto de v    
    jne headerFail

    inc si
    mov al, readBuffer[si]
    cmp al, 'e'            ;verificamos que venga el salto de e     
    jne headerFail



; contando espacios en blanco -----------------------------------------------------------------
    inc si
   
    mov trueCond, 1b

    whileSpacesClave:
        cmp trueCond, 1b
        jne EXITWHILESpacesClave
        
        cmp readBuffer[si], ' '
        jne UPDATECONDITIONCLAVE
        inc si
        jmp whileSpacesClave
        

        UPDATECONDITIONCLAVE:

        mov trueCond, 0b

    EXITWHILESpacesClave:
       

    cmp readBuffer[si], '='
    je equalchecker2
    jmp headerFail


    ; ; aca ya conto espacios y deberia de estar en el =

     equalchecker2:
        inc si
        mov trueCond, 1b
    ; recorre espacios luego del =
    whileSpacesClave2:
        cmp trueCond, 1b
        jne EXITWHILESpacesClave2
        
        mov al, readBuffer[si]
        cmp al, ' '
        jne UPDATECONDITIONCLAVE2
        inc si
        jmp whileSpacesClave2
        

        UPDATECONDITIONCLAVE2:

        mov trueCond, 0b

    EXITWHILESpacesClave2:

    cmp readBuffer[si], '"'
    jne headerFail
    passwordchecker:
        mov firstquoteIndex, si
        inc si
        
    ; ACA YA ENCONTRE UNA COMILLA Y DEBO DE SEGUIR RECORRIENDO HASTA ENCONTRAR OTRA
     mov trueCond, 1b
     loopToSecondQuote2:
        cmp trueCond, 1b
        jne EXITWHILESECOND
        
        mov al, readBuffer[si]
        cmp readBuffer[si], 0D
        je headerFail
        cmp readBuffer[si], '"'
        je UPDATECONDITIONsq
        inc si
        jmp loopToSecondQuote2
        

        UPDATECONDITIONsq:

        mov trueCond, 0b

    EXITWHILESECOND:
    ; verificamos si viene salto de linea
        mov secondquoteIndex, si
       

     
    ; ya guardando el password
    xor si, si
    xor di, di
    mov si, firstquoteIndex
    inc si ; moviendome al primer caracter luego de la primera comilla
    mov trueCond, 1b

    loopSavepassword:
        cmp trueCond, 1b
        jne exitLooppassword
  
        cmp readBuffer[si], '"'
        je exitLooppassword
        mov bh, readBuffer[si]
        mov password[di], bh 

        inc si
        inc di
        jmp loopSavepassword
    exitLooppassword:
        ; aca se han guardado las dos credenciales
        ; printString username
        ; printString password
    
    ; COMPARANDO EL NOMBRE DE USUARIO

    xor si, si
    xor bx, bx
    forLoopUsername:
        cmp si, 9
        je exitForLoopUsername

        mov al, username[si]
        cmp al, realUsername[si]
        jne headerFail

        inc si
        jmp forLoopUsername


 exitForLoopUsername:
    ; printString username
    ; printString password

; COMPARANDO LA CLAVE ------------------------------------------------------------------------------------------------

    xor si, si
    xor bx, bx
    forloopPassword:
        cmp si, 0A
        je exitforloopPassword

        mov al, password[si]
        mov bl, realPassword[si]
        cmp al, realPassword[si]
        jne headerFail

        inc si
        jmp forloopPassword


 exitforloopPassword:
    
    printString bienvenido
    printString username

    
   exit:
    .exit

    main ENDP

end main


