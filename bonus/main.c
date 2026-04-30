#include "../inc/libasm_bonus.h"
#include <stdio.h>
#include <string.h>

#define SIZE 100

void print_list(t_list *head) {
  t_list *current = head;
  for (size_t i = 0; current != NULL; i++) {
    printf("Node %ld: data->%s\tnext->%p\n", i, (char *)current->data,
           current->next);
    current = current->next;
  }
}

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

  printf("Test string:\t|%s|\n", "Hello, World!");
  printf("Our string:\t|%s|\n", msg);
  int std_result = strcmp(test_str, msg);
  int ft_result = ft_strcmp(test_str, msg);

  printf("strcmp:\t\t%d\n", std_result);
  printf("ft_strcmp:\t%d\n", ft_result);

  printf("\n=== Testing ft_strdup ===\n");
  char *duped = ft_strdup(msg);
  printf("Output: %s", duped);
  free(duped);

  printf("\n\n=================================\n");
  printf(" ____   ____  _   _ _    _  _____\n");
  printf("|  _ \\ / __ \\| \\ | | |  | |/ ____|\n");
  printf("| |_) | |  | |  \\| | |  | | (___\n");
  printf("|  _ <| |  | | . ` | |  | |\\___ \\\n");
  printf("| |_) | |__| | |\\  | |__| |____) |\n");
  printf("|____/ \\____/|_| \\_|\\____/|_____/\n");
  printf("=================================\n\n");

  printf("=== Testing ft_atoi_base ===\n");
  int res = ft_atoi_base("123", "0123456789");
  printf("Input: 123\tBase:\t0123456789\n");
  printf("Should be:\t123\nResult:\t\t%d\n\n", res);

  res = ft_atoi_base("-123", "0123456789");
  printf("Input:\t-123\tBase:\t0123456789\n");
  printf("Should be:\t-123\nResult:\t\t%d\n\n", res);

  res = ft_atoi_base("    +42", "0123456789");
  printf("Input:\t    +42\tBase:\t0123456789\n");
  printf("Should be:\t42\nResult:\t\t%d\n\n", res);

  res = ft_atoi_base("101", "01");
  printf("Input:\t101\tBase:\t01\n");
  printf("Should be:\t5\nResult:\t\t%d\n\n", res);

  res = ft_atoi_base("123", "0");
  printf("Input: 123\tBase:\t0\n");
  printf("Should be:\t0 (error: invalid base)\nResult:\t\t%d\n\n", res);

  res = ft_atoi_base("123", "01234567889");
  printf("Input: 123\tBase:\t01234567889\n");
  printf("Should be:\t0 (error: duplicate in base)\nResult:\t\t%d\n\n", res);

  printf("=== Testing ft_list_push_front ===\n");
  t_list *head = NULL;

  // Test 1: Push to empty list
  printf("Test 1: Push 'First' to empty list\n");
  ft_list_push_front(&head, "First");
  print_list(head);
  printf("Size: %d\n", ft_list_size(head));

  // Test 2: Push another element
  printf("\nTest 2: Push 'Second' (becomes new head)\n");
  ft_list_push_front(&head, "Second");
  print_list(head);
  printf("Size: %d\n", ft_list_size(head));

  // Test 3: Push more elements
  printf("\nTest 3: Push 'Third', 'Fourth', 'Fifth'\n");
  ft_list_push_front(&head, "Third");
  ft_list_push_front(&head, "Fourth");
  ft_list_push_front(&head, "Fifth");
  print_list(head);
  printf("Size: %d\n", ft_list_size(head));

  // Test 4: Manual traversal
  printf("\nTest 4: Manual traversal\n");
  t_list *current = head;
  int position = 0;
  while (current != NULL) {
    printf("Node %d: data->%s\tnext->%p\n", position, (char *)current->data,
           (void *)current->next);
    current = current->next;
    position++;
  }

  printf("\n=== Testing ft_list_size ===\n");
  int count = ft_list_size(head);
  printf("List_size: %d\n", count);

  printf("\n=== Testing ft_list_sort ===\n");
  ft_list_sort(&head, (int (*)())ft_strcmp);
  print_list(head);

  // Clean up (free all nodes)
  while (head != NULL) {
    t_list *temp = head;
    head = head->next;
    free(temp);
  }

  printf("\n=== Testing ft_list_remove_if ===\n");
  t_list *test_list = NULL;
  ft_list_push_front(&test_list, ft_strdup("apple"));
  ft_list_push_front(&test_list, ft_strdup("banana"));
  ft_list_push_front(&test_list, ft_strdup("apple"));
  ft_list_push_front(&test_list, ft_strdup("cherry"));
  ft_list_push_front(&test_list, ft_strdup("apple"));

  printf("Before remove_if:\n");
  print_list(test_list);

  // Remove all "apple" nodes
  ft_list_remove_if(&test_list, "apple", (int (*)())ft_strcmp, free);

  printf("\nAfter removing 'apple':\n");
  print_list(test_list);

  // Clean up remaining nodes
  while (test_list != NULL) {
    t_list *temp = test_list;
    test_list = test_list->next;
    free(temp->data);
    free(temp);
  }

  return 0;
}
