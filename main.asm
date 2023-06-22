include utils.asm
.radix 16
.model small
.stack
.data
    ;mensajes -------------------------------------------------------------------------------------------------------
    mensajeBienvenida db "----------------------------------------------",0A,"Universidad de San Carlos de Guatemala" ,0A , "Facultad de ingenieria", 0A,"Escuela de Vacaciones",0A,"Arquitectura de Computadores y Ensambladores 1",0A,"Diego Andres Huite Alvarez",0A, "202003585",0A, "----------------------------------------------" ,"$"
    userMenu db "Ingrese el caracter entre parentesis",0A, "--------MENU PRINCIPAL--------" ,0A,"(p)roductos",0A, "(v)entas",0A, "(h)erramientas", 0A,  "$"
    productMenu db "Ingrese el indice",0A, "--------MENU PRODUCTOS--------" ,0A,"1.Ingreso",0A, "2.Eliminacion",0A, "3.Visualizacion", 0A, "$"
    toolsMenu db "Ingrese el indice",0A, "--------MENU HERRAMIENTAS--------" ,0A,"1.Catalogo",0A, "2.Reporte alfabetico",0A, "3.Reporte ventas", 0A, "4.Productos sin existencias", 0A, "$"
    salesTitle db  "--------Ventas--------" , "$"
    bienvenido db "BIENVENIDO: ","$"
    credentialFileConfirmation db "EXISTE EL ARCHIVO",0A,"$"
    credentialFileNotExistent  db "CREDENCIALES NO ENCONTRADAS","$"
    lexicalError  db "ERROR EN ARCHIVO","$"
    lel1  db "lel1","$"
    lel2  db "CADENA ACEPTADA","$"
    lel3  db "lel3","$"
    lel4  db "hey se cumplio la condicion","$"
    ; lel5  db "lel5","$"
    newLine db 0A, "$"


    inserProductCode  db "Codigo de producto: ","$"
    inserProductDesc  db "Desc del producto: ","$"
    inserProductPrice  db "Precio: ","$"
    inserProductUnits  db "Unidades: ","$"
    ; variables para archivos
    auxCounter db 0000
    handlecredentialFile dw 0000
    handleprodFile dw 0000
    pathcredentialFile db "asm\pra\PRAII.CON",0 ; la ruta donde asm tiene que buscar
    pathProductFile db "asm\pra\PROD.BIN",0 ; 
    ; variables proposito general
    trueCond db 1
    condition1 db 0
    condition2 db 0
    condition3 db 0

    firstquoteIndex dw 0
    secondquoteIndex dw 0


    ; buffers
    readBuffer db 50 dup(0), "$"
    inputBuffer db   21, 00 
    db  21 dup (0)

    ; Logged User


    realUsername db "dalvarez", "$"
    realPassword db "202003585", "$"
    username db 8 dup(0), "$"
    password db 9 dup(0), "$"


    ; ESTRUCTURAS
    codigoProducto db 04 dup(0)
    descProducto db 20 dup(0)
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
        inc si
        mov al, readBuffer[si]
        cmp al, 0A            ;verificamos que venga el salto de linea     
        jne headerFail
        

    headerSuccess:
        ; printString readBuffer
        jmp userchecker

    headerFail:
        printString lexicalError
        jmp exit


    
    userchecker:

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
    inc si
    mov al, readBuffer[si]
    cmp al, 0A            ;verificamos que venga el salto de linea     
    jne headerFail

;manejo clave------------------------------------------------------------------------------------------------------------
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
    printString newLine

