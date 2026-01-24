; === ft_list_remove_if ===
;
; The ft_list_remove_if() function removes all elements from the list
;   whose data, when compared to *data_ref* using *cmp*, causes to
;   return 0.
;
; The data from an element to be erased should be freed using *free_fct*.
;
; The functions pointed to by *cmp* and *free_fct* will be used as:
;   (*cmp)(list_ptr->data, data_ref);
;   (*free_fct)(list_ptr->data);

section .text
    extern free
    global ft_list_remove_if

ft_list_remove_if:
    push    r12             ; Protect callee-saved registers
    push    r13
    push    r14
    push    r15
    push    rbx
    push    rbp
    mov     r12, rdi        ; Save pointer to begin_list
    mov     r13, rsi        ; Save pointer to data_ref
    mov     r14, rdx        ; Save pointer to cmp function
    mov     r15, rcx        ; Save pointer to free function
    mov     rbx, [r12]      ; Current = *begin_list
    xor     rbp, rbp        ; Prev = NULL

.loop:
    test    rbx, rbx        ; If current == NULL
    jz      .done
    mov     rdi, [rbx]      ; rdi = current->data
    mov     rsi,  r13       ; rsi = data_ref
    call    r14             ; Call cmp function
    test    rax, rax        ; If return value == 0
    jz      .remove_node    ; Remove node
    mov     rbp, rbx        ; Prev = current
    mov     rbx, [rbx+8]    ; Current = current->next
    jmp     .loop           ; Continue with loop

.remove_node:
    mov     r9, [rbx+8]     ; R9 = current->next
    push    r9              ; Protect r9
    mov     rdi, [rbx]      ; Rdi = current->data
    call    r15             ; Call free_fct on current->data
    mov     rdi, rbx        ; rdi = current
    call    free WRT ..plt  ; Free(current)
    pop     r9              ; Restore r9 from stack
    test    rbp, rbp        ; If prev == NULL
    jz      .update_head 
    mov     [rbp+8], r9     ; Move next->next to current->next
    jmp     .continue

.update_head:
    mov     [r12], r9       ; *begin_list = next

.continue:
    mov     rbx, r9         ; Current = next
    jmp     .loop

.done:
    pop     rbp             ; Restore registers
    pop     rbx
    pop     r15
    pop     r14
    pop     r13
    pop     r12
    ret
