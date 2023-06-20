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
    ; variables para archivos

    handlecredentialFile dw 0000
    pathcredentialFile db "asm\pra\PRAII.CON",0 ; la ruta donde asm tiene que buscar
.code

    main PROC
    ;CARGANDO DE SEGMENTO DE DATOS A SEGMENTO DE CODIGO
    mov ax, @data
    mov ds, ax

    ; imprimir el encabezado
    printString mensajeBienvenida


    mov AL, 02
		mov AH, 3d
		mov DX, offset pathcredentialFile
		int 21
		;; si no lo cremos
		jc  credentialFileFailed
		;; si abre escribimos
		jmp credentialFileSuccess
    
    credentialFileFailed:
        printString newLine
        printString credentialFileNotExistent
         jmp exit
    
    credentialFileSuccess:
        printString newLine
        printString credentialFileConfirmation
       
    

    

    
   exit:
    .exit

    main ENDP

end main
