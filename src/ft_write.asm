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
    global ft_write

ft_write:
    mov rax, 1      ; Set rax to write
    syscall         ; Perform syscall
    ret             ; Return counter

