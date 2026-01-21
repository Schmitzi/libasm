; === ft_strcpy ===
;
; The ft_strcpy() function will copy the strings tored at 'src' to 'dst'
; 

section .text
    global ft_strcpy

ft_strcpy:
    mov rax, rdi    ; Save inital 'dst' pointer to have dst[0] returned, not '\0'

.loop:
    mov dl, [rsi]   ; Copy src[i] to dl (lower 8 bits of rdx)
    mov [rdi], dl   ; Copy dl to dst[i]
    cmp dl, 0       ; Compare dl and '\0'
    je .done        ; Jump if Equal to .done
    inc rsi         ; Increment *src
    inc rdi         ; Increment *dst
    jmp .loop       ; Continue with .loop

.done:
    ret             ; Return dst[0] from rax

