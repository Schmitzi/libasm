; === ft_list_sort ===
;
; The ft_list_sort() function takes the given lists elements and sorts them
;   in ascending order by two elements and their data using a comparison
;   function (e.g ft_strcmp())
;
;   This would look like this:
;       (*cmp)(list_ptr->data, list_other_ptr->data)

section .text
    global ft_list_sort

ft_list_sort:
    push    rbx             ; Save callee-saved registers
    push    r12
    push    r13
    push    r14
    push    r15
    
    mov     rbx, [rdi]      ; rbx = head pointer (CALLEE-SAVED!)
    cmp     rbx, 0          ; Is list empty?
    je      .done
    mov     r15, rsi        ; r15 = comparison function (CALLEE-SAVED!)

.outer_loop:
    xor     r14, r14        ; r14 = swapped flag (CALLEE-SAVED!)
    mov     r12, rbx        ; r12 = current node = head

.inner_loop:
    cmp     r12, 0          ; Check if current is NULL
    je      .checker
    mov     r13, [r12+8]    ; r13 = current->next (CALLEE-SAVED!)
    cmp     r13, 0          ; Does next == NULL?
    je      .checker
    
    ; Prepare arguments for comparison function
    mov     rdi, [r12]      ; rdi = current->data (first arg)
    mov     rsi, [r13]      ; rsi = next->data (second arg)
    call    r15             ; Call comparison function
    
    ; Check result (rax = comparison result)
    cmp     rax, 0          ; If current->data <= next->data, no swap
    jle     .no_swap
    
    ; Swap the data pointers
    mov     rax, [r12]      ; rax = current->data
    mov     rcx, [r13]      ; rcx = next->data
    mov     [r12], rcx      ; current->data = next's data
    mov     [r13], rax      ; next->data = current's data
    mov     r14, 1          ; Set swapped flag

.no_swap:
    mov     r12, [r12+8]    ; Move to next node (current = current->next)
    jmp     .inner_loop

.checker:
    cmp     r14, 0          ; Was there a swap?
    jne     .outer_loop     ; If yes, do another pass

.done:
    pop     r15             ; Restore callee-saved registers in reverse order
    pop     r14
    pop     r13
    pop     r12
    pop     rbx
    ret
