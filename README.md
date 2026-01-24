# libasm

42 Mastery Project - Assembly Language

## Project Requirements

### Constraints

- Written in 64-bit Assembly using [Intel Syntax](https://en.wikipedia.org/wiki/X86_assembly_language)
- No inline ASM - only `.s` files
- Must follow the [x86-64 Calling Convention](https://en.wikipedia.org/wiki/X86_calling_conventions)
- No `-no-pie` compilation flag (Position Independent Executable required)

### Mandatory Functions

The library must be called `libasm.a` and implement:

| Function | Reference |
|----------|-----------|
| ft_strlen | `man 3 strlen` |
| ft_strcpy | `man 3 strcpy` |
| ft_strcmp | `man 3 strcmp` |
| ft_write | `man 2 write` |
| ft_read | `man 2 read` |
| ft_strdup | `man 3 strdup` (can call malloc) |

- Syscalls must check for errors and set `errno` correctly
- Allowed to use `extern ___error` or `errno_location`

### Bonus Functions

- ft_atoi_base
- ft_list_push_front
- ft_list_size
- ft_list_sort
- ft_list_remove_if

---

## Assembly Fundamentals

### What is Assembly?

Assembly is a low-level programming language with a strong correspondence between its instructions and the architecture's machine code. Each statement typically maps 1:1 to a machine instruction, though it also supports constants, comments, directives, labels, and macros.

### What is NASM?

The Netwide Assembler (NASM) is an assembler and disassembler for the Intel x86 architecture, supporting 16-bit, 32-bit, and 64-bit programs. It's one of the most popular assemblers for Linux.

---

## Program Structure

An assembly program has three sections:

### The `.data` Section

Used for declaring initialized data or constants that don't change at runtime.

```asm
section .data
    msg db 'Hello', 0
```

### The `.bss` Section

Used for declaring uninitialized variables (reserves memory without initial values).

```asm
section .bss
    buffer resb 64
```

### The `.text` Section

Contains the executable code. Must declare `global _start` (or `global main` when linking with C).

```asm
section .text
    global _start
_start:
    ; code here
```

---

## Syntax Reference

### Statement Format

```
[label]   mnemonic   [operands]   [;comment]
```

### Comments

```asm
; This is a standalone comment
add eax, ebx    ; This is an inline comment
```

### Examples

```asm
inc count         ; Increment memory variable "count"
mov total, 48     ; Move 48 into "total"
add ah, bh        ; Add bh to ah
mov al, 10        ; Move 10 into al register
```

---

## Assembler Directives

Directives (pseudo-ops) are commands for the assembler, not the processor. They control assembly and define data without generating machine code.

| Directive | Purpose |
|-----------|---------|
| `.ORG` | Set starting address |
| `.DB` / `db` | Define byte(s) |
| `.DW` / `dw` | Define word(s) |
| `.EQU` / `equ` | Assign symbolic constant |
| `.ASCII` | Place ASCII string |
| `.BSS` | Uninitialized data section |
| `.DATA` | Initialized data section |

---

## Symbolic Labels

Labels are human-readable names for memory addresses, making code easier to read and maintain. The assembler resolves them to numeric addresses.

```asm
loop:
    add rax, 1
    cmp rax, 10
    jne loop      ; Jump back to 'loop' if not equal
```

---

## x86-64 Calling Convention (System V AMD64 ABI)

### Parameter Passing

Arguments are passed in registers (in order): `rdi`, `rsi`, `rdx`, `rcx`, `r8`, `r9`

### Return Value

Returned in `rax`

### Caller-Saved Registers (volatile)

`rax`, `rdi`, `rsi`, `rdx`, `rcx`, `r8`, `r9`, `r10`, `r11`

### Callee-Saved Registers (non-volatile)

`rbx`, `rbp`, `r12`, `r13`, `r14`, `r15`

---

## Quick Tips

### Pointer vs Value Access

```asm
inc rdi     ; Increment the pointer itself
inc [rdi]   ; Increment the value at the address
```

### Register Size Comparison

```asm
cmp byte al, 0    ; Incorrect - al is already 8-bit
cmp al, 0         ; Correct
```

### The `restrict` Keyword

In GCC, use `__restrict__` instead of `restrict`:

```c
char *ft_strcpy(char *__restrict__ dst, const char *__restrict__ src);
```

---

## Hello World Example

```nasm
section .text
    global _start

_start:
    mov rax, 1        ; Syscall number (sys_write)
    mov rdi, 1        ; File descriptor (stdout)
    mov rsi, msg      ; Message address
    mov rdx, len      ; Message length
    syscall           ; Call kernel

    mov rax, 60       ; Syscall number (sys_exit)
    xor rdi, rdi      ; Exit code 0
    syscall           ; Call kernel

section .data
    msg db 'Hello, world!', 0xa
    len equ $ - msg
```

### Compile and Run

```bash
nasm -f elf hello.asm
ld -m elf_i386 -s -o hello hello.o
./hello
```

---

## Resources

- [NASM Documentation](https://www.nasm.us/doc/)
- [x86-64 System V ABI](https://refspecs.linuxbase.org/elf/x86_64-abi-0.99.pdf)
- [Intel x86 Instruction Reference](https://www.felixcloutier.com/x86/)