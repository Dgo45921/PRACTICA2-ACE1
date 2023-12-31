include utils.asm
.radix 16
.model small
.stack
.data
ceritos           db     "00000"
dos_puntos           db     ":"
diagonal              db     "/"
tam_encabezado_html    db     0c
encabezado_html        db     "<html><body>"
tam_inicializacion_tabla   db   5E
tam_inicializacion_tablaABC   db   3A
inicializacion_tabla   db     '<table border="1"><tr><td>codigo</td><td>descripcion</td><td>Precio</td><td>Unidades</td></tr>'
inicializacion_tablaABC   db     '<table border="1"><tr><td>LETRA</td><td>CANTIDAD</td></tr>'
inicializacion_repVentas   db     '<FECHA> <HORA>',0A, '======================', 0A, 'ultimas ventas:',0A
mayorVenta db "Venta con mayor monto:",0A
menorVenta db "Venta con menor monto:",0A
tammayorVenta db 17
separator                    db "----------------------------------", 0A
tamSeparator                  db 23
tam_inicializacion_repVentas db   36
fechaTitle db   'Fecha: '
tamFechaTitle db     07
montoTitle db   'Monto: '
tamMontoTitle db     07
tam_cierre_tabla       db     8
cierre_tabla           db     "</table>"
tam_footer_html        db     0e
footer_html            db     "</body></html>"
td_html                db     "<td>"
tdc_html               db     "</td>"
tr_html                db     "<tr>"
trc_html               db     "</tr>"
p_html                 db     "<p>"
pc_html                db     "</p>"
letraMin               db     0000
letraMay               db     0000

 ;CLONES
    CloncodigoProducto db 04 dup(0)
    ClondescProducto db 20 dup(0)
    ClonproductPrice db 05 dup(0)
    ClonproductUnits db 05 dup(0)
    cerosProd db 2E dup(0)
    numero    db   05 dup (30)
    numeroInvert    db   05 dup (0000)

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
    continueFiveProducts db "Ingrese enter si quiere ver otros 5 productos o 'q' si desea salir", "$"
    prodNotFounc db "Producto no encontrado", "$"
    prodFound db "PRODUCTO ENCONTRADO","$"
    unidadesInsuficientes db "UNIDADES INSUFICIENTES","$"
    montoOutput db "MONTO: ","$"
    prodNotFound  db "PRODUCTO INEXISTENTE","$"
    lel1  db "lel1","$"
    lel2  db "CADENA ACEPTADA","$"
    lel3  db "lel3","$"
    lel4  db "hey se cumplio la condicion","$"
    ; lel5  db "lel5","$"
    newLine db 0A, "$"
    spaces db  "   ", "$"


    inserProductCode  db "Codigo de producto: ","$"
    inserProductDesc  db "Desc del producto: ","$"
    inserProductPrice  db "Precio: ","$"
    inserProductUnits  db "Unidades: ","$"
    ; variables para archivos
    auxCounter db 0000
    handlecredentialFile dw 0000
    handleprodFile dw 0000
    handleCatalogFile dw 0000
    handleFaltaFile dw 0000
    handleABCFile dw 0000
    handleVENTASFile dw 0000
    handleRepoVentas dw 0000
    pathcredentialFile db "PRAII.CON",0 ; la ruta donde asm tiene que buscar
    pathProductFile db "PROD.BIN",0 ; 
    pathCatalogFile db "CATALG.HTM",0
    pathABCFile db "ABC.HTM",0
    pathFalta db "FALTA.HTM",0
    pathVentas db "VENT.BIN",0
    pathRepoVentas db "REP.TXT",0
    ; variables proposito general
    trueCond db 1
    condition1 db 0
    condition2 db 0
    condition3 db 0
    iterableABC db 0000
    contadorLetra dw 0000

    firstquoteIndex dw 0
    secondquoteIndex dw 0
    puntero_temp dw 0000


    ; buffers
    readBuffer db 50 dup(0), "$"
    inputBuffer db   21, 00 
    db  21 dup (0)

    ; Logged User


    realUsername db "dalvarez", "$"
    realPassword db "202003585", "$"
    username db 8 dup(0), "$"
    password db 9 dup(0), "$"


     ;STRING ESTRUCTURAS
    
    auxcodigoProducto db 04 dup(0), "$"
    auxdescProducto db 20 dup(0), "$"
    auxproductPrice db 05 dup(0), "$"
    auxproductUnits db 05 dup(0), "$"
    ;ESTRUCTURAS
    codigoProducto db 04 dup(0)
    descProducto db 20 dup(0)
    productPrice db 05 dup(0)
    productUnits db 05 dup(0)
    ; pesan 2E 

    numPrice   dw 0000
    numUnits   dw 0000
    

    ; ESTRUCTURAS VENTAS
    ventaDia db 0000
    ventaMes db 0000
    ventaAnio dw 0000
    ventaHora db 0000
    ventaMin db 0000
    ventaCodigoProducto db 04 dup(0)
    ; PESAN 10 BYTES 0A(HEX)
    venaUnitsString db 05 dup(0)
    ventaUnidades dw 0000
    ; Pesa 3 bytes 03
    montoTotalVenta dw 0000


     ;ESTRUCTURAS VENTAS CLONADA
    clonventaDia db 0000
    clonventaMes db 0000
    clonventaAnio dw 0000
    clonventaHora db 0000
    clonventaMin db 0000
    clonventaCodigoProducto db 04 dup(0)
    ; PESAN 10 BYTES 0A(HEX)
    clonvenaUnitsString db 05 dup(0)
    clonventaUnidades dw 0000
    ; Pesa 3 bytes 03
    clonmontoTotalVenta dw 0000
   
   
    
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
        clearVariables
        printString productMenu
        enterkeyHandler
        cmp al, 0D
        je  displayUserMenu
        cmp al, '1'
        je askForProductCode
        cmp al, '2'
        je askForProductCodeToDelete
        cmp al, '3'
        je displayProducts
        jmp displayProductMenu

    displayProducts:
    ;abriendo el archivo
        mov ah, 3d
        mov al, 02
        mov dx, offset pathProductFile
        int 21
        jnc readFileTodisplayP
        printString lexicalError
        jmp displayProductMenu

    readFileTodisplayP:
    ; guardamos handle
    mov [handleprodFile], ax

    displayfiveProducts:
    ; leemos archivo
    xor si, si
    
    loopReadProductData:
        cmp si, 5
        je exitloopReadProductData
        mov ah, 3F
        mov bx, [handleprodFile]
        mov cx, 2E 
        mov dx, offset codigoProducto
        int 21
        cmp AX, 00
	    je exitloopReadProductData
        ; aca guardo en un string auxiliar cada campo recibido del producto
        createAuxProdCod
        createAuxProdDesc
        ; createAuxProdPrice
        ; createAuxProdUnits
        printString auxcodigoProducto
        printString spaces
        printString auxdescProducto
        ; printString spaces
        ; printString auxproductPrice
        ; printString spaces
        ; printString auxproductUnits

        
        printString newLine
        inc si
        jmp loopReadProductData
    exitloopReadProductData:
    printString continueFiveProducts
    printString newLine
    enterkeyHandler
    cmp al, 0D
    je displayfiveProducts
    cmp al, 'q'
    je closingFiveProducts
    jmp exitloopReadProductData

    closingFiveProducts:
    ; cerramos archivo
    mov bx, [handleprodFile]
    mov ah, 3e
    int 21
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
        cmp al, 06 ; verificamos que el input sea de 5 caracteres como maximo
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
        cmp di, 05
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
        cmp si, 5
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
        cmp al, 06 ; verificamos que el input sea de 5 caracteres como maximo
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
        cmp di, 05
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
        cmp si, 5
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

    ; verificar que el producto no exista antes de insertarlo
    searchFile pathProductFile
            jc prodFileCreator
            mov [handleprodFile], ax

    ; VERIFICANDO 
      loopExistenProduct:
           
            mov ah, 3f
            mov bx, [handleprodFile]
            mov cx, 2E
            mov dx, offset CloncodigoProducto
            int 21
            cmp ax, 0000
            je productExistentfailed
            ; comparamos el producto leido con el producto ingresado
                    xor si, si


                productExistentVerifier2:
                    cmp si, 04
                    jge productExistentVerifier2Exit
                    mov al, CloncodigoProducto[si]
                    cmp al, codigoProducto[si]
                    jne loopExistenProduct
                    

                    
                    inc si
                    jmp productExistentVerifier2

                productExistentVerifier2Exit:
                    printString prodFound
                    printString newLine

                    jmp displayProductMenu     


            jmp loopExistenProduct

        productExistentfailed:
            










    searchFile pathProductFile
        jc prodFileCreator
        mov [handleprodFile], ax
        ; nos movemos al final del archivo
        ; BUSCAMOS EL ESPACIO VACIO
        mov dx, 0000
        mov [puntero_temp], dx


        SearchEmptySpace:
        mov ah, 3f
        mov bx, [handleprodFile]
        mov cx, 2E
        mov dx, offset CloncodigoProducto
        int 21

        mov dx, [puntero_temp]
        add dx, 2E
        mov [puntero_temp], dx

        xor si, si
         
        cmp ax, 00
        je addtoEnd
        cmp CloncodigoProducto [si] , 0
        je addInMiddle
        jmp SearchEmptySpace
        ; loop para comparar el codigo ingresado con el codigo leido
        
        

        addInMiddle:
         ; nos posicionamos en el producto a ingresar
        mov dx, [puntero_temp]
        sub dx, 2E
        mov cx, 0000
        mov bx, [handleprodFile]
        mov al, 0
        mov ah, 42
        int 21
        ; escribimos el producto en si
        mov cx, 2E
        mov dx, offset codigoProducto
        mov ah, 40
        int 21

     ; cerramos el archivo
        mov bx, [handleprodFile]
        mov ah, 3E
        int 21
            
        jmp displayProductMenu


      
        addtoEnd:
        ; agregamos al final del archivo
 
        mov cx, 00
        mov dx, 00
        mov al, 2
        mov ah, 42
        mov bx, [handleprodFile]
        int 21

        ; escribir el producto
        mov bx, [handleprodFile]
        mov cx, 2E
        mov dx, offset codigoProducto  
        mov ah, 40
        int 21
        ; cerramos el archivo
        mov bx, [handleprodFile]
        mov ah, 3E
        int 21
        jmp displayProductMenu
        


    prodFileCreator:
        mov CX, 0000
		mov DX, offset pathProductFile
		mov AH, 3c
		int 21
        mov [handleprodFile], ax
        ; escribir el producto
        mov bx, [handleprodFile]
        mov cx, 2E
        mov dx, offset codigoProducto  
        mov ah, 40
        int 21
        ; cerramos el archivo
        mov ah,  3E
        int 21
        jmp displayProductMenu


