#include "../inc/libasm.h"
#include <stdio.h>
#include <string.h>

#define SIZE 100

int main() {
  printf(" _ _ _\n");
  printf("| (_) |\n");
  printf("| |_| |__   __ _ ___ _ __ ___\n");
  printf("| | | '_ \\/  `  / __| '_ ` _ \\\n");
  printf("| | | |_) | (_| \\__ \\ | | | | |\n");
  printf("|_|_|_.__/ \\__,_|___/_| |_| |_|\n");


  char msg[SIZE];
  char *test_str = "Hello, World!";


  ft_write(1, "\n=== Testing ft_read() ===\n", 27);
  ft_write(1, "Enter a message : ", 18);

  ssize_t bytes_read = ft_read(0, msg, SIZE - 1);
  if (bytes_read > 0)
    msg[bytes_read] = '\0';
  size_t len = ft_strlen(msg);
  if (len > 0 && msg[len - 1] == '\n') {
    msg[len - 1] = '\0';
  }

  printf("\n=== Testing ft_write() ===\n");
  ft_write(1, msg, ft_strlen(msg));
  printf("\n");

  printf("\n=== Testing ft_strlen() ===\n");
  printf("strlen:\t\t%ld\n", strlen(msg));
  printf("ft_strlen:\t%ld\n", ft_strlen(msg));

  printf("\n=== Testing ft_strcpy() ===\n");
  char dst[SIZE];
  ft_strcpy(dst, msg);
  printf("Copied string: %s\n", dst);

  printf("\n=== Testing ft_strcmp() ==\n");
  
  printf("Test string:\t|%s|\n", test_str);
  printf("Our string:\t|%s|\n", msg);

  int std_result = strcmp(test_str, msg);
  int ft_result = ft_strcmp(test_str, msg);
  printf("strcmp:\t\t%d\n", std_result);
  printf("ft_strcmp:\t%d\n", ft_result);

  printf("\n=== Testing ft_strdup ===\n");
  char *duped = ft_strdup(msg);
  printf("Output: %s\n", duped);
  free(duped);
}
