#pragma once

// === Includes ===
#include <stddef.h>
#include <stdlib.h>
#include <sys/types.h>

#define RED "\e[0;91m"
#define BLUE "\e[0;94m"
#define GREEN "\e[0;92m"
#define YELLOW "\e[0;33m"
#define WHITE "\e[0;97m"
#define BOLD "\e[1m"
#define U_LINE "\e[4m"
#define RESET "\e[0m"

// === Mandatory ===
size_t ft_strlen(const char *str);
char *ft_strcpy(char *__restrict__ dst, const char *__restrict__ src);
int ft_strcmp(const char *s1, const char *s2);
ssize_t ft_write(int fd, const void *buf, size_t count);
ssize_t ft_read(int fd, const void *buf, size_t count);
char *ft_strdup(const char *s);