; ACA OBTENEMOS EL INPUT PARA ELIMINAR UN PRODUCTO-------------------------------------------------------

askForProductCodeToDelete:
        printString inserProductCode
        saveBufferedInput inputBuffer
        printString newLine
        bufferPrinter inputBuffer
        xor si, si
        inc si
        mov al, inputBuffer[si]
        cmp al, 0 ; verificamos que el input sea distinto de cero
        je askForProductCodeToDelete
        cmp al, 05 ; verificamos que el input sea de 4 caracteres como maximo
        jb saveProductCodeToDelete
        jmp askForProductCodeToDelete
    saveProductCodeToDelete:
        xor si, si
        inc si
        mov bl, inputBuffer[si] ; guardamos el size del input
        inc si
        ; nos movemos al byte que contiene el primer caracter de la entrada
        xor di, di
        mov trueCond, 1
        ; guardamos cada caracter en su respectiva variable
    forProductCodeToDelete:
        cmp di, 04
        je exitforProductCodeToDelete
        mov al, inputBuffer[si]
        cmp al, 0D
        je exitforProductCodeToDelete
        mov auxcodigoProducto[di], al
        
        inc di
        inc si
        jmp forProductCodeToDelete


    exitforProductCodeToDelete:

    openProdFile:
    ; abrimos el archivo de productos
        mov dx, 0000
        mov [puntero_temp], dx
        
        mov ah, 3D
        mov al, 02
        mov dx, offset pathProductFile
        int 21
        jc headerFail
        mov [handleprodFile], ax

    ; leemos todo el archivo
    searchProdToDelete:
        mov ah, 3f
        mov bx, [handleprodFile]
        mov cx, 2E
        mov dx, offset codigoProducto
        int 21
        mov dx, [puntero_temp]
        add dx, 2E
        mov [puntero_temp], dx
         
        cmp ax, 00
        je closeProdFileNotFound
        ; loop para comparar el codigo ingresado con el codigo leido
        
        xor si, si


        LoopComparingProductToDelete:
            cmp si, 4
            je delProduct

            mov bl, codigoProducto[si]
            cmp bl, auxcodigoProducto[si]
            jne searchProdToDelete

        continueLoopComparingProductToDelete:
            inc si
            jmp LoopComparingProductToDelete

    delProduct:
       
        ; nos posicionamos en el producto a eliminar
        mov dx, [puntero_temp]
        sub dx, 2E
        mov cx, 0000
        mov bx, [handleprodFile]
        mov al, 0
        mov ah, 42
        int 21
        ; escribimos 0s en el archivo
        mov cx, 2E
        mov dx, offset cerosProd
        mov ah, 40
        int 21
        jmp closeProdFile



        

    ; cerramos el archivo de productos
    closeProdFileNotFound:
        printString prodNotFounc
        printString newLine
        mov ah, 3E
        mov bx, [handleprodFile]
        int 21
    jmp displayProductMenu

    closeProdFile:
        mov ah, 3E
        mov bx, [handleprodFile]
        int 21




    jmp displayProductMenu






    displayToolsMenu:
        printString toolsMenu
        enterkeyHandler
        cmp al, 0D
        je  displayUserMenu
        cmp al, '1'
        je generateCatalog
        cmp al, '2'
        je generateABC
        cmp al, '3'
        je generateSalesReport
        cmp al, '4'
        je generateFALTA
        jmp displayToolsMenu


    generateSalesReport:

     ; abrimos el vent.bin
            mov al, 2
            mov ah, 3d
            mov dx, offset pathVentas
            int 21
            mov [handleVENTASFile], ax
    

            mov [puntero_temp], 0000

     loopsales:
           
            mov ah, 3f
            mov bx, [handleVENTASFile]
            mov cx, 0A
            mov dx, offset ventaDia
            int 21
            mov dx, [puntero_temp]
            add dx, 0A
            mov [puntero_temp], dx

            

            mov ah, 3f
            mov bx, [handleVENTASFile]
            mov cx, 04
            mov dx, offset ventaUnidades
            int 21
            mov dx, [puntero_temp]
            add dx, 04
            mov [puntero_temp], dx

            cmp ax, 0000
            je exitloopsales



            
        
        jmp loopsales

        exitloopsales:

        ; moviendo el puntero

        mov dx, [puntero_temp]
        sub dx, 54
        mov cx, 0000
        mov bx, [handleVENTASFile]
        mov al, 0
        mov ah, 42
        int 21

        ; creamos el archivo txt de ventas
        mov ah, 3c
        mov cx, 0
        mov dx, offset pathRepoVentas
        int 21
        mov [handleRepoVentas], ax

        mov BX, [handleRepoVentas]
        mov AH, 40
        mov CH, 00
        mov CL, [tam_inicializacion_repVentas]
        mov DX, offset inicializacion_repVentas
        int 21
    



        
     loopsales2:
           
            mov ah, 3f
            mov bx, [handleVENTASFile]
            mov cx, 0A
            mov dx, offset ventaDia
            int 21
            cmp ax, 0000
        
            

            mov ah, 3f
            mov bx, [handleVENTASFile]
            mov cx, 04
            mov dx, offset ventaUnidades
            int 21
            cmp ax, 0000
            je exitloopsales2
          

            ; printString lel1
            ; printString newLine
            ; TITULO DE LA FECHA
            mov BX, [handleRepoVentas]
            mov AH, 40
            mov CH, 00
            mov CL, [tamFechaTitle]
            mov DX, offset fechaTitle
            int 21

            ; INGRESANDO LA FECHA
             ;AGREGANDO FECHA
            ; AGREGANDO DIA

                xor ax, ax
                mov al, [ventaDia]
                call numAcadena
                ; ESCRIBIENDO DIA
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 02
                mov DX, offset numero + 03
                int 21
                ; agregar una diagonal
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 01
                mov DX, offset diagonal
                int 21

                xor ax, ax
                mov al, [ventaMes]
                call numAcadena

                ; AGREGANDO MES
                mov ah, 2A
                int 21
                xor ax, ax
                mov al, dh
                call numAcadena

                xor ax, ax
                mov al, [ventaMes]
                call numAcadena
                ; ESCRIBIENDO MES
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 02
                mov DX, offset numero + 03
                int 21

                ; agregar una diagonal
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 01
                mov DX, offset diagonal
                int 21

                xor ax, ax
                mov ax, [ventaAnio]
                call numAcadena

                ; ESCRIBIENDO AÑO
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 04
                mov DX, offset numero + 01
                int 21

                ; ESCRIBIENDO ESPACIOS
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 03
                mov DX, offset spaces
                int 21

                xor ax, ax
                mov al, [ventaHora]
                call numAcadena
                 ; ESCRIBIENDO HORA
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 02
                mov DX, offset numero + 03
                int 21



                ; agregamos los dos puntos 
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 01
                mov DX, offset dos_puntos
                int 21

                xor ax, ax
                mov al, [ventaMin]
                call numAcadena
                 ; ESCRIBIENDO MINUTO
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 02
                mov DX, offset numero + 03
                int 21




                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 01
                mov DX, offset newLine
                int 21




                ; TITULO DEL MONTO
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, [tamMontoTitle]
                mov DX, offset montoTitle
                int 21

                xor ax, ax
                mov ax, [montoTotalVenta]
                call numAcadena

                 ; ESCRIBIENDO MONTO
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 05
                mov DX, offset numero
                int 21

                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 01
                mov DX, offset newLine
                int 21

                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, [tamSeparator]
                mov DX, offset separator
                int 21



            
            
        
        jmp loopsales2

        exitloopsales2:
        ; moviendo el puntero al inicio
        mov dx, 0000
        mov cx, 0000
        mov bx, [handleVENTASFile]
        mov al, 00
        mov ah, 42
        int 21

        mov ah, 3f
        mov bx, [handleVENTASFile]
        mov cx, 0A
        mov dx, offset clonventaDia
        int 21
        mov dx, [puntero_temp]
        add dx, 0A
        mov [puntero_temp], dx

            

        mov ah, 3f
        mov bx, [handleVENTASFile]
        mov cx, 04
        mov dx, offset clonventaUnidades
        int 21
        mov dx, [puntero_temp]
        add dx, 04
        mov [puntero_temp], dx

        ; moviendo el puntero al inicio
        mov dx, 0000
        mov cx, 0000
        mov bx, [handleVENTASFile]
        mov al, 00
        mov ah, 42
        int 21

        ; intentando hallar la venta mas grande
        loopsalesbiggest:
           
            mov ah, 3f
            mov bx, [handleVENTASFile]
            mov cx, 0A
            mov dx, offset ventaDia
            int 21
            mov dx, [puntero_temp]
            add dx, 0A
            mov [puntero_temp], dx

            

            mov ah, 3f
            mov bx, [handleVENTASFile]
            mov cx, 04
            mov dx, offset ventaUnidades
            int 21
            mov dx, [puntero_temp]
            add dx, 04
            mov [puntero_temp], dx

            cmp ax, 0000
            je exitloopsalesbiggest


            mov ax, [montoTotalVenta]
            cmp ax, clonmontoTotalVenta
            jg hacercambioclon
            jmp loopsalesbiggest
            hacercambioclon:
                ; pasamos el monto total al clon asi como sus demas atributos
                mov [clonmontoTotalVenta], ax
                ; movemos dia
                mov al, [ventaDia]
                mov clonventaDia, al
                 ; movemos mes
                mov al, [ventaMes]
                mov clonventaMes, al

                ; movemos anio
                mov ax, [ventaAnio]
                mov [clonventaAnio], ax

                 ; movemos hora
                mov al, [ventaHora]
                mov clonventaHora, al
                ; movemos minuto
                mov al, [ventaMin]
                mov clonventaMin, al
            



            
        
        jmp loopsalesbiggest

        exitloopsalesbiggest:

         ; ESCRIBIENDO TITULO MAYOR MONTO
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, tammayorVenta
                mov DX, offset mayorVenta
                int 21


                xor ax, ax
                mov al, [clonventaDia]
                call numAcadena
                ; ESCRIBIENDO DIA
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 02
                mov DX, offset numero + 03
                int 21
                ; agregar una diagonal
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 01
                mov DX, offset diagonal
                int 21

                xor ax, ax
                mov al, [clonventaMes]
                call numAcadena

                ; AGREGANDO MES
                mov ah, 2A
                int 21
                xor ax, ax
                mov al, dh
                call numAcadena

                xor ax, ax
                mov al, [clonventaMes]
                call numAcadena
                ; ESCRIBIENDO MES
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 02
                mov DX, offset numero + 03
                int 21

                ; agregar una diagonal
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 01
                mov DX, offset diagonal
                int 21

                xor ax, ax
                mov ax, [clonventaAnio]
                call numAcadena

                ; ESCRIBIENDO AÑO
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 04
                mov DX, offset numero + 01
                int 21

                ; ESCRIBIENDO ESPACIOS
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 03
                mov DX, offset spaces
                int 21

                xor ax, ax
                mov al, [clonventaHora]
                call numAcadena
                 ; ESCRIBIENDO HORA
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 02
                mov DX, offset numero + 03
                int 21



                ; agregamos los dos puntos 
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 01
                mov DX, offset dos_puntos
                int 21

                xor ax, ax
                mov al, [clonventaMin]
                call numAcadena
                 ; ESCRIBIENDO MINUTO
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 02
                mov DX, offset numero + 03
                int 21




                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 01
                mov DX, offset newLine
                int 21




                ; TITULO DEL MONTO
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, [tamMontoTitle]
                mov DX, offset montoTitle
                int 21

                xor ax, ax
                mov ax, [clonmontoTotalVenta]
                call numAcadena

                 ; ESCRIBIENDO MONTO
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 05
                mov DX, offset numero
                int 21

                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 01
                mov DX, offset newLine
                int 21

                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, [tamSeparator]
                mov DX, offset separator
                int 21
    ; LO MISMO PERO CON EL MONTO MAS PEQUE
    ; moviendo el puntero al inicio
        mov dx, 0000
        mov cx, 0000
        mov bx, [handleVENTASFile]
        mov al, 00
        mov ah, 42
        int 21

        mov ah, 3f
        mov bx, [handleVENTASFile]
        mov cx, 0A
        mov dx, offset clonventaDia
        int 21
        mov dx, [puntero_temp]
        add dx, 0A
        mov [puntero_temp], dx

            

        mov ah, 3f
        mov bx, [handleVENTASFile]
        mov cx, 04
        mov dx, offset clonventaUnidades
        int 21
        mov dx, [puntero_temp]
        add dx, 04
        mov [puntero_temp], dx

        ; moviendo el puntero al inicio
        mov dx, 0000
        mov cx, 0000
        mov bx, [handleVENTASFile]
        mov al, 00
        mov ah, 42
        int 21

        ; intentando hallar la venta mas grande
        loopsalessmallest:
           
            mov ah, 3f
            mov bx, [handleVENTASFile]
            mov cx, 0A
            mov dx, offset ventaDia
            int 21
            mov dx, [puntero_temp]
            add dx, 0A
            mov [puntero_temp], dx

            

            mov ah, 3f
            mov bx, [handleVENTASFile]
            mov cx, 04
            mov dx, offset ventaUnidades
            int 21
            mov dx, [puntero_temp]
            add dx, 04
            mov [puntero_temp], dx

            cmp ax, 0000
            je exitloopsalessmallest


            mov ax, [montoTotalVenta]
            cmp ax, clonmontoTotalVenta
            jl hacercambioclon2
            jmp loopsalessmallest
            hacercambioclon2:
                ; pasamos el monto total al clon asi como sus demas atributos
                mov [clonmontoTotalVenta], ax
                ; movemos dia
                mov al, [ventaDia]
                mov clonventaDia, al
                 ; movemos mes
                mov al, [ventaMes]
                mov clonventaMes, al

                ; movemos anio
                mov ax, [ventaAnio]
                mov [clonventaAnio], ax

                 ; movemos hora
                mov al, [ventaHora]
                mov clonventaHora, al
                ; movemos minuto
                mov al, [ventaMin]
                mov clonventaMin, al
            



            
        
        jmp loopsalessmallest

        exitloopsalessmallest:

         ; ESCRIBIENDO TITULO MAYOR MONTO
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, tammayorVenta
                mov DX, offset menorVenta
                int 21


                xor ax, ax
                mov al, [clonventaDia]
                call numAcadena
                ; ESCRIBIENDO DIA
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 02
                mov DX, offset numero + 03
                int 21
                ; agregar una diagonal
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 01
                mov DX, offset diagonal
                int 21

                xor ax, ax
                mov al, [clonventaMes]
                call numAcadena

                ; AGREGANDO MES
                mov ah, 2A
                int 21
                xor ax, ax
                mov al, dh
                call numAcadena

                xor ax, ax
                mov al, [clonventaMes]
                call numAcadena
                ; ESCRIBIENDO MES
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 02
                mov DX, offset numero + 03
                int 21

                ; agregar una diagonal
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 01
                mov DX, offset diagonal
                int 21

                xor ax, ax
                mov ax, [clonventaAnio]
                call numAcadena

                ; ESCRIBIENDO AÑO
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 04
                mov DX, offset numero + 01
                int 21

                ; ESCRIBIENDO ESPACIOS
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 03
                mov DX, offset spaces
                int 21

                xor ax, ax
                mov al, [clonventaHora]
                call numAcadena
                 ; ESCRIBIENDO HORA
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 02
                mov DX, offset numero + 03
                int 21



                ; agregamos los dos puntos 
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 01
                mov DX, offset dos_puntos
                int 21

                xor ax, ax
                mov al, [clonventaMin]
                call numAcadena
                 ; ESCRIBIENDO MINUTO
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 02
                mov DX, offset numero + 03
                int 21




                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 01
                mov DX, offset newLine
                int 21




                ; TITULO DEL MONTO
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, [tamMontoTitle]
                mov DX, offset montoTitle
                int 21

                xor ax, ax
                mov ax, [clonmontoTotalVenta]
                call numAcadena

                 ; ESCRIBIENDO MONTO
                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 05
                mov DX, offset numero
                int 21

                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, 01
                mov DX, offset newLine
                int 21

                mov BX, [handleRepoVentas]
                mov AH, 40
                mov CH, 00
                mov CL, [tamSeparator]
                mov DX, offset separator
                int 21





        ; cerrar el archivo
            mov bx, [handleRepoVentas]
            mov ah, 3E
            int 21








        jmp displayToolsMenu







    generateCatalog:
        ; abrimos el prod.bin
            mov al, 2
            mov ah, 3d
            mov dx, offset pathProductFile
            int 21
            mov [handleprodFile], ax
            


        
       ; creamos el archivo
        mov ah, 3c
        mov cx, 0
        mov dx, offset pathCatalogFile
        int 21
        mov [handleCatalogFile], ax
        ; agregamos fecha y hora
        ; agregando hora
        ;CH = hours
        ;CL = minutes
        mov ah, 2C
        int 21
        xor ax, ax
        mov al, ch
        call numAcadena
        ; ESCRIBIENDO HORA
        mov BX, [handleCatalogFile]
		mov AH, 40
		mov CH, 00
		mov CL, 02
		mov DX, offset numero + 03
        int 21



        ; agregamos los dos puntos 
            mov BX, [handleCatalogFile]
            mov AH, 40
            mov CH, 00
            mov CL, 01
            mov DX, offset dos_puntos
            int 21



        ; agregando minuto
        ;CH = hours
        ;CL = minutes
        mov ah, 2C
        int 21
        xor ax, ax
        mov al, cl
        call numAcadena
        ; ESCRIBIENDO MINUTO
        mov BX, [handleCatalogFile]
		mov AH, 40
		mov CH, 00
		mov CL, 02
		mov DX, offset numero + 03
        int 21


        ; agregamos unos espacios
        mov BX, [handleCatalogFile]
        mov AH, 40
        mov CH, 00
        mov CL, 03
        mov DX, offset spaces
        int 21

        ;AGREGANDO FECHA
        ; AGREGANDO DIA
        mov ah, 2A
        int 21
        xor ax, ax
        mov al, dl
        call numAcadena
        ; ESCRIBIENDO DIA
        mov BX, [handleCatalogFile]
		mov AH, 40
		mov CH, 00
		mov CL, 02
		mov DX, offset numero + 03
        int 21
        ; agregar una diagonal
        mov BX, [handleCatalogFile]
		mov AH, 40
		mov CH, 00
		mov CL, 01
		mov DX, offset diagonal
        int 21

        ; AGREGANDO MES
        mov ah, 2A
        int 21
        xor ax, ax
        mov al, dh
        call numAcadena
        ; ESCRIBIENDO MES
        mov BX, [handleCatalogFile]
		mov AH, 40
		mov CH, 00
		mov CL, 02
		mov DX, offset numero + 03
        int 21

         ; agregar una diagonal
        mov BX, [handleCatalogFile]
		mov AH, 40
		mov CH, 00
		mov CL, 01
		mov DX, offset diagonal
        int 21

         ; AGREGANDO AÑO
        mov ah, 2A
        int 21
        xor ax, ax
        mov ax, cx
        call numAcadena
        ; ESCRIBIENDO AÑO
        mov BX, [handleCatalogFile]
		mov AH, 40
		mov CH, 00
		mov CL, 04
		mov DX, offset numero + 01
        int 21






  
        writehtmlCatalog:
        ;encabezado del html
		mov BX, [handleCatalogFile]
		mov AH, 40
		mov CH, 00
		mov CL, [tam_encabezado_html]
		mov DX, offset encabezado_html
        int 21
        ; inicializacion tabla
        mov BX, [handleCatalogFile]
		mov AH, 40
		mov CH, 00
		mov CL, [tam_inicializacion_tabla]
		mov DX, offset inicializacion_tabla
        int 21
        ; ; LOOP ENTRE TODOS LOS PRODUCTOS
        loopProdcutsCatalog:
           
            mov ah, 3f
            mov bx, [handleprodFile]
            mov cx, 2E
            mov dx, offset codigoProducto
            int 21
            cmp ax, 0000
            je exitProductCatalogLoop
            ;printString lel1
            ; abrir etiqueta tr
            mov BX, [handleCatalogFile]
            mov AH, 40
            mov CH, 00
            mov CL, 04
            mov DX, offset tr_html
            int 21
            ; abrir etiqueta td codigo producto
            mov BX, [handleCatalogFile]
            mov AH, 40
            mov CH, 00
            mov CL, 04
            mov DX, offset td_html
            int 21
            ; Escribir codigo de producto
            mov BX, [handleCatalogFile]
            mov AH, 40
            mov CH, 00
            mov CL, 04
            mov DX, offset codigoProducto
            int 21
            ; Escribir cierre de td del producto
            mov BX, [handleCatalogFile]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            mov DX, offset tdc_html
            int 21
             ; abrir etiqueta td codigo producto
            mov BX, [handleCatalogFile]
            mov AH, 40
            mov CH, 00
            mov CL, 04
            mov DX, offset td_html
            int 21
            
            ; Escribir desc del producto
            mov BX, [handleCatalogFile]
            mov AH, 40
            mov CH, 00
            mov CL, 20
            mov DX, offset descProducto
            int 21
            ; Escribir cierre de td del producto
            mov BX, [handleCatalogFile]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            mov DX, offset tdc_html
            int 21
             ; abrir etiqueta td codigo producto
            mov BX, [handleCatalogFile]
            mov AH, 40
            mov CH, 00
            mov CL, 04
            mov DX, offset td_html
            int 21
            ; Escribir precio del producto
            mov BX, [handleCatalogFile]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            mov DX, offset productPrice
            int 21
            ; Escribir cierre de td del producto
            mov BX, [handleCatalogFile]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            mov DX, offset tdc_html
            int 21
             ; abrir etiqueta td codigo producto
            mov BX, [handleCatalogFile]
            mov AH, 40
            mov CH, 00
            mov CL, 04
            mov DX, offset td_html
            int 21
            ; Escribir unidades del producto
            mov BX, [handleCatalogFile]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            mov DX, offset productUnits
            int 21

            ; Escribir cierre de td del producto
            mov BX, [handleCatalogFile]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            mov DX, offset tdc_html
            int 21
            ; Escribir cierre de tr del producto
            mov BX, [handleCatalogFile]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            mov DX, offset trc_html
            int 21

        
        jmp loopProdcutsCatalog

        exitProductCatalogLoop:
            ; escribir cierre de tabla
     
            mov BX, [handleCatalogFile]
            mov AH, 40
            mov CH, 00
            mov CL, tam_cierre_tabla
            mov DX, offset cierre_tabla
            int 21

            ; cerrar el archivo
            mov bx, [handleCatalogFile]
            mov ah, 3E
            int 21

        jmp displayToolsMenu

