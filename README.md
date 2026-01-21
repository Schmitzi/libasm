# libasm

42 Mastery Project about Assembly

## Lets get things straight!

There are obviously objectives to this project and they need to be well understood and implemented. I will outline those objectives here.

### ***First things first!***

- This must be written in 64-bit assembly. [***Beware of the "Calling Convention".***](https://en.wikipedia.org/wiki/X86_calling_conventions)
- No inline ASM is allowed, we will be using ```.s``` files.

- We will be using [Intel Syntax](https://en.wikipedia.org/wiki/X86_assembly_language), not AT&T syntax.

- We will also not be using the ```-no-pie``` compilation flag. (No google references found).

### ***Ok, now onto the actual requirements***

- The library must be called ```libasm.a```

- We must have a ```main()``` to test the functions and compile with the build library to demonstrate that it is functional.

- These functions must be rebuilt

  ◦ ft_strlen (man 3 strlen)
  ◦ ft_strcpy (man 3 strcpy)
  ◦ ft_strcmp (man 3 strcmp)
  ◦ ft_write (man 2 write)
  ◦ ft_read (man 2 read)
  ◦ ft_strdup (man 3 strdup, you can call to malloc

- We must check for errors during ```syscalls``` and handle then properly when needed.

- We must set ```errno``` correctly, therefore we are allowed to call the ```extern ___ error``` or ```errno_location```.

### If we are feeling freaky!

Then we can add a few more functions to our library, such as:

- ft_atoi_base
- ft_list_push_front
- ft_list_size
- ft_list_sort
- ft_list_remove_if

## Whats what?

### What is Assembly

Assembly Language, also known as Assembly, ASM or asm is any low-level programming language with a very strong correspondence between the instructions in the language and the architecture's machine code instructions. 

Assembly language usually has one statement per machine code instruction (1:1), but constants, comments, assembler directives, symbolic labels of ,e.g., memory locations, registers and macros are generally also supported.

It can also be known as symbolic machine code.

### What is NASM?

Originally written by Simon Tatham with assistance from Julian Hall, The Netwide Assembler or ```NASM``` is an assembler and dissembler for the Intel x86 architecture. It can be used to 16-bit, 32-bit or 64-bit programs. It is considered one of the most popular assemblers for Linux and x86 chips.

## What are assembler directives?

Assembler directives (or pseudo-ops) are commands for the assembler, not the processor, that control the assembly process and program structure, defining symbols, allocating memory and setting up data like constants, strings or reserved space, without generating machine code themselves.

Common examples include:

- ```.ORG``` (Origin): Sets the starting address for subsequent instructions or data.
- ```.DB``` (Define Byte): Reserves and initializes memory for byte-sized data.
- ```.EQU``` (Equate): Assigns a symbolic name to a constant value.
- ```.END```: Marks the logical end of the source code.
- ```.DW / .WORD``` (Define Word): Reserves and initializes memory for word-sized data (e.g., 16-bit).
- ```ASCII```: Places ASCII characters in memory.

They are essential for organising assembly code, allowing programmers to manage data, and the output format.

### Key Functions of Assembler Directives

- ```Data Definition```: Define constants, bytes, words, or strings (e.g., .DB, .WORD, .ASCII).
```Memory Management```: Reserve memory space for variables or specify sections (e.g., .BSS, .DATA, .ALIGN).
```Program Control```: Indicate program start/end, set origin, or include other files (e.g., .START, .END, .ORG).
```Symbol Management```: Create symbolic names for addresses or values (e.g., EQU, SET).
```Conditional Assembly```: Include or exclude code blocks based on conditions (e.g., .IF, .ELSE).

### How do they work?

Directives are processed by the assembler during the translation of assembly code to machine code; they are instructions to the *assembler*, not the CPU, so they don't have to become part of the final binary's instructions. They often start wit a special character like a period ```.```.

## What are symbolic labels?

Symbolic labels in assembly language are ```human-readable names``` (symbols) assigned to specific memory addresses or data, allowing programmers to use memorable identifiers (like ```my_loop:```) instead of raw numbers for instructions like jumps, calls, of data references, making code cleaner and easier to manage; the assembler translates these labels into their corresponding numeric addresses during assembly, using a symbol table to keep track of the mappings.

### Key Concepts

- ```Symbol```: A name (e.g. ```counter```, ```getData```) that represents a value, often a memory address,
- ```Label```: A specific type of symbol, usually an identifier followed by a colon (```:```) that marks a specific location in the code or data.
- ```Symbol Table```: The assembler's internal dictionary that stores these symbol-to-value mappings.

### Example 

```asm
start:      ; Label 'start' marks the beginning of the program
    MOV AX, 0 ; Move 0 into AX
    JMP loop  ; Jump to the 'loop' label

loop:       ; Label 'loop' marks a specific instruction
    ADD AX, 1 ; Increment AX
    CMP AX, 10
    JNE loop  ; Jump back to 'loop' if not equal

end_program: ; Label for the end
    HLT       ; Halt execution
```

## What are calling conventions?

Calling conventions describe the interface of called code:

- the order in which atomic (scalar) parameters, or individual parts of a complex parameter, are allowed.

- How parameters are passed (pushed on the stack, placed in registers, or a mix of both).

- Which registers the called function must preserve for the caller (also known as ```callee- saved registers``` or ```non-volitile registers```).

This is intimately related to the assignment of sizes and formats to programming-language types.

Another closely related topic is ```name-mangling```, which determines how symbol names in the code are mapped to symbol names used by the linker. 

Calling conventions, type representations, and name mangling are all part of what is known as an ```application binary interface``` (ABI).

There are subtle differences in how various compilers implement these conventions, so it is often difficult to interface code which is compiled by different compilers. On the other hand, conventions which are used as an API standard (such as ```stdcall```) are very uniformly implemented.



## what is name-mangling?

## How to write Assembly code

An assembly program can be divided into tree sections:

- The `data` section
- The `bss` section
- the ```text``` section

### The data Section

The data section is used for declaring initialized data or constants. This data does not change at runtime.

You can declare various constant values, file names, or buffer size, etc., in this section.

The syntax is 

```asm
section.data
```

### The bss Section

The bss section is for declaring variables. the syntax for declaring the bss section is:

```asm
section.bss
```

### The text Section

The text section is used for keeping the actual code. thes section must bein with the declaration ```global _start```, which tells the kernel where the program execution begins.

The syntax for declaring text section is:

```asm
section.text
  global _start
_start:
```

### Comments

Assembly language comments begins with a semicolon (`;`). It may contain any printable character including blank. It can appear in a line by itself, like:

```asm
; This is a comment
```

Or, on the same line along with an instruction, like:

```asm
add eax, ebx    ; adds ebx to eax
```

### Assembly Language statement

Assembly language programs consist of three types of statements:

- Instructions, whether executable or not.
- Assembler directives or pseudo-ops.
- Macros

The `executable instructions` or simply `instructions` tell the processor what to do. Each instruction consist of an `operation code` (opcode). Each executable instruction generates one machine language instruction.

The `assembler directives` or `pseudo-ops` tell the assembler about various aspects of the assembly process. These are non-executable and do not generate machine language instructions.

`Macros` are basically a text substitution mechanism.

### Syntax of Assembly Language statements
Assembly language instructions statements are entered one statement per line. Each statement follows the following format:

```text
[label]   mnemonic    [operands]    [;comment]
```

The fields in the square brackets are optional. A basic instruction has two parts, the first one is the name of the instruction (or the mnemonic), which is to be executed, and the second are the operands or the parameters of the command.

The following are some examples of typical assembly language statements.

```asm
inc count         ; increment the memory variable "count"

mov total,  48    ; Transfer the value 48 in the memory total

add ah, bh        ; Add the content of the "bh" register into the "ah" register

and mask1, 128    ; Perform 'and' operation (&) on the variable "mask1" and 128

add marks, 10     ; Add 10 to the variable "marks"

mov al, 10        ; transfer the value 10 to the "al" register
```

### Hello, world!

```asm
section .text
    global _start     ; Must be defined for linker

_start:               ; Gives the linker the entry point
    mov  edx, len     ; Message length
    mov  ecx, msg     ; Message to write
    mov  ebx, 1       ; Descriptor (stdout == 1)
    mov  eax, 4       ; System call number (sys_write)
    int  0x80         ; Call kernel

    mov  eax, 1       ; System call number (sys_exit)
    int  0x80         ; Call Kernel

section .data
    msg db 'Hello, world!', 0xa   ; String to be printed
    len equ $ - msg               ; Length of the string
```

When the above code is compiled and executed, it produces the following result:

```
Hello, world!
```

### Compiling and Linking an Assembly Program in NASM

Make sure you have set the path of `nasm` and `ld` binaries in you `PATH` environment variable.

Now take the following steps for compiling and linking the above program:

- Save the above code as `hello.asm`.
- To assemble the program, type `nasm -f elf hello.asm`
- This should create a file called `hello.o`
- Then link the object file and create the binary with `ld -m elf_i386 -s -o hello hello.o`
- Then run with `./hello`

## Note!

Some prototypes contain the `restrict` keyword, but with GCC we use `__restrict__` instead. For examples:

```c
char *strcpy(char *restrict dst, const char *restrict src);
char *ft_strcpy(char *__restrict__ dst, const char *__restrict__ src);
```

Using square brackets on a register changes how its accessed. For instance:

```asm
inc rdi   ; this moves the pointer 1 index forward.
inc [rdi] ; this increases the value stored at rdi
```

When comparing registers, you do not need the `byte` keyword

```asm
cmp byte al, 0  ; This is incorrect
cmp al, 0       ; This is much better
```

## Important Keywords

- ```section```:
- ```push```:
- ```mov```:
- ```ebp```:
- ```esp```:
- ```edx```:
- ```eax```:
- ```xor```:
- ```jmp```:
- ```if```:
- ```then```:
- ```inc```:
- ```cmp```:
- ```jmp```:
- ```jne```:
- ```cl```:
- ```pop```:
- ```ret```:

