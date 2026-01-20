.model small
.stack 100h
.data
paragraph db "This is a full paragraph that will be printed as one block of text on the screen. ", \
             "It can contain multiple sentences, commas, and line breaks. ", \
             "DOS strings use thed '$' symbol to know where the string ends.$"
             decoy db "i am merely an uchiha ghost.$"    
msg_even db "0$"
msg_odd  db "1$"

key db 3          ; Caesar shift key for decoy
rotation db 1     ; number of bits to rotate
xor_key db 0AAh   ; XOR key for odd decoy
sub_table db 'ZYXWVUTSRQPONMLKJIHGFEDCBA'
sub_table_lower db 'zyxwvutsrqponmlkjihgfedcba'

paragraph_length equ ($ - paragraph)
decoy_length equ ($ - decoy)

.code
main proc
mov ax, @data
mov ds, ax


    ; ------------------------------
    ; Check paragraph length even/odd
    ; ------------------------------
    mov cx, paragraph_length
    
    test cx, 1
    jz even_length

    ; ------------------------------
    ; ODD: rotate + XOR decoy
    ; ------------------------------
    lea dx, msg_odd
    mov ah, 09h
    int 21h

    ; Rotate paragraph
   mov cx, paragraph_length-1   ; CX = counter for loop
mov cl, rotation             ; CL = bits to rotate
lea si, paragraph

rotate_loop:
    mov al, [si]
    rol al, cl
    mov [si], al
    inc si
    loop rotate_loop

; XOR paragraph
lea si, paragraph
mov cx, paragraph_length-1
mov cl, xor_key
xor_loop:
    mov al, [si]
    xor al, cl
    mov [si], al
    inc si
    loop xor_loop


    ; Print modified paragraph
    lea dx, paragraph
    mov ah, 09h
    int 21h

    jmp exit

even_length:
    ; ------------------------------
    ; EVEN: print 0, Caesar + Substitution
    ; ------------------------------
    lea dx, msg_even
    mov ah, 09h
    int 21h

    ; Caesar decoy on decoy string
    lea si, decoy
    mov cl, key
    mov cx, decoy_length
caesar_loop:
    mov al, [si]
    add al, cl
    mov [si], al
    inc si
    loop caesar_loop

    ; Substitution decoy on paragraph
; ------------------------------
; Substitution decoy on paragraph
; ----------------------
lea si, paragraph
mov cx, paragraph_length-1
sub_loop:
    mov al, [si]

    ; Uppercase letters
    cmp al, 'A'
    jb check_lower
    cmp al, 'Z'
    ja check_lower
    sub al, 'A'
    mov bx, offset sub_table
    add bx, ax
    mov al, [bx]   ; use AL consistently
    mov [si], al
    jmp next_char

check_lower:
    cmp al, 'a'
    jb next_char
    cmp al, 'z'
    ja next_char
    sub al, 'a'
    mov bx, offset sub_table_lower
    add bx, ax
    mov al, [bx]
    mov [si], al

next_char:
    inc si
    loop sub_loop



exit:
     lea dx, paragraph
    mov ah, 09h
    int 21h

    mov ah, 4Ch
    int 21h

main endp
end main

