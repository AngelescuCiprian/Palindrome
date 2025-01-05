.model small
.stack 100h
.data
    copie dw ?
    msj1 db 'Introduceti un numar:',10,"$"
    msj2 db 10,13,"Oglinditul numarului este ",10,"$"
    msjPalindrom db 10,13,"Numarul este palindrom$"
    msjNu db 10,13,"Numarul nu este palindrom$"
.code
    ;description
    citireNumar PROC
        mov ax,@data
        mov ds,ax 
        xor bx,bx
        push bx 
        mov cx,10
        citireCifra:
            mov ah,01h
            int 21h
            cmp al,13
                je numarCitit
            sub al,48
            mov bl,al
            pop ax
            mul cx
            add ax,bx
            push ax
        jmp citireCifra
    numarCitit:
        pop ax 
        ret
    citireNumar ENDP
    ;description
    afisareNumar PROC
        xor cx,cx 
        mov bx,10 
        descompunere:
            xor dx,dx 
            div bx 
            push dx 
            inc cx 
            cmp ax,0
                je afisare
            jmp descompunere
        afisare:
            mov ah,02h
            pop dx  
            add dx,48 
            int 21h
        loop afisare 
        ret
    afisareNumar ENDP
    ;description
    oglindit PROC
        xor bx,bx
        mov cx,10
        invers:
            xor dx,dx 
            div cx 
            mov copie,ax
            add bx,dx 
            mov ax,bx 
            mul cx 
            mov bx,ax 
            mov ax,copie
            cmp ax,0
                jne invers
        return:
            mov ax,bx
            ret
    oglindit ENDP

    main:
    mov ax,@data
    mov ds,ax
    mesaj MACRO msj
        mov ah,09h
        lea dx,msj
        int 21h
    ENDM
    mesaj msj1
    call citireNumar
    push ax
    call oglindit
    mov cx,10
    div cx
    mov bx,ax
    push bx
    mesaj msj2
    mov ax,bx 
    call afisareNumar
    pop ax
    pop bx
    cmp ax,bx
        je palindrom
    mesaj msjNu
    jmp end
    palindrom:
        mesaj msjPalindrom
        jmp end
    
    end:
    mov ah,4ch
    int 21h
    end main