; REPORTE PRODUCTOS SIN EXISTENCIAS ------------------------------------------------------------
  generateFALTA:
        ; abrimos el prod.bin
            mov al, 2
            mov ah, 3d
            mov dx, offset pathProductFile
            int 21
            mov [handleprodFile], ax


        
        ; creamos el archivo
        mov ah, 3c
        mov cx, 0
        mov dx, offset pathFalta
        int 21
        mov [handleFaltaFile], ax
        ; agregamos fecha y hora
        ; agregando hora
        ;CH = hours
        ;CL = minutes
        mov ah, 2C
        int 21
        xor ax, ax
        mov al, ch
        call numAcadena
        ; ESCRIBIENDO HORA
        mov BX, [handleFaltaFile]
		mov AH, 40
		mov CH, 00
		mov CL, 02
		mov DX, offset numero + 03
        int 21


        ; agregamos los dos puntos 
            mov BX, [handleFaltaFile]
            mov AH, 40
            mov CH, 00
            mov CL, 01
            mov DX, offset dos_puntos
            int 21



        ; agregando minuto
        ;CH = hours
        ;CL = minutes
        mov ah, 2C
        int 21
        xor ax, ax
        mov al, cl
        call numAcadena
        ; ESCRIBIENDO MINUTO
        mov BX, [handleFaltaFile]
		mov AH, 40
		mov CH, 00
		mov CL, 02
		mov DX, offset numero + 03
        int 21


        ; agregamos unos espacios
        mov BX, [handleFaltaFile]
        mov AH, 40
        mov CH, 00
        mov CL, 03
        mov DX, offset spaces
        int 21

        ;AGREGANDO FECHA
        ; AGREGANDO DIA
        mov ah, 2A
        int 21
        xor ax, ax
        mov al, dl
        call numAcadena
        ; ESCRIBIENDO DIA
        mov BX, [handleFaltaFile]
		mov AH, 40
		mov CH, 00
		mov CL, 02
		mov DX, offset numero + 03
        int 21
        ; agregar una diagonal
        mov BX, [handleFaltaFile]
		mov AH, 40
		mov CH, 00
		mov CL, 01
		mov DX, offset diagonal
        int 21

        ; AGREGANDO MES
        mov ah, 2A
        int 21
        xor ax, ax
        mov al, dh
        call numAcadena
        ; ESCRIBIENDO MES
        mov BX, [handleFaltaFile]
		mov AH, 40
		mov CH, 00
		mov CL, 02
		mov DX, offset numero + 03
        int 21

         ; agregar una diagonal
        mov BX, [handleFaltaFile]
		mov AH, 40
		mov CH, 00
		mov CL, 01
		mov DX, offset diagonal
        int 21

         ; AGREGANDO AÑO
        mov ah, 2A
        int 21
        xor ax, ax
        mov ax, cx
        call numAcadena
        ; ESCRIBIENDO AÑO
        mov BX, [handleFaltaFile]
		mov AH, 40
		mov CH, 00
		mov CL, 04
		mov DX, offset numero + 01
        int 21






  
        writehtmlFalta:
        ;encabezado del html
		mov BX, [handleFaltaFile]
		mov AH, 40
		mov CH, 00
		mov CL, [tam_encabezado_html]
		mov DX, offset encabezado_html
        int 21
        ; inicializacion tabla
        mov BX, [handleFaltaFile]
		mov AH, 40
		mov CH, 00
		mov CL, [tam_inicializacion_tabla]
		mov DX, offset inicializacion_tabla
        int 21
        ; ; LOOP ENTRE TODOS LOS PRODUCTOS
        loopProdcutsFalta:
            
           
            mov ah, 3f
            mov bx, [handleprodFile]
            mov cx, 2E
            mov dx, offset codigoProducto
            int 21
            cmp ax, 0000
            je exitProductFaltaLoop

            mov di, offset productUnits
            call cadenaAnum
            cmp ax, 0000
            jne loopProdcutsFalta
            
            ; abrir etiqueta tr
            mov BX, [handleFaltaFile]
            mov AH, 40
            mov CH, 00
            mov CL, 04
            mov DX, offset tr_html
            int 21
            ; abrir etiqueta td codigo producto
            mov BX, [handleFaltaFile]
            mov AH, 40
            mov CH, 00
            mov CL, 04
            mov DX, offset td_html
            int 21
            ; Escribir codigo de producto
            mov BX, [handleFaltaFile]
            mov AH, 40
            mov CH, 00
            mov CL, 04
            mov DX, offset codigoProducto
            int 21
            ; Escribir cierre de td del producto
            mov BX, [handleFaltaFile]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            mov DX, offset tdc_html
            int 21
             ; abrir etiqueta td codigo producto
            mov BX, [handleFaltaFile]
            mov AH, 40
            mov CH, 00
            mov CL, 04
            mov DX, offset td_html
            int 21
            
            ; Escribir desc del producto
            mov BX, [handleFaltaFile]
            mov AH, 40
            mov CH, 00
            mov CL, 20
            mov DX, offset descProducto
            int 21
            ; Escribir cierre de td del producto
            mov BX, [handleFaltaFile]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            mov DX, offset tdc_html
            int 21
             ; abrir etiqueta td codigo producto
            mov BX, [handleFaltaFile]
            mov AH, 40
            mov CH, 00
            mov CL, 04
            mov DX, offset td_html
            int 21
            ; Escribir precio del producto
            mov BX, [handleFaltaFile]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            mov DX, offset productPrice
            int 21
            ; Escribir cierre de td del producto
            mov BX, [handleFaltaFile]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            mov DX, offset tdc_html
            int 21
             ; abrir etiqueta td codigo producto
            mov BX, [handleFaltaFile]
            mov AH, 40
            mov CH, 00
            mov CL, 04
            mov DX, offset td_html
            int 21
            ; Escribir unidades del producto
            mov BX, [handleFaltaFile]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            mov DX, offset productUnits
            int 21

            ; Escribir cierre de td del producto
            mov BX, [handleFaltaFile]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            mov DX, offset tdc_html
            int 21
            ; Escribir cierre de tr del producto
            mov BX, [handleFaltaFile]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            mov DX, offset trc_html
            int 21

        
        jmp loopProdcutsFalta

        exitProductFaltaLoop:
            ; escribir cierre de tabla
     
            mov BX, [handleFaltaFile]
            mov AH, 40
            mov CH, 00
            mov CL, tam_cierre_tabla
            mov DX, offset cierre_tabla
            int 21

            ; cerrar el archivo
            mov bx, [handleFaltaFile]
            mov ah, 3E
            int 21

        jmp displayToolsMenu  

    ; GENERADOR DE REPORTE ALFABETICO //////////////////////////////////////////////////////////////////
    generateABC:
       

       ; creamos el archivo
        mov ah, 3c
        mov cx, 0
        mov dx, offset pathABCFile
        int 21
        mov [handleABCFile], ax
        ; agregamos fecha y hora
        ; agregando hora
        ;CH = hours
        ;CL = minutes
        mov ah, 2C
        int 21
        xor ax, ax
        mov al, ch
        call numAcadena
        ; ESCRIBIENDO HORA
        mov BX, [handleABCFile]
		mov AH, 40
		mov CH, 00
		mov CL, 02
		mov DX, offset numero + 03
        int 21



        ; agregamos los dos puntos 
            mov BX, [handleABCFile]
            mov AH, 40
            mov CH, 00
            mov CL, 01
            mov DX, offset dos_puntos
            int 21



        ; agregando minuto
        ;CH = hours
        ;CL = minutes
        mov ah, 2C
        int 21
        xor ax, ax
        mov al, cl
        call numAcadena
        ; ESCRIBIENDO MINUTO
        mov BX, [handleABCFile]
		mov AH, 40
		mov CH, 00
		mov CL, 02
		mov DX, offset numero + 03
        int 21


        ; agregamos unos espacios
        mov BX, [handleABCFile]
        mov AH, 40
        mov CH, 00
        mov CL, 03
        mov DX, offset spaces
        int 21

        ;AGREGANDO FECHA
        ; AGREGANDO DIA
        mov ah, 2A
        int 21
        xor ax, ax
        mov al, dl
        call numAcadena
        ; ESCRIBIENDO DIA
        mov BX, [handleABCFile]
		mov AH, 40
		mov CH, 00
		mov CL, 02
		mov DX, offset numero + 03
        int 21
        ; agregar una diagonal
        mov BX, [handleABCFile]
		mov AH, 40
		mov CH, 00
		mov CL, 01
		mov DX, offset diagonal
        int 21

        ; AGREGANDO MES
        mov ah, 2A
        int 21
        xor ax, ax
        mov al, dh
        call numAcadena
        ; ESCRIBIENDO MES
        mov BX, [handleABCFile]
		mov AH, 40
		mov CH, 00
		mov CL, 02
		mov DX, offset numero + 03
        int 21

         ; agregar una diagonal
        mov BX, [handleABCFile]
		mov AH, 40
		mov CH, 00
		mov CL, 01
		mov DX, offset diagonal
        int 21

         ; AGREGANDO AÑO
        mov ah, 2A
        int 21
        xor ax, ax
        mov ax, cx
        call numAcadena
        ; ESCRIBIENDO AÑO
        mov BX, [handleABCFile]
		mov AH, 40
		mov CH, 00
		mov CL, 04
		mov DX, offset numero + 01
        int 21

  
        writehtmlABC:
        ;encabezado del html
		mov BX, [handleABCFile]
		mov AH, 40
		mov CH, 00
		mov CL, [tam_encabezado_html]
		mov DX, offset encabezado_html
        int 21
        ; inicializacion tabla
        mov BX, [handleABCFile]
		mov AH, 40
		mov CH, 00
		mov CL, [tam_inicializacion_tablaABC]
		mov DX, offset inicializacion_tablaABC
        int 21
        ; ; LOOP ENTRE TODAS LAS LETRAS



         mov [letraMin], 61 ; caracter a
         mov [letraMay], 41 ; caracter A
         mov iterableABC, 0
         mov [contadorLetra], 0000

        


        ForLetras:
            mov ax, 0000
            mov [contadorLetra], ax
            cmp iterableABC, 1A
            jge SalirForLetras

             ; abrimos el prod.bin
            mov al, 2
            mov ah, 3d
            mov dx, offset pathProductFile
            int 21
            mov [handleprodFile], ax

             

            ; recorremos cada elemento del archivo de productos
            loopProdcutsABC:
                mov ah, 3F
                mov bx, [handleprodFile]
                mov cx, 2E
                mov dx, offset codigoProducto
                int 21
                cmp ax, 0000
                je ContinueForLetras
                ; comparamos si empieza con la letra actual del loop

                xor ax, ax
                mov al, descProducto[0]
                cmp [letraMin], al
                je increaseLetterCount
                cmp [letraMay], al
                je increaseLetterCount
                jmp continueReading
                
            
                increaseLetterCount:
                    inc contadorLetra 
                    jmp loopProdcutsABC

                continueReading:
                    
                    jmp loopProdcutsABC


    
        ContinueForLetras:
            ;cerramos el archivo.bin para luego reabrirlo luego
            mov bx, [handleprodFile]
            mov ah, 3E
            int 21
            ;continue


            ; abrir etiqueta tr
            mov BX, [handleABCFile]
            mov AH, 40
            mov CH, 00
            mov CL, 04
            mov DX, offset tr_html
            int 21

             ; abrir etiqueta td
            mov BX, [handleABCFile]
            mov AH, 40
            mov CH, 00
            mov CL, 04
            mov DX, offset td_html
            int 21

            ; escribir letra
            mov BX, [handleABCFile]
            mov AH, 40
            mov CH, 00
            mov CL, 01
            xor dx, dx
            mov dx, offset letraMay
            int 21

             ; cerrar etiqueta td
            mov BX, [handleABCFile]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            mov DX, offset tdc_html
            int 21



            ;------------------
               ;abrir etiqueta td
            mov BX, [handleABCFile]
            mov AH, 40
            mov CH, 00
            mov CL, 04
            mov DX, offset td_html
            int 21

            ; escribir numero



            mov ax, [contadorLetra]
            cmp ax, 0000
            je escribirCeros




            call numAcadena

            mov BX, [handleABCFile]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            xor dx, dx
            mov dx, offset numero
            int 21
            jmp cerrarTD

            escribirCeros:
            mov BX, [handleABCFile]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            xor dx, dx
            mov dx, offset ceritos
            int 21

            cerrarTD:

             ; cerrar etiqueta td
            mov BX, [handleABCFile]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            mov DX, offset tdc_html
            int 21

            
            ; Escribir cierre de tr del producto
            mov BX, [handleABCFile]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            mov DX, offset trc_html
            int 21
          



            inc letraMin
            inc letraMay
            inc iterableABC
            jmp ForLetras

        SalirForLetras:
         
        ; AHORA LO MISMO PERO EN VEZ DE NUMEROS, LETRAS
        ; ; LOOP ENTRE TODOS LOS NUMEROS

        mov [letraMin], 30 ; caracter 0
        mov iterableABC, 0


        ForNums:
            mov ax, 0000
            mov [contadorLetra], ax
            cmp iterableABC, 0A
            jge SalirForNums

             ; abrimos el prod.bin
            mov al, 2
            mov ah, 3d
            mov dx, offset pathProductFile
            int 21
            mov [handleprodFile], ax

             

            ; recorremos cada elemento del archivo de productos
            loopProdcutsABC2:
                mov ah, 3F
                mov bx, [handleprodFile]
                mov cx, 2E
                mov dx, offset codigoProducto
                int 21
                cmp ax, 0000
                je ContinueForNums
                ; comparamos si empieza con la letra actual del loop

                xor ax, ax
                mov al, descProducto[0]
                cmp [letraMin], al
                je increaseNumCount

                jmp continueReading2
                
            
                increaseNumCount:
                    inc contadorLetra 
                    jmp loopProdcutsABC2

                continueReading2:
                    
                    jmp loopProdcutsABC2


    
        ContinueForNums:
            ;cerramos el archivo.bin para luego reabrirlo luego
            mov bx, [handleprodFile]
            mov ah, 3E
            int 21
            ;continue


            ; abrir etiqueta tr
            mov BX, [handleABCFile]
            mov AH, 40
            mov CH, 00
            mov CL, 04
            mov DX, offset tr_html
            int 21

             ; abrir etiqueta td
            mov BX, [handleABCFile]
            mov AH, 40
            mov CH, 00
            mov CL, 04
            mov DX, offset td_html
            int 21

            ; escribir letra
            mov BX, [handleABCFile]
            mov AH, 40
            mov CH, 00
            mov CL, 01
            xor dx, dx
            mov dx, offset letraMin
            int 21

             ; cerrar etiqueta td
            mov BX, [handleABCFile]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            mov DX, offset tdc_html
            int 21



            ;------------------
               ;abrir etiqueta td
            mov BX, [handleABCFile]
            mov AH, 40
            mov CH, 00
            mov CL, 04
            mov DX, offset td_html
            int 21

            ; escribir numero



            mov ax, [contadorLetra]
            cmp ax, 0000
            je escribirCeros2




            call numAcadena

            mov BX, [handleABCFile]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            xor dx, dx
            mov dx, offset numero
            int 21
            jmp cerrarTD2

            escribirCeros2:
            mov BX, [handleABCFile]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            xor dx, dx
            mov dx, offset ceritos
            int 21

            cerrarTD2:

             ; cerrar etiqueta td
            mov BX, [handleABCFile]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            mov DX, offset tdc_html
            int 21

            
            ; Escribir cierre de tr del producto
            mov BX, [handleABCFile]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            mov DX, offset trc_html
            int 21
          



            inc letraMin
            inc iterableABC
            jmp ForNums

        SalirForNums:
         ; escribir cierre de tabla
            mov BX, [handleABCFile]
            mov AH, 40
            mov CH, 00
            mov CL, tam_cierre_tabla
            mov DX, offset cierre_tabla
            int 21

            ; cerrar el archivo
            mov bx, [handleABCFile]
            mov ah, 3E
            int 21


        jmp displayToolsMenu


    displaySalesMenu:
        printString salesTitle
        printString newLine
        xor si, si
        mov [iterableABC], 0000

        mov [montoTotalVenta], 0000
        forItems:
        mov [puntero_temp], 0000

            clearVentaInput
            cmp iterableABC, 0A ; TODO CAMBIAR ITERACIONES A 10
            je exitForItems
            ; ADENTRO DE LAS 10 ITERACIONES
                askForProductCode2:
                printString inserProductCode
                saveBufferedInput inputBuffer
                printString newLine
                bufferPrinter inputBuffer
                xor si, si
                inc si
                mov al, inputBuffer[si]
                cmp al, 0 ; verificamos que el input sea distinto de cero
                je askForProductCode2
                cmp al, 05 ; verificamos que el input sea de 4 caracteres como maximo
                jb saveProductCode2
                jmp askForProductCode2
            saveProductCode2:
                xor si, si
                inc si
                mov bl, inputBuffer[si] ; guardamos el size del input
                inc si
                ; nos movemos al byte que contiene el primer caracter de la entrada
                xor di, di
                mov trueCond, 1
                ; guardamos cada caracter en su respectiva variable
                
            forProductCode2:
                cmp di, 04
                je exitforProductCode2
                mov al, inputBuffer[si]
                cmp al, 0D
                je exitforProductCode2
                mov ventaCodigoProducto[di], al
                
                inc di
                inc si
                jmp forProductCode2



            exitforProductCode2:
                xor di, di


                CFOR:
                    cmp di, 05
                    jge SALIRFOR
                    cmp di, 01
                    je comp1
                    cmp di, 02
                    je comp2
                     cmp di, 03
                    je comp3
                    cmp di, 04
                    je comp4


                    comp1:
                        cmp ventaCodigoProducto[di], 'f'
                        jne SALIRFOR
                        inc di



                    comp2:
                        cmp ventaCodigoProducto[di], 'i'
                        jne SALIRFOR
                        inc di

                    comp3:
                        cmp ventaCodigoProducto[di], 'n'
                        jne SALIRFOR
                        inc di

                    comp4:
                        cmp ventaCodigoProducto[di], 0D
                        jne displayUserMenu


                    continueFIN:
                    inc di
                    jmp CFOR


                SALIRFOR:

            
            askForProductUnits2:
        printString inserProductUnits
        saveBufferedInput inputBuffer
        printString newLine
        bufferPrinter inputBuffer
        xor si, si
        inc si
        mov al, inputBuffer[si]
        cmp al, 0 ; verificamos que el input sea distinto de cero
        je askForProductUnits2
        cmp al, 05 ; verificamos que el input sea de 4 caracteres como maximo
        jb saveProductUnits2
        jmp askForProductUnits2
    saveProductUnits2:
        xor si, si
        inc si
        mov bl, inputBuffer[si] ; guardamos el size del input
        inc si
        ; nos movemos al byte que contiene el primer caracter de la entrada
        xor di, di
        mov trueCond, 1
        ; guardamos cada caracter en su respectiva variable
    forProductUnits2:
        cmp di, 05
        je exitforProductUnits2
        mov al, inputBuffer[si]
        cmp al, 0D
        je exitforProductUnits2
        mov venaUnitsString[di], al
        
        inc di
        inc si
        jmp forProductUnits2


    exitforProductUnits2:

    ; limpiamos si
    xor si, si
    mov condition1, 0
    RegexloopProductUnits2:
        cmp si, 5
        je exitRegexLoopProductUnits2

        cmp venaUnitsString[si], 0
        je continueRegexloopProductUnits2
        ; verificamos que cada caracter del codigo sea letra mayus o numero
        ; condicion: if[ (caracter >= minLetra && caracter <= maxletra) || (caracter >= minNum && caracter <= maxNum) ]
        ; minletra = 41 = A(ascii) |  maxletra = 5A = Z(ascii)
        ; minNum = 30 = 0(ascii) |  maxNum = 39 = 9(ascii)


        FirstConditionRegexloopProductUnits2:
        ; printString lel1
        ; printString newLine
        mov al, venaUnitsString[si]
        cmp al, 30
        jl clearFirstConditionRegexloopProductUnits2
        cmp al, 39
        jg clearFirstConditionRegexloopProductUnits2
        mov condition1, 1
        jmp ComparationConditionRegexloopProductUnits2

        clearFirstConditionRegexloopProductUnits2:
        mov condition1, 0


