; === ft_atoi_base ===
;
; the ft_atoi_base() function converts the given integer to its char
; counterpart based off of the given base.
;
; rax - Return value 
; rdi - String pointer
; rsi - Base
; r8  - Len of base
; r9  - Sign (1 or -1) 

section .text
    global ft_atoi_base
    extern ft_strlen

ft_atoi_base:
    xor     rax, rax        ; Set return value to 0
    xor     r10, r10        ; Initialize counter for parse
    xor     rcx, rcx        ; Initialize counter for outer loop

.get_len:
    push    rdi             ; Save str pointer to stack
    mov     rdi, rsi        ; Copy base to rdi
    call    ft_strlen       ; Ft_strlen uses rdi as input str and saves to rax
    mov     r8, rax         ; Save len to r8
    pop     rdi             ; Restore from stack
    xor     rax, rax        ; Reset return
    cmp     r8, 2           ; If len is less than two
    jl      .done           ; Return 0

.val_base_ol:
    cmp     byte [rsi+rcx], 0   ; if base[i] == '\0'
    je      .skip_white         ; Skip whitespace (if any)
    mov     rdx, 0              ; Initialize/reset counter for inner loop
    jmp     .val_base_il        ; Start inner loop

.val_base_il:
    cmp     rdx, rcx                ; Are both indexes at the same position?
    je      .skip_self
    movzx   r11, byte [rsi+rdx]     ; Move base[i] to intermediary
    movzx   r12, byte [rsi+rcx]     ; Move base[j] to intermediary 
    cmp     r11, r12                ; Is base[i] == base[j]
    je      .done                   ; Error if double found
    cmp     r12, 43                 ; Is base[j] == '+'
    je      .done
    cmp     r12, 45                 ; Is base[j] == '-'
    je      .done
    cmp     r12, 32                 ; Is base[j] <= ' '
    jle     .done                   ; If less then error (covers all whitespace)

.skip_self:
    cmp     byte [rsi+rdx], 0       ; Does base[i] == '\0'
    je      .next_outer             ; Go to next outer loop iteration
    inc     rdx                     ; increase index i
    jmp     .val_base_il            ; Return to top of loop

.next_outer:
    inc     rcx                     ; Increment outer loop counter
    jmp     .val_base_ol            ; Back to outer loop

.skip_white:
    cmp     byte [rdi], 0           ; Check for '\0'
    je      .sign
    cmp     byte [rdi], 32          ; Is str[i] <= ' '
    jg      .sign                   ; If not whitespace, carry on
    inc     rdi                     ; i++
    jmp     .skip_white             ; Check next char

.sign:
    mov     r9, 1                   ; Initialize r9 with 1
    cmp     byte [rdi], 45          ; Is str[i] == '-'
    je      .minus
    cmp     byte [rdi], 43          ; Is str[i] == '+'
    je      .plus
    jmp     .parse_loop             ; Else, carry on with parsing

.minus:
    inc     rdi                     ; Skip initial '-'
    mov     r9, -1                  ; Set sign to -1
    jmp     .parse_loop             ; Start parsing

.plus:
    inc     rdi                     ; Skip '+'
    jmp     .parse_loop

.parse_loop:
    movzx   rcx, byte [rdi]         ; Move str[i] to intermediary
    cmp     cl, 0                   ; Is str[i] == '\0'
    je      .done                   ; Exit
    xor     r10, r10                ; i = 0
    jmp     .find_char              ; Continue loop

.find_char:
    cmp     byte [rsi+r10], 0       ; Does base[i] == '\0'
    je      .done                   ; Return
    cmp     byte [rsi+r10], cl      ; If char was found
    je      .parse_num              ; Parse number to result
    inc     r10                     ; i++
    jmp     .find_char              ; Continue loop

.parse_num:
    imul    rax, r8                 ; Multiply return * len of base
    add     rax, r10                ; Add digit
    inc     rdi                     ; str++
    jmp     .parse_loop             ; Continue Loop

.done:
    imul    rax, r9                 ; Apply the sign
    ret