; aca ya sabemos que la credenciales son correctas

    welcomeEnter:
    enterkeyHandler ; recibe el input de un char 
    cmp al, 0D     ; compara para ver si fue un enter
    jne welcomeEnter

    displayUserMenu:
        printString userMenu
        enterkeyHandler
        cmp al, 'p'
        je displayProductMenu
        cmp al, 'h'
        je displayToolsMenu
        cmp al, 'v'
        je displaySalesMenu
        cmp al, 'q'
        je exit
        jmp displayUserMenu
    
    displayProductMenu:
        printString productMenu
        enterkeyHandler
        cmp al, 0D
        je  displayUserMenu
        cmp al, '1'
        je askForProductCode
        jmp displayProductMenu

    askForProductCode:
        printString inserProductCode
        saveBufferedInput inputBuffer
        printString newLine
        bufferPrinter inputBuffer
        xor si, si
        inc si
        mov al, inputBuffer[si]
        cmp al, 0 ; verificamos que el input sea distinto de cero
        je askForProductCode
        cmp al, 05 ; verificamos que el input sea de 4 caracteres como maximo
        jb saveProductCode
        jmp askForProductCode
    saveProductCode:
        xor si, si
        inc si
        mov bl, inputBuffer[si] ; guardamos el size del input
        inc si
        ; nos movemos al byte que contiene el primer caracter de la entrada
        xor di, di
        mov trueCond, 1
        ; guardamos cada caracter en su respectiva variable
    forProductCode:
        cmp di, 04
        je exitforProductCode
        mov al, inputBuffer[si]
        cmp al, 0D
        je exitforProductCode
        mov codigoProducto[di], al
        
        inc di
        inc si
        jmp forProductCode


    exitforProductCode:

    ; limpiamos si
    xor si, si
    mov condition1, 0
    mov condition2, 0
    RegexloopProductCode:
        cmp si, 4
        je exitRegexLoopProductCode

        cmp codigoProducto[si], 0
        je continueRegexloopProductCode
        ; verificamos que cada caracter del codigo sea letra mayus o numero
        ; condicion: if[ (caracter >= minLetra && caracter <= maxletra) || (caracter >= minNum && caracter <= maxNum) ]
        ; minletra = 41 = A(ascii) |  maxletra = 5A = Z(ascii)
        ; minNum = 30 = 0(ascii) |  maxNum = 39 = 9(ascii)


        FirstConditionRegexloopProductCode:
        ; printString lel1
        ; printString newLine
        mov al, codigoProducto[si]
        cmp al, 41
        jl clearFirstConditionRegexloopProductCode
        cmp al, 5A
        jg clearFirstConditionRegexloopProductCode
        mov condition1, 1
        jmp SecondConditionRegexloopProductCode

        clearFirstConditionRegexloopProductCode:
        mov condition1, 0
        jmp SecondConditionRegexloopProductCode

;--------------------------------------------------------------------------------------------
        SecondConditionRegexloopProductCode:
        ; printString lel3
        ; printString newLine
        mov al, codigoProducto[si]
        cmp al, 30
        jl clearSecondConditionRegexloopProductCode
        cmp al, 39
        jg clearSecondConditionRegexloopProductCode
        mov condition2, 1
        jmp ComparationConditionRegexloopProductCode


        clearSecondConditionRegexloopProductCode:
        mov condition2, 0

;------------------------------------------------------------------------------------------------
        ComparationConditionRegexloopProductCode:
        mov bl, condition1
        or bl, condition2

        cmp bl, 0
        je askForProductCode

        continueRegexloopProductCode:
            inc si
            jmp RegexloopProductCode
        exitRegexLoopProductCode:
            ;printString lel2
            
;PIDIENDO DESCRIPCION DEL PRODUCTO -------------------------------------------------------------------------
    askForProductDesc:
        printString inserProductDesc
        saveBufferedInput inputBuffer
        printString newLine
        bufferPrinter inputBuffer
        xor si, si
        inc si
        mov al, inputBuffer[si]
        cmp al, 0 ; verificamos que el input sea distinto de cero
        je askForProductDesc
        cmp al, 20 ; verificamos que el input sea de 32 caracteres como maximo
        jb saveProductDesc
        jmp askForProductDesc
    saveProductDesc:
        xor si, si
        inc si
        mov bl, inputBuffer[si] ; guardamos el size del input
        inc si
        ; nos movemos al byte que contiene el primer caracter de la entrada
        xor di, di
        mov trueCond, 1
        ; guardamos cada caracter en su respectiva variable
    forProductDesc:
        cmp di, 20 ; 32 iteraciones a hacer
        je exitforProductDesc
        mov al, inputBuffer[si]
        cmp al, 0D
        je exitforProductDesc
        mov descProducto[di], al
        
        inc di
        inc si
        jmp forProductDesc


    exitforProductDesc:

    ; limpiamos si
    xor si, si
    mov condition1, 0
    mov condition2, 0
    RegexloopProductDesc:
        cmp si, 20
        je exitRegexLoopProductDesc

        cmp descProducto[si], 0 ;NULL CHAR
        je continueRegexloopProductDesc
        cmp descProducto[si], 2C ; , CHAR
        je continueRegexloopProductDesc
        cmp descProducto[si], 21 ; ! CHAR
        je continueRegexloopProductDesc
        cmp descProducto[si], 2E ; ! CHAR
        je continueRegexloopProductDesc
        ; verificamos que cada caracter del codigo sea letra mayus o numero
        ; condicion: if[ (caracter >= minLetra && caracter <= maxletra) || (caracter >= minNum && caracter <= maxNum) ]
        ; minletra = 41 = A(ascii) |  maxletra = 5A = Z(ascii)
        ; minNum = 30 = 0(ascii) |  maxNum = 39 = 9(ascii)


        FirstConditionRegexloopProductDesc:
        ; printString lel1
        ; printString newLine
        mov al, descProducto[si]
        cmp al, 41
        jl clearFirstConditionRegexloopProductDesc
        cmp al, 5A
        jg clearFirstConditionRegexloopProductDesc
        mov condition1, 1
        jmp SecondConditionRegexloopProductDesc

        clearFirstConditionRegexloopProductDesc:
        mov condition1, 0
        jmp SecondConditionRegexloopProductDesc

