; === ft_strlen ===
;
; The ft_strlen() function calculates the length of the string passed.
;
; It returns the number of bytes in the string, excluding the '\0'

section .text
    global ft_strlen    ; Declare entry point

ft_strlen:
    xor rax, rax    ; Set counter to 0

.loop:
    cmp byte [rdi+rax], 0   ; Check str[rax] (str + i == str[i])
    je .done                ; If str[rax] == '\0', Jump to .done
    inc rax                 ; Increment counter++
    jmp .loop               ; Jump to .loop

.done:
    ret                     ; Rax contains the length already
