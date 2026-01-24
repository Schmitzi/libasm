# Targets
NAME := libasm.a
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
BONUS_FILES := ft_atoi_base ft_list_push_front ft_list_size ft_list_sort ft_list_remove_if

# Directories
SRC_DIR = src/
SRC = $(addprefix $(SRC_DIR), $(addsuffix .asm, $(FILES)))
SRC_B = $(addprefix $(SRC_DIR), $(addsuffix .asm, $(BONUS_FILES)))

OBJ_DIR	= obj/
OBJ = $(addprefix $(OBJ_DIR), $(addsuffix .o, $(FILES)))
OBJ_B = $(addprefix $(OBJ_DIR), $(addsuffix .o, $(BONUS_FILES)))

# Default target
all: $(NAME)

# Bonus target - adds bonus objects to library
bonus: $(NAME) $(OBJ_B)
	@echo -e "\n$(YELLOW)=== Adding Bonus to Archive ===$(RESET)"
	@$(AR) $(NAME) $(OBJ_B)
	@echo -e "$(GREEN) === Bonus added ===$(RESET)"

# Create obj directory
$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

# Compile each assembly file (works for both regular and bonus)
$(OBJ_DIR)%.o: $(SRC_DIR)%.asm | $(OBJ_DIR)
	@echo -e "\n$(YELLOW)=== Compile .asm -> .o ===$(RESET)"
	@$(ASM) $(ASM_FLAGS) $< -o $@
	@echo -e "$(GREEN) === .o files compiled ===$(RESET)"

# Create library with regular objects
$(NAME): $(OBJ)
	@echo -e "\n$(YELLOW)=== Creating Archive ===$(RESET)"
	@$(AR) $@ $^
	@echo -e "$(GREEN) === Archive created ===$(RESET)"

# Run
run: $(NAME)
	@gcc -g $(BIN) $(NAME) -o libasm
	@./libasm

# Clean build artifacts
clean:
	@echo -e "$(RED)\n === Removing .o files ===\n$(RESET)"
	@rm -rf $(OBJ_DIR)
	@echo -e "$(GREEN)┌────────────────────────┐"
	@echo -e "│    ✓ Clean complete    │"
	@echo -e "└────────────────────────┘$(RESET)"

fclean:
	@echo -e "$(RED)\n === Removing .o and binary files ===\n$(RESET)"
	@rm -f $(NAME) libasm libasm_bonus
	@rm -rf $(OBJ_DIR)
	@echo -e "$(GREEN)┌────────────────────────┐"
	@echo -e "│    ✓ Clean complete    │"
	@echo -e "└────────────────────────┘$(RESET)"

# Rebuild everything
re: clean all

# Test the functions
test: $(NAME)
	@echo -e "\n$(YELLOW)=== Testing Regular Functions ===$(RESET)"
	@gcc -g $(BIN) $(NAME) -o libasm

test_bonus: bonus
	@echo -e "\n$(YELLOW)=== Testing Bonus Functions ===$(RESET)"
	@gcc -g $(BIN_BONUS) $(NAME) -o libasm_bonus

# Help target
help:
	@echo -e "┌────────────────────────────┐"
	@echo -e "│     $(NAME) Makefile        │"
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