;--------------------------------------------------------------------------------------------
        SecondConditionRegexloopProductDesc:
        ; printString lel1
        ; printString newLine
        mov al, descProducto[si]
        cmp al, 30
        jl clearSecondConditionRegexloopProductDesc
        cmp al, 39
        jg clearSecondConditionRegexloopProductDesc
        mov condition2, 1
        jmp ThirdConditionRegexloopProductDesc

        clearSecondConditionRegexloopProductDesc:
        mov condition2, 0
        jmp ThirdConditionRegexloopProductDesc

;------------------------------------------------------------------------------------------------
ThirdConditionRegexloopProductDesc:
        ; printString lel3
        ; printString newLine
        mov al, descProducto[si]
        cmp al, 61 ;CHAR a
        jl clearThirdConditionRegexloopProductDesc
        cmp al, 7A; char z
        jg clearThirdConditionRegexloopProductDesc
        mov condition3, 1
        jmp ComparationConditionRegexloopProductDesc
        clearThirdConditionRegexloopProductDesc:
        mov condition3, 0

;--------------------------------------------------------------------------------------------------
        ComparationConditionRegexloopProductDesc:
        mov bl, condition1
        or bl, condition2
        or bl, condition3

        cmp bl, 0
        je askForProductDesc

        continueRegexloopProductDesc:
            inc si
            jmp RegexloopProductDesc
        exitRegexLoopProductDesc:
            ;printString lel2

;PEDIMOS PRECIO DEL PRODUCTO --------------------------------------------------------------------------------------
    askForProductPrice:
        printString inserProductPrice
        saveBufferedInput inputBuffer
        printString newLine
        bufferPrinter inputBuffer
        xor si, si
        inc si
        mov al, inputBuffer[si]
        cmp al, 0 ; verificamos que el input sea distinto de cero
        je askForProductPrice
        cmp al, 03 ; verificamos que el input sea de 2 caracteres como maximo
        jb saveProductPrice
        jmp askForProductPrice
    saveProductPrice:
        xor si, si
        inc si
        mov bl, inputBuffer[si] ; guardamos el size del input
        inc si
        ; nos movemos al byte que contiene el primer caracter de la entrada
        xor di, di
        mov trueCond, 1
        ; guardamos cada caracter en su respectiva variable
    forProductPrice:
        cmp di, 02
        je exitforProductPrice
        mov al, inputBuffer[si]
        cmp al, 0D
        je exitforProductPrice
        mov productPrice[di], al
        
        inc di
        inc si
        jmp forProductPrice


    exitforProductPrice:

    ; limpiamos si
    xor si, si
    mov condition1, 0
    RegexloopProductPrice:
        cmp si, 2
        je exitRegexLoopProductPrice

        cmp productPrice[si], 0
        je continueRegexloopProductPrice
        ; verificamos que cada caracter del codigo sea letra mayus o numero
        ; condicion: if[ (caracter >= minLetra && caracter <= maxletra) || (caracter >= minNum && caracter <= maxNum) ]
        ; minletra = 41 = A(ascii) |  maxletra = 5A = Z(ascii)
        ; minNum = 30 = 0(ascii) |  maxNum = 39 = 9(ascii)


        FirstConditionRegexloopProductPrice:
        ; printString lel1
        ; printString newLine
        mov al, productPrice[si]
        cmp al, 30
        jl clearFirstConditionRegexloopProductPrice
        cmp al, 39
        jg clearFirstConditionRegexloopProductPrice
        mov condition1, 1
        jmp ComparationConditionRegexloopProductPrice

        clearFirstConditionRegexloopProductPrice:
        mov condition1, 0