;------------------------------------------------------------------------------------------------
        ComparationConditionRegexloopProductUnits2:
        mov bl, condition1

        cmp bl, 0
        je askForProductUnits2

        continueRegexloopProductUnits2:
       
            inc si
            jmp RegexloopProductUnits2
        exitRegexLoopProductUnits2:


             ; verificando que el número sea menor a 256
        xor ax, ax
        mov di, offset venaUnitsString
        call cadenaAnum

        mov [ventaUnidades], ax
        
        cmp [ventaUnidades], 100
        ja  askForProductUnits2
        ; Verificando que el producto existe
        ; abrimos el prod.bin
            mov al, 2
            mov ah, 3d
            mov dx, offset pathProductFile
            int 21
            mov [handleprodFile], ax
              ; ; LOOP ENTRE TODOS LOS PRODUCTOS
        loopProdcutsSale:
           
            mov ah, 3f
            mov bx, [handleprodFile]
            mov cx, 2E
            mov dx, offset codigoProducto
            int 21
            cmp ax, 0000
            je productExistentVerifierExitFailed
            mov dx, [puntero_temp]
            add dx, 2E
            mov [puntero_temp], dx
            ; comparamos el producto leido con el producto ingresado
                    xor si, si


                productExistentVerifier:
                    cmp si, 04
                    jge productExistentVerifierExit
                    mov al, codigoProducto[si]
                    cmp al, ventaCodigoProducto[si]
                    jne loopProdcutsSale
                    

                    
                    inc si
                    jmp productExistentVerifier

                productExistentVerifierExit:
                    

                    printString prodFound
                    printString newLine

                     ; guardando precio del producto
                    mov di, offset productPrice
                    call cadenaAnum
                    mov [numPrice], ax


                    ; guardando las unidades de los productos para luego hacer la resta
                    mov di, offset productUnits
                    call cadenaAnum
                    mov [numUnits], ax
                    ; guardando la cantidad de unidades que ingreso el usuario para la venta
                    mov di, offset venaUnitsString
                    call cadenaAnum
                    mov [ventaUnidades], ax

                    mov ax, numUnits
                    cmp ax, ventaUnidades
                    jae exitProductSale


                    printString unidadesInsuficientes
                    printString newLine



                    jmp forItems




                 


                productExistentVerifierExitFailed:
                printString prodNotFounc
                printString newLine
                jmp forItems


            jmp loopProdcutsSale
        exitProductSale:
        
        
        ; preparando la data para ser escrita
        mov ah, 2C
        int 21
        mov [ventaHora], ch
        mov [ventaMin], cl

        mov ah, 2A
        int 21
        mov [ventaDia], dl
        mov [ventaMes], dh
        mov [ventaAnio], cx

        xor ax, ax
        mov di, offset venaUnitsString
        call cadenaAnum

        mov [ventaUnidades], ax
        
        cmp [ventaUnidades], 100
        ja  askForProductUnits2

       
  

      ;----------------------------------------------------------------
        searchFile pathVentas
        jc prodFileCreatorVentas
        mov [handleVENTASFile], ax

        
        ; mover puntero al final
        mov cx, 00
        mov dx, 00
        mov al, 2
        mov ah, 42
        mov bx, [handleVENTASFile]
        int 21

        ; escribir la venta
        mov bx, [handleVENTASFile]
        mov cx, 0A
        mov dx, offset ventaDia  
        mov ah, 40
        int 21

         
         ; escribir unidades
        mov bx, [handleVENTASFile]
        mov cx, 02
        mov dx, offset ventaUnidades  
        mov ah, 40
        int 21
        jmp continueIterations

        


        prodFileCreatorVentas:
        mov CX, 0000
		mov DX, offset pathVentas
		mov AH, 3c
		int 21
        mov [handleVENTASFile], ax
         ; escribir la venta
        mov bx, [handleVENTASFile]
        mov cx, 0A
        mov dx, offset ventaDia  
        mov ah, 40
        int 21


         ; escribir unidades
        mov bx, [handleVENTASFile]
        mov cx, 02
        mov dx, offset ventaUnidades  
        mov ah, 40
        int 21



        
        continueIterations:
                    ; aca escribir el monto
                    printString montoOutput
                    mov ax, [ventaUnidades]
                    mov bx, [numPrice]
                    mul bx
                    mov cx, [montoTotalVenta]
                    add ax, cx



                    ; luego de hacer la suma
                    mov [montoTotalVenta], ax
                    mov ax, [montoTotalVenta]
                    call numAcadena

                   ; escribir monto total
                    mov bx, [handleVENTASFile]
                    mov cx, 02
                    mov dx, offset montoTotalVenta  
                    mov ah, 40
                    int 21

                            ; cerramos el archivo
                    mov ah,  3E
                    mov bx, [handleVENTASFile]
                    int 21


                  

                    

                    ; imprimimos el monto que se lleva
                    
                    mov bx, 01
                    mov di, offset numero ; guardamos la direccion del primer byte del buffer
                    xor ch, ch
                    mov cl, 05
                    mov dx, di  
                    mov ah, 40
                    int 21
                    printString newLine

                    ; restando unidades
                    mov ax, [numUnits]
                    sub ax, [ventaUnidades]
                    call numAcadena

                  
                    
                    


                    ; nos posicionamos en el producto correcto

                    mov dx, [puntero_temp]
                    sub dx, 05
                    mov [puntero_temp], dx
                    mov cx, 0000
                    mov bx, [handleprodFile]
                    mov al, 0
                    mov ah, 42
                    int 21


                    ; limpiamos el numero
                    
                     xor si, si


                     cleanNumbers:
                        cmp si, 05
                        jge exitCleanNumbers

                        cmp numero[si], 30
                        jne continueCleanNumbers
                        mov numero[si],0000


                        continueCleanNumbers:
                        inc si
                        jmp cleanNumbers


                     exitCleanNumbers:

                       ; invertimos el numero 
                     xor si, si
                    


                     findUnequalToZerofor:
                        cmp si, 05
                        je exitfindUnequalToZeroFor
                        cmp numero[si], 0000
                        je continuefindUnequalToZero
                        mov [contadorLetra], si
                        jmp exitfindUnequalToZeroFor 
                       

                        
                        continuefindUnequalToZero:
                        inc si
                        jmp findUnequalToZerofor


                     exitfindUnequalToZeroFor:

                    cmp [contadorLetra], 05
                    jne inversor
                    mov al, numero[5]
                    mov numeroInvert[0],al
                    jmp exitINverter


                    
                    inversor:
                    xor si,si
                    mov si, [contadorLetra]
                    xor di, di
                     inverter:
                        cmp si, 05
                        je exitINverter
                        mov al, numero[si]
                        mov numeroInvert[di], al
                        
                       

                        
                       
                        inc si
                        inc di
                        jmp inverter


                     exitINverter:


                    
                    cmp numeroInvert[0], '6'
                    jne noescribirCeritos
                    cmp numeroInvert[1], '5'
                    jne noescribirCeritos
                    cmp numeroInvert[2], '5'
                    jne noescribirCeritos
                    cmp numeroInvert[3], '3'
                    jne noescribirCeritos
                    cmp numeroInvert[4], '6'
                    jne noescribirCeritos
                    jmp escribirceritos

                    ; escribimos las unidades
                    noescribirCeritos:
                        mov cx, 05
                        mov dx, offset numeroInvert
                        mov ah, 40
                        int 21
                        jmp checkpoint2

                    escribirceritos:
                        mov cx, 05
                        mov dx, offset ceritos
                        mov ah, 40
                        int 21

                        


                    checkpoint2:
                    ; limpiamos el numero para tener 0s

                        mov bx, [handleprodFile]
                        mov ah, 3E
                        int 21
                    
                     xor si, si


                     cleanNumbers2:
                        cmp si, 05
                        jge exitCleanNumbers2

                       
                        mov numero[si], 30
                        mov numeroInvert[si], 0000


                        continueCleanNumbers2:
                        inc si
                        jmp cleanNumbers2


                     exitCleanNumbers2:






                    inc iterableABC
                    jmp forItems
                    


                    inc iterableABC
                    jmp forItems


    exitForItems:


        jmp displayUserMenu



