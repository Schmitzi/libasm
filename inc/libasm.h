#ifndef LIBASM_H
#define LIBASM_H

// === Includes ===
#include <stddef.h>
#include <stdlib.h>
#include <sys/types.h>

typedef struct s_list {
  void *data;          // pointer to the data
  struct s_list *next; // pointer to next node
} t_list;

// === Mandatory ===
size_t ft_strlen(const char *str);
char *ft_strcpy(char *__restrict__ dst, const char *__restrict__ src);
int ft_strcmp(const char *s1, const char *s2);
ssize_t ft_write(int fd, const void *buf, size_t count);
ssize_t ft_read(int fd, const void *buf, size_t count);
char *ft_strdup(const char *s);

// === Bonus ===
int ft_atoi_base(char *str, char *base);
void ft_list_push_front(t_list **begin_list, void *data);

#endif
