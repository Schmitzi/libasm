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

ft_list_push_front:
    push    r12         ; Save callee-saved registers
    push    r13
    sub     rsp, 8      ; Align stack to 16 bytes before malloc call
    mov     r12, rdi    ; Save begin_list pointer
    mov     r13, rsi    ; Save data pointer

.malloc:
    mov     rdi, 16            ; Allocate 16 bytes (sizeof(t_list))
    call    malloc WRT ..plt   ; Call malloc (stack is now 16-byte aligned)
    test    rax, rax           ; Check if malloc failed
    jz      .done              ; Return NULL if failed

.create:
    mov     [rax], r13         ; new_node->data = data
    mov     r10, [r12]         ; r10 = *begin_list (current head)
    mov     [rax+8], r10       ; new_node->next = current head
    mov     [r12], rax         ; *begin_list = new_node

.done:
    add     rsp, 8             ; Restore stack alignment
    pop     r13                ; Restore in reverse order
    pop     r12
    ret
