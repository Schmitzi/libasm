; === ft_strdup ===
;
; The ft_strdup() function returns a pointer to a new string which is a duplicate of the string given
; In c, malloc is called to allocate memory.pointer
;
; Length of the input string is stored in 'rcx'
; Pointer to output string in "rax"
;
; According to the System V x86-64 calling convention:
; Caller-saved registers (rax, rcx, rdx, rsi, rdi, r8-r11):
; - The callee (function being called) is allowed to clear these
; - The caller (you) must save them before calling if you need them
; Callee-saved registers (rbx, rbp, r12-r15):
; - The callee must preserve these
; - The caller can assume they'll survive the function call unchanged

section .text
    extern malloc
    global ft_strdup

ft_strdup:
    push    r12             ; Save callee-saved registers
    push    rbx
    sub     rsp, 8          ; Align stack (2 pushes = 16 bytes, need 8 more)
    
    mov     r12, rdi        ; Save original pointer
    xor     rcx, rcx        ; Length counter
    jmp     .len

.len:
    cmp     byte [rdi], 0   ; Check for null terminator
    je      .malloc
    inc     rdi
    inc     rcx
    jmp     .len

.malloc:
    mov     rdi, rcx
    inc     rdi             ; len + 1 for null terminator
    call    malloc WRT ..plt
    test    rax, rax        ; Check if malloc failed
    jz      .cleanup        ; Return NULL if malloc failed
    
    mov     r8, rax         ; Destination pointer for copying
    jmp     .loop

.loop:
    cmp     rcx, 0
    je      .done
    mov     bl, [r12]       ; Now safe to use bl
    mov     [r8], bl
    inc     r8
    inc     r12
    dec     rcx
    jmp     .loop

.done:
    mov     byte [r8], 0    ; Null terminate
    ; rax already contains the malloc'd pointer

.cleanup:
    add     rsp, 8          ; Restore stack
    pop     rbx
    pop     r12
    ret
