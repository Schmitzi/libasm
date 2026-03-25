; === ft_write ===
;
; the ft_write() function writes 'n' bytes starting at 'buf' 
;   to the desired fd.
;
; Why so short?
;
; The parameters are already in the correct registers:
; - fd == rdi
; - buf == rsi
; - n == rdx
;
; From here we just need to set rax to write and do a syscall, 
;   then return rax (number of bytes written).

section .text
    extern __errno_location
    global ft_write

ft_write:
    mov     rax, 1      ; Set rax to write
    syscall             ; Perform syscall
    cmp     rax, 0      ; Check errno in return register (return < 0)
    jl      .error
    ret                 ; Return counter

.error:
    neg     rax                         ; Flip sign of return (e.g. 1 to -1) 
    mov     rdx, rax                    ; Save error code
    call    __errno_location WRT ..plt  ; Get address of errno
    mov     [rax], rdx                  ; Store error code at errno address
    mov     rax, -1                     ; Set value of errno to -1
    ret
