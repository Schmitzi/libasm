; === ft_strcmp ===
;
; ft_strcmp() compares two strings, s1 and s2.
;
; The comparison is done using unsigned integers for safety.
;
; It returns an integer containing the result of said comparison like so:
;   - 0 if the two parameters are equal.
;   - The result of *s1 - *s2 (could be negative or positive).

section .text
    global ft_strcmp ; Declare entry point

ft_strcmp:
    xor rax, rax ; Zero the rax register out

.loop:
    mov al, [rsi]   ; Move *s2 to al (lower 8 bits of rax) 
    cmp al, [rdi]   ; Compare al to *s1
    jne .not_equal  ; Jump if Not Equal
    cmp al, 0       ; Compare al to '\0'
    je .equal       ; Jump if Equal
    inc rdi         ; Increment *rdi (rdi++)
    inc rsi         ; Increment *rsi (rsi++)
    jmp .loop       ; Continue with .loop

.not_equal:
    movzx rcx, al           ; Save *rsi as unsigned
    movzx rax, byte [rdi]   ; Save *rdi into rax as unsigned
    sub rax, rcx            ; Subtract rcx from rax
    jmp .done               ; Jump to .done

.equal:
    mov rax, 0  ; Clear the rax buffer  
    jmp .done   ; Jump to .done

.done:
    ret     ; Return rax
