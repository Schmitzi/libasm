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
    global ft_read

ft_read:
    mov rax, 0      ; Set rax to read
    syscall         ; Perform syscall
    ret             ; Return counter
