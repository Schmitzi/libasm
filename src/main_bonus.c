#include "../inc/libasm.h"
#include <stdio.h>
#include <string.h>

ssize_t writer(const char *msg) { return (ft_write(1, msg, ft_strlen(msg))); }

int main() {
  writer("=== Libasm ===\n\n");

  char msg[100];
  writer("=== Testing ft_read() ===\nEnter a message: ");
  ft_read(0, msg, 100);

  writer("\n=== Testing ft_write() ==\n");
  ft_write(1, msg, ft_strlen(msg));

  writer("\n=== Testing ft_strlen() ==\n");
  size_t len = ft_strlen(msg);
  writer("Len: ");
  printf("%ld\n", len);

  writer("\n=== Testing ft_strcpy() ==\n");
  char dst[50];
  ft_strcpy(dst, msg);
  writer("Copied string: ");
  writer(dst);

  char *str = "Hello, World!";
  writer("\n=== Testing ft_strcmp() ==\nTest string: ");
  printf("%s\n", str);
  writer("Our string: ");
  writer(msg);
  int res = ft_strcmp(str, msg);

  int std_result = strcmp(str, msg);
  int ft_result = ft_strcmp(str, msg);
  writer("strcmp: ");
  printf("%d\n", std_result);
  writer("ft_strcmp: ");
  printf("%d\n", ft_result);

  writer("\n=== Testing ft_strdup ===\n");
  char *duped = ft_strdup(msg);
  writer("Output: ");
  writer(duped);

  writer("\n\n=== BONUS ===\n\n");

  writer("=== Testing ft_atoi_base ===\n");
  res = ft_atoi_base("123", "0123456789");
  writer("Should be: 123\n");
  printf("Result: %d\n\n", res);

  res = ft_atoi_base("-123", "0123456789");
  writer("Should be: -123\n");
  printf("Result: %d\n\n", res);

  res = ft_atoi_base("    +42", "0123456789");
  writer("Should be: 42\n");
  printf("Result: %d\n\n", res);

  res = ft_atoi_base("101", "01");
  writer("Should be: 5\n");
  printf("Result: %d\n\n", res);

  res = ft_atoi_base("123", "0");
  writer("Should be: 0 (error: invalid base)\n");
  printf("Result: %d\n\n", res);

  res = ft_atoi_base("123", "01234567889");
  writer("Should be: 0 (error: duplicate in base)\n");
  printf("Result: %d\n\n", res);
  return 0;
}
