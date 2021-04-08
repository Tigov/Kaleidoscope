TITLE Kaleidoscope         (Kaleidoscope.asm)
; Worked on by Viktor, Abed and Ty 
INCLUDE Irvine32.inc

.data

colour             DWORD ?
colours            DWORD 24 DUP (?)
stringBlank        DWORD 219 ,0


.code
randomColour PROC
    mov eax, 15
    call RandomRange
    CMP eax, 0
        JE bla
    CMP eax, 1
        JE blu
    CMP eax, 2
        JE gr
    CMP eax, 3
        JE cy
    CMP eax, 4
        JE rd
    CMP eax, 5
        JE mg
    CMP eax, 6
        JE br
    CMP eax, 7
        JE lg
    CMP eax, 8
        JE gy
    CMP eax, 9
        JE lb
    CMP eax, 10
        JE lgn
    CMP eax, 11
        JE lc
    CMP eax, 12
        JE lr
    CMP eax, 13
        JE lm
    CMP eax, 14
        JE yl
    CMP eax, 15
        JE wh
 
bla:
        mov eax, black
        call SetTextColor
        jmp end1
blu:
        mov eax, blue
        call SetTextColor
        jmp end1
gr:
        mov eax, green
        call SetTextColor
        jmp end1
cy:
        mov eax, cyan
        call SetTextColor
        jmp end1
rd:
        mov eax, red
        call SetTextColor
        jmp end1
mg:
        mov eax, magenta
        call SetTextColor
        jmp end1
br:
        mov eax, brown
        call SetTextColor
        jmp end1
lg:
        mov eax, lightGray
        call SetTextColor
        jmp end1
gy:
        mov eax, gray
        call SetTextColor
        jmp end1
lb:
        mov eax, lightBlue
        call SetTextColor
        jmp end1
lgn:
        mov eax, lightGreen
        call SetTextColor
        jmp end1
lc:
        mov eax, lightCyan
        call SetTextColor
        jmp end1
lr:
        mov eax, lightRed
        call SetTextColor
        jmp end1
lm:
        mov eax, lightMagenta
        call SetTextColor
        jmp end1
yl:
        mov eax, yellow
        call SetTextColor
        jmp end1
wh:
        mov eax, white
        call SetTextColor
        jmp end1

    end1:
        mov colour, eax

    ret
randomColour ENDP




generateLine PROC
    push esi ; making sure not to break anything when the proc ends
    push ecx
    push edx
    push eax

    mov esi, 0 ; set up the loop
    mov ecx, 12

    printLine: ; print out half of the random cubes and then print out that same line backwards for symmetry
        mov edx, OFFSET stringBlank
        mov eax, colours[esi] ; choose a colour from the colours array
        call SetTextColor
        call WriteString ; purely asthetic to print out the same color twice, makes the "box" twice as big and looks more pleasing
        call WriteString
        inc esi
        inc esi
        inc esi
        inc esi
    LOOP printLine

    mov esi, 44 ; access the last colour element that the above loop stops at and then go backwards
    mov ecx, 12

    printSymLine:
        mov edx, OFFSET stringBlank
        mov eax, colours[esi]
        call SetTextColor
        call WriteString ; purely asthetic to print out the same color twice, makes the "box" twice as big and looks more pleasing
        call WriteString
        dec esi
        dec esi
        dec esi
        dec esi
    LOOP printSymLine

    call crlf ; make a new line

    pop eax
    pop edx
    pop ecx
    pop esi


    ret
generateLine ENDP

createArray PROC
        push esi
        push ecx
        push eax

        mov        esi, 0
        mov        ecx, 12
        newArray:
            call    randomColour
            mov        colours[esi], eax
            add        esi, 4
        loop    newArray

        pop esi
        pop ecx
        pop eax
    ret
createArray ENDP


refreshK PROC
    push ebx
    push edx
    push eax
    push ecx
            mov ecx, 12
            mov bh, 0
            mov bl, 23
            generateLotsOfLines2:
mov eax, 5 ; Change how fast the colour changes
                call Delay
                mov dl, 1
                mov dh, bl
                call GoToXY
                call generateLine
                mov dl, 1
                mov dh, bh
                call GoToXY
                inc bh
                dec bl
                call generateLine
                call createArray
            LOOP generateLotsOfLines2
    pop ebx
    pop edx
    pop eax
    pop ecx
    ret
refreshK ENDP



main PROC
    call    Randomize
    mov        esi, 0
    mov        ecx, 12
    fillArray:
        call    randomColour
        mov        colours[esi], eax ; fill the colour array with different colours
        add        esi, 4
    loop    fillArray
    call createArray



    mov ecx, 12

   mov bh, 0
   mov bl, 23
    generateLotsOfLines:
        mov dl, 1
        mov dh, bl
        call GoToXY
        call generateLine
        mov dl, 1
        mov dh, bh
        call GoToXY
        inc bh
        dec bl
        call generateLine
        call createArray
    LOOP generateLotsOfLines
   
    mov bh, 0
    mov bl, 30
    call GoToXY

    mov eax, 10
    call Delay

    mov ecx, 12
    .while ecx > 0
        call refreshK
    .endw

    call Clrscr
 
    exit
main ENDP
END main
