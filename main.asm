include utils.asm


.model small
.stack
.data
    mensaje db "----------------------------------------------",10,"Universidad de San Carlos de Guatemala" ,10 , "Facultad de ingenieria", 10,"Escuela de Vacaciones",10,"Arquitectura de Computadoras y Ensambladores 1",10,"Diego Andres Huite Alvarez",10, "202003585",10, "----------------------------------------------" ,"$"
.code

    main PROC
    ;CARGANDO DE SEGMENTO DE DATOS A SEGMENTO DE CODIGO
    mov ax, @data
    mov ds, ax

    ; imprimir en consola
    printString mensaje
   
    .exit

    main ENDP

end main