; SUBRUTINAS---------------------------------------------------------------------------------


; SUBRUTINAS---------------------------------------------------------------------------------
cadenaAnum:
		mov AX, 0000    ; inicializar la salida
		mov CX, 0005    ; inicializar contador
		;;
seguir_convirtiendo:
		mov BL, [DI]
		cmp BL, 00
		je retorno_cadenaAnum
        cmp BL, 30
		je retorno_cadenaAnum
		sub BL, 30      ; BL es el valor numérico del caracter
		mov DX, 000a
		mul DX          ; AX * DX -> DX:AX
		mov BH, 00
		add AX, BX 
		inc DI          ; puntero en la cadena
		loop seguir_convirtiendo
retorno_cadenaAnum:
		ret
 ;-------------------------------------------------------------------------------------------------        
numAcadena:
		mov CX, 0005
		mov DI, offset numero
ciclo_poner30s:
		mov BL, 30
		mov [DI], BL
		inc DI
		loop ciclo_poner30s
		;; tenemos '0' en toda la cadena
		mov CX, AX    ; inicializar contador
		mov DI, offset numero
		add DI, 0004
		;;
ciclo_convertirAcadena:
		mov BL, [DI]
		inc BL
		mov [DI], BL
		cmp BL, 3a
		je aumentar_siguiente_digito_primera_vez
		loop ciclo_convertirAcadena
		jmp retorno_convertirAcadena
aumentar_siguiente_digito_primera_vez:
		push DI
aumentar_siguiente_digito:
		mov BL, 30     ; poner en '0' el actual
		mov [DI], BL
		dec DI         ; puntero a la cadena
		mov BL, [DI]
		inc BL
		mov [DI], BL
		cmp BL, 3a
		je aumentar_siguiente_digito
		pop DI         ; se recupera DI
		loop ciclo_convertirAcadena
retorno_convertirAcadena:
		ret

        



    exit:
   
    .exit

    main ENDP




end main


