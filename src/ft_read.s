; === ft_read ===
;
; The function ft_read() attempts to read upto 'n' bytes from the given 'fd'
;
; Why so short?
;
; The parameters are already in the correct registers:
; - fd == rdi
; - buf == rsi
; - n == rdx
;
; From here we just need to set rax to read and do a syscall, 
;   then return rax (number of bytes).

section .text
    extern  __errno_location
    global  ft_read

ft_read:
    mov     rax, 0      ; Set rax to read
    syscall             ; Perform syscall
    cmp     rax, 0      ; Check errno code
    jl      .error      ; Handle error
    ret                 ; Return counter

.error:
    neg     rax                         ; Flip sign of return (e.g. 1 to -1) 
    mov     rdx, rax                    ; Save error code
    call    __errno_location WRT ..plt  ; Get address of errno
    mov     [rax], rdx                  ; Store error code at errno address
    mov     rax, -1                     ; Set value of errno to -1
    ret
