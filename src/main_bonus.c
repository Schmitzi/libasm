#include "../inc/libasm.h"
#include <stdio.h>
#include <string.h>

ssize_t writer(const char *msg) { return (ft_write(1, msg, ft_strlen(msg))); }

void print_list(t_list *head) {
  printf("List: ");
  t_list *current = head;
  while (current != NULL) {
    printf("[%s] -> ", (char *)current->data);
    current = current->next;
  }
  printf("NULL\n");
}

// Helper to count nodes
int list_size(t_list *head) {
  int count = 0;
  t_list *current = head;
  while (current != NULL) {
    count++;
    current = current->next;
  }
  return count;
}

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
  free(duped);

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

  printf("=== Testing ft_list_push_front ===\n");
  t_list *head = NULL;

  // Test 1: Push to empty list
  printf("Test 1: Push 'First' to empty list\n");
  ft_list_push_front(&head, "First");
  print_list(head);
  printf("Size: %d\n\n", list_size(head));

  // Test 2: Push another element
  printf("Test 2: Push 'Second' (becomes new head)\n");
  ft_list_push_front(&head, "Second");
  print_list(head);
  printf("Size: %d\n\n", list_size(head));

  // Test 3: Push more elements
  printf("Test 3: Push 'Third', 'Fourth', 'Fifth'\n");
  ft_list_push_front(&head, "Third");
  ft_list_push_front(&head, "Fourth");
  ft_list_push_front(&head, "Fifth");

  // Test 4: Verify the order (LIFO)
  printf("Test 4: Verify LIFO order\n");
  printf("Head data: %s (should be 'Fifth')\n", (char *)head->data);
  printf("Second node: %s (should be 'Fourth')\n", (char *)head->next->data);
  printf("Third node: %s (should be 'Third')\n",
         (char *)head->next->next->data);

  // Test 5: Manual traversal
  printf("\nTest 5: Manual traversal\n");
  t_list *current = head;
  int position = 0;
  while (current != NULL) {
    printf("  Node %d: data='%s', next=%p\n", position, (char *)current->data,
           (void *)current->next);
    current = current->next;
    position++;
  }

  // Clean up (free all nodes)
  while (head != NULL) {
    t_list *temp = head;
    head = head->next;
    free(temp);
  }

  return 0;
}