;------------------------------------------------------------------------------------------------
        ComparationConditionRegexloopProductPrice:
        mov bl, condition1

        cmp bl, 0
        je askForProductPrice

        continueRegexloopProductPrice:
            inc si
            jmp RegexloopProductPrice
        exitRegexLoopProductPrice:
;PEDIMOS UNIDADES DEL PRODUCTO --------------------------------------------------------------------------------------
    askForProductUnits:
        printString inserProductUnits
        saveBufferedInput inputBuffer
        printString newLine
        bufferPrinter inputBuffer
        xor si, si
        inc si
        mov al, inputBuffer[si]
        cmp al, 0 ; verificamos que el input sea distinto de cero
        je askForProductUnits
        cmp al, 03 ; verificamos que el input sea de 2 caracteres como maximo
        jb saveProductUnits
        jmp askForProductUnits
    saveProductUnits:
        xor si, si
        inc si
        mov bl, inputBuffer[si] ; guardamos el size del input
        inc si
        ; nos movemos al byte que contiene el primer caracter de la entrada
        xor di, di
        mov trueCond, 1
        ; guardamos cada caracter en su respectiva variable
    forProductUnits:
        cmp di, 02
        je exitforProductUnits
        mov al, inputBuffer[si]
        cmp al, 0D
        je exitforProductUnits
        mov productUnits[di], al
        
        inc di
        inc si
        jmp forProductUnits


    exitforProductUnits:

    ; limpiamos si
    xor si, si
    mov condition1, 0
    RegexloopProductUnits:
        cmp si, 2
        je exitRegexLoopProductUnits

        cmp productUnits[si], 0
        je continueRegexloopProductUnits
        ; verificamos que cada caracter del codigo sea letra mayus o numero
        ; condicion: if[ (caracter >= minLetra && caracter <= maxletra) || (caracter >= minNum && caracter <= maxNum) ]
        ; minletra = 41 = A(ascii) |  maxletra = 5A = Z(ascii)
        ; minNum = 30 = 0(ascii) |  maxNum = 39 = 9(ascii)


        FirstConditionRegexloopProductUnits:
        ; printString lel1
        ; printString newLine
        mov al, productUnits[si]
        cmp al, 30
        jl clearFirstConditionRegexloopProductUnits
        cmp al, 39
        jg clearFirstConditionRegexloopProductUnits
        mov condition1, 1
        jmp ComparationConditionRegexloopProductUnits

        clearFirstConditionRegexloopProductUnits:
        mov condition1, 0


;------------------------------------------------------------------------------------------------
        ComparationConditionRegexloopProductUnits:
        mov bl, condition1

        cmp bl, 0
        je askForProductUnits

        continueRegexloopProductUnits:
            inc si
            jmp RegexloopProductUnits
        exitRegexLoopProductUnits:

; UNA VEZ INGRESADA TODA LA DATA, NECESITAMOS VERIFICAR QUE EL ARCHIVO PROD.BIN EXISTA
    searchFile pathProductFile
        jc prodFileCreator
        ; escribir el producto
       ; escribir el producto
        mov [handleprodFile], ax
        mov bx, [handleprodFile]
        mov cx, 28
        mov dx, offset codigoProducto  
        mov ah, 40
        int 21
        ; cerramos el archivo
        mov ah, 3E
        int 21
        jmp displayProductMenu
        jmp displayProductMenu


    prodFileCreator:
        
        mov [handleprodFile], ax
        mov ah, 3E
        mov bx, [handleprodFile]
        int 21
        ; escribir el producto
        mov [handleprodFile], ax
        mov bx, [handleprodFile]
        mov cx, 28
        mov dx, offset codigoProducto  
        mov ah, 40
        int 21
        ; cerramos el archivo
        mov ah,  3E
        int 21
        jmp displayProductMenu


    displayToolsMenu:
        printString toolsMenu
        enterkeyHandler
        cmp al, 0D
        je  displayUserMenu
        jmp displayToolsMenu

    displaySalesMenu:
        printString salesTitle
        jmp displayUserMenu



    exit:
    .exit

    main ENDP




end main


