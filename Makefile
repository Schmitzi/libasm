# Targets
NAME := libasm.a
MAIN := src/main.c
MAIN_BONUS := bonus/main.c

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
BONUS_DIR = bonus/

SRC = $(addprefix $(SRC_DIR), $(addsuffix .s, $(FILES)))
SRC_B = $(addprefix $(BONUS_DIR), $(addsuffix .s, $(BONUS_FILES)))

OBJ_DIR	= obj/
OBJ = $(addprefix $(OBJ_DIR), $(addsuffix .o, $(FILES)))
OBJ_B = $(addprefix $(OBJ_DIR), $(addsuffix .o, $(BONUS_FILES)))

# Default target
all: $(NAME)

# Bonus target
bonus: fclean $(OBJ) $(OBJ_B)
	@echo "\n$(YELLOW)\n=== Creating Bonus Archive ===$(RESET)"
	@$(AR) $(NAME) $(OBJ) $(OBJ_B)
	@echo "$(GREEN)\n=== Bonus archive created ===\n$(RESET)"

# Create obj directory
$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

# Compile assembly files from src/
$(OBJ_DIR)%.o: $(SRC_DIR)%.s | $(OBJ_DIR)
	@$(ASM) $(ASM_FLAGS) $< -o $@
	@echo "$(GREEN)  ✓$(RESET) $<"

# Compile assembly files from bonus/
$(OBJ_DIR)%.o: $(BONUS_DIR)%.s | $(OBJ_DIR)
	@$(ASM) $(ASM_FLAGS) $< -o $@
	@echo "$(GREEN)  ✓$(RESET) $<"

# Create library with regular objects
$(NAME): $(OBJ)
	@echo "$(YELLOW)\n=== Creating Archive ===$(RESET)"
	@$(AR) $@ $^
	@echo "$(GREEN)\n=== Archive created ===\n$(RESET)"

# Clean build artifacts
clean:
	@echo "$(RED)\n === Removing .o files ===\n$(RESET)"
	@rm -rf $(OBJ_DIR)
	@echo "$(GREEN)┌────────────────────────┐"
	@echo "│    ✓ Clean complete    │"
	@echo "└────────────────────────┘\n$(RESET)"

fclean:
	@echo "$(RED)\n === Removing .o and binary files ===\n$(RESET)"
	@rm -f $(NAME) libasm libasm_bonus .bonus
	@rm -rf $(OBJ_DIR)
	@echo "$(GREEN)┌────────────────────────┐"
	@echo "│    ✓ Clean complete    │"
	@echo "└────────────────────────┘$(RESET)\n"

# Rebuild everything
re: clean all

# Test the functions
test: bin
	@./libasm

bin: $(NAME) $(MAIN)
	@echo "\n$(YELLOW)=== Creating ./libasm ===$(RESET)"
	@gcc -g $(MAIN) -o libasm -L. -lasm

test_bonus: bin_bonus
	@echo "\n$(YELLOW)=== Testing Bonus Functions ===$(RESET)"
	@./libasm_bonus

bin_bonus: $(NAME) $(MAIN_BONUS)
	@echo "\n$(YELLOW)=== Creating ./libasm_bonus ===$(RESET)"
	@gcc -g $(MAIN_BONUS) -o libasm_bonus -L. -lasm

# Help target
help:
	@echo "┌────────────────────────────┐"
	@echo "│     $(NAME) Makefile       │"
	@echo "└────────────────────────────┘"
	@echo "Usage:"
	@echo "  make           	- Build library (mandatory only)"
	@echo "  make bonus     	- Build library with bonus"
	@echo "  make run       	- Build and run"
	@echo "  make test      	- Test regular functions"
	@echo "  make test_bonus	- Test bonus functions"
	@echo "  make bin       	- Compile mandatory bin"
	@echo "  make bonus_bin   	- Compile bonus bin"
	@echo "  make clean     	- Remove build artifacts"
	@echo "  make re        	- Rebuild everything"

.PHONY: all run clean re help fclean test bin test_bonus bin_bonus help