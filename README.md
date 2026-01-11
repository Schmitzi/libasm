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
