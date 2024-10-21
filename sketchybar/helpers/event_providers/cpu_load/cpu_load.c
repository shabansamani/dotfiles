#include "../sketchybar.h"
#include "cpu.h"
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  float update_freq;
  if (argc < 3 || (sscanf(argv[2], "%f", &update_freq) != 1)) {
    printf("Usage: %s \"<event-name\" \"<event_freq>\"\n", argv[0]);
    exit(EXIT_FAILURE);
  }

  alarm(0);
  struct cpu cpu;
  cpu_init(&cpu);

  char event_message[512];
  snprintf(event_message, 512, "--add event '%s'", argv[1]);
  sketchybar(event_message);

  char trigger_message[512];
  for (;;) {
    cpu_update(&cpu);

    snprintf(trigger_message, 512,
             "--trigger '%s' user_load='%d' sys_load='%02d' total_load='%02d'",
             argv[1], cpu.userLoad, cpu.sysLoad, cpu.totalLoad);

    sketchybar(trigger_message);

    usleep(update_freq * 1000000);
  }
  return EXIT_SUCCESS;
}
