// Example 2: Bidirectional Communication with a Subprocess
#define SUBPROCESS_IMPLEMENTATION
#include <stdio.h>
#include <stdlib.h>
#include <subprocess.h>

int main() {
  const char *command_line[] = {"python", "-c",
                                "import sys; print(sys.stdin.read())", NULL};
  struct subprocess_s subprocess;

  // Create the subprocess
  if (subprocess_create(command_line, subprocess_option_enable_async,
                        &subprocess) != 0) {
    fprintf(stderr, "Failed to create subprocess.\n");
    return EXIT_FAILURE;
  }

  // Write to the subprocess's stdin
  FILE *p_stdin = subprocess_stdin(&subprocess);
  if (p_stdin == NULL) {
    fprintf(stderr, "Failed to open subprocess stdin.\n");
    subprocess_destroy(&subprocess);
    return EXIT_FAILURE;
  }
  fprintf(p_stdin, "Hello from parent process!\n");
  fclose(p_stdin); // Close stdin to signal EOF

  // Read output from the subprocess
  char buffer[128];
  while (subprocess_read_stdout(&subprocess, buffer, sizeof(buffer)) > 0) {
    printf("Subprocess output: %s", buffer);
  }

  // Wait for the subprocess to finish
  int return_code;
  if (subprocess_join(&subprocess, &return_code) != 0) {
    fprintf(stderr, "Failed to join subprocess.\n");
    subprocess_destroy(&subprocess);
    return EXIT_FAILURE;
  }

  printf("Subprocess exited with code %d\n", return_code);

  // Clean up
  subprocess_destroy(&subprocess);
  return EXIT_SUCCESS;
}
