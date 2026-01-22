; === ft_list_push_front
;
; The ft_list_push_front() function pushes a node (t_list) to the front of the list
;
; Linked liats structures are 16 bytes large (8 for data, 8 for next).
; Accessing the data would be [rdi] and next wqould be [rdi+8]
;

section .text
    extern malloc
    global ft_list_push_front

ft_list_push_front:  ; Because malloc will clear our registers, we need to save them
    push    r12         ; Save callee-saved register
    push    r13
    sub     rsp, 8
    mov     r12, rdi     ; Save pointer for later
    mov     r13, rsi     ; Save data for later

.malloc:
    mov     rdi, 16            ; Mark len for 16 bytes
    call    malloc WRT ..plt   ; Call the malloc function
    cmp     rax, 0             ; If list == NULL
    je      .done           ; Return NULL

.create:
    mov     [rax], r13          ; Move data pointer to rax
    mov     rbx, [r12]          ; Get *head value
    mov     [rax+8], rbx       ; Write to offset 8 (next field)
    mov     [r12], rax          ; Store new node's address into *begin_list

.done:
    add     rsp, 8
    pop     r12                 ; Restore registers
    pop     r13
    ret

