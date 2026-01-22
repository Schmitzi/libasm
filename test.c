#include <stdio.h>
#include <stdlib.h>

char *ft_strdup(const char *s);

int main(void) {
  printf("Testing ft_strdup in isolation...\n");

  char *dup1 = ft_strdup("Hello");
  printf("dup1: '%s'\n", dup1);
  free(dup1);

  char *dup2 = ft_strdup("World");
  printf("dup2: '%s'\n", dup2);
  free(dup2);

  char *dup3 = ft_strdup("Testing");
  printf("dup3: '%s'\n", dup3);
  free(dup3);

  // Test multiple times to see if heap corruption happens
  for (int i = 0; i < 10; i++) {
    char *tmp = ft_strdup("Test");
    printf("Iteration %d: '%s'\n", i, tmp);
    free(tmp);
  }

  printf("\nAll strdup tests passed!\n");
  return 0;
}
