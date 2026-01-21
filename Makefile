# Targets
TARGET := libasm.a
BIN := src/main.c
BIN_BONUS := src/main_bonus.c

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
AR  := ar -rcs

# Flags
ASM_FLAGS := -f elf64

# Assembly files
FILES := ft_strlen ft_strcpy ft_strcmp ft_write ft_read ft_strdup
BONUS_FILES := ft_atoi_base

# Directories
SRC_DIR = src/
SRC = $(addprefix $(SRC_DIR), $(addsuffix .s, $(FILES)))
SRC_B = $(addprefix $(SRC_DIR), $(addsuffix .s, $(BONUS_FILES)))

OBJ_DIR	= obj/
OBJ = $(addprefix $(OBJ_DIR), $(addsuffix .o, $(FILES)))
OBJ_B = $(addprefix $(OBJ_DIR), $(addsuffix .o, $(BONUS_FILES)))

# Default target
all: $(TARGET)

# Bonus target - adds bonus objects to library
bonus: $(TARGET) $(OBJ_B)
	@echo -e "\n$(YELLOW)=== Adding Bonus to Archive ===$(RESET)"
	@$(AR) $(TARGET) $(OBJ_B)
	@echo -e "$(GREEN) === Bonus added ===$(RESET)"

# Create obj directory
$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

# Compile each assembly file (works for both regular and bonus)
$(OBJ_DIR)%.o: $(SRC_DIR)%.a | $(OBJ_DIR)
	@echo -e "\n$(YELLOW)=== Compile .asm -> .o ===$(RESET)"
	@$(ASM) $(ASM_FLAGS) $< -o $@
	@echo -e "$(GREEN) === .o files compiled ===$(RESET)"

# Create library with regular objects
$(TARGET): $(OBJ)
	@echo -e "\n$(YELLOW)=== Creating Archive ===$(RESET)"
	@$(AR) $@ $^
	@echo -e "$(GREEN) === Archive created ===$(RESET)"

# Run
run: $(TARGET)
	@gcc -g $(BIN) $(TARGET) -o libasm
	@./libasm

# Clean build artifacts
clean:
	@echo -e "$(RED)\n === Removing old files ===\n$(RESET)"
	@rm -f $(TARGET) libasm libasm_bonus
	@rm -rf $(OBJ_DIR)
	@echo -e "$(GREEN)┌────────────────────────┐"
	@echo -e "│    ✓ Clean complete    │"
	@echo -e "└────────────────────────┘$(RESET)"

# Rebuild everything
re: clean all

# Test the functions
test: $(TARGET)
	@echo -e "\n$(YELLOW)=== Testing Regular Functions ===$(RESET)"
	@gcc -g $(BIN) $(TARGET) -o libasm
	@./libasm

test_bonus: bonus
	@echo -e "\n$(YELLOW)=== Testing Bonus Functions ===$(RESET)"
	@gcc -g $(BIN_BONUS) $(TARGET) -o libasm_bonus
	@./libasm_bonus

# Help target
help:
	@echo -e "┌────────────────────────────┐"
	@echo -e "│     $(TARGET) Makefile        │"
	@echo -e "└────────────────────────────┘"
	@echo -e "Usage:"
	@echo -e "  make           - Build library (mandatory only)"
	@echo -e "  make bonus     - Build library with bonus"
	@echo -e "  make run       - Build and run"
	@echo -e "  make test      - Test regular functions"
	@echo -e "  make test_bonus- Test bonus functions"
	@echo -e "  make clean     - Remove build artifacts"
	@echo -e "  make re        - Rebuild everything"

.PHONY: all run clean re help bonus test test_bonus
