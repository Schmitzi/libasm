; === ft_list_size ===
;
; The ft_list_size() function returns the number of elements in a given list

section .text
    global ft_list_size

ft_list_size:
    xor     rax, rax        ; Set counter to 0       

.loop:
    cmp     rdi, 0          ; If this list head is NULL
    je      .done           ; Return length
    inc     rax             ; i++
    mov     rdi, [rdi+8]    ; Move to list->next
    jmp     .loop           ; Continue with loop

.done:
    ret                     ; Return
