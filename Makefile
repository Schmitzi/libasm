TARGET := libasm.a

# Colours
RED		=	\e[0;91m
BLUE	=	\e[0;94m
GREEN	=	\e[0;92m
YELLOW	=	\e[0;33m
WHITE	=	\e[0;97m
BOLD	=	\e[1m
U_LINE	=	\e[4m
RESET	=	\e[0m

# Compiler and tools
ASM := nasm

# Flags
ASM_FLAGS := -f elf32

# Directories
SRC_DIR := src
OBJ_DIR := obj

# Assembly files
ASM_SRCS := src/
ASM_OBJS := $(addprefix $(OBJ_DIR)/, $(ASM_SRCS:.asm=.o))

# Default target
all: $(TARGET)

# Create obj directory
$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

# Compile each assembly file
$(OBJ_DIR)/boot.o: $(KFS_DIR)/boot.asm | $(OBJ_DIR)
	@echo -e "\n$(YELLOW)=== Compile .asm -> .o ===$(RESET)"
	@echo -e "┌────────────────────────┐"
	@echo -e "│ Assembling boot.asm... │"
	@echo -e "│                        │"
	@$(ASM) $(ASM_FLAGS) $< -o $@

	@echo -e "$(GREEN) === .o files compiled ===$(RESET)"

$(TARGET): $(ASM_OBJS)
	@echo -e "\n$(YELLOW)=== Linking kernel ==="
	@$(LD) $(LD_FLAGS) -o $(KERNEL) $(ASM_OBJS) $(RUST_LIB)

# Run
run: $(TARGET)

# Clean build artifacts
clean:
	@echo -e "$(RED)\n === Removing old files ===\n"
	@rm -f $(TARGET)
	@rm -rf $(OBJ_DIR)
	@echo -e "$(GREEN)┌────────────────────────┐"
	@echo -e "│    ✓ Clean complete    │"
	@echo -e "└────────────────────────┘$(RESET)"

# Rebuild everything
re: clean all

# Help target
help:
	@echo -e "┌────────────────────────────┐"
	@echo -e "│     $(TARGET) Makefile        │"
	@echo -e "└────────────────────────────┘"
	@echo -e "Usage:"
	@echo -e "  make           - Build kernel"
	@echo -e "  make run       - Build and run"
	@echo -e "  make clean     - Remove build artifacts"
	@echo -e "  make re        - Rebuild everything"

bonus:
		

.PHONY: all run clean re check help bonus
