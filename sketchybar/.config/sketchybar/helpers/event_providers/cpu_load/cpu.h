#include <mach/mach.h>
#include <stdbool.h>
#include <stdio.h>
#include <unistd.h>

struct cpu {
  host_t host;
  mach_msg_type_number_t count;
  host_cpu_load_info_data_t load;
  host_cpu_load_info_data_t prevLoad;
  bool hasPrevLoad;

  int userLoad;
  int sysLoad;
  int totalLoad;
};

static inline void cpu_init(struct cpu *cpu) {
  cpu->host = mach_host_self();
  cpu->count = HOST_CPU_LOAD_INFO_COUNT;
  cpu->hasPrevLoad = false;
}

static inline void cpu_update(struct cpu *cpu) {
  kern_return_t error = host_statistics(cpu->host, HOST_CPU_LOAD_INFO,
                                        (host_info_t)&cpu->load, &cpu->count);

  if (error != KERN_SUCCESS) {
    printf("Error: Could not read cpu host statistics.\n");
    return;
  }

  if (cpu->hasPrevLoad) {
    uint32_t delta_user = cpu->load.cpu_ticks[CPU_STATE_USER] -
                          cpu->prevLoad.cpu_ticks[CPU_STATE_USER];
    uint32_t delta_system = cpu->load.cpu_ticks[CPU_STATE_SYSTEM] -
                            cpu->prevLoad.cpu_ticks[CPU_STATE_SYSTEM];
    uint32_t delta_idle = cpu->load.cpu_ticks[CPU_STATE_IDLE] -
                          cpu->prevLoad.cpu_ticks[CPU_STATE_IDLE];
    uint32_t delta_total = delta_user + delta_system + delta_idle;

    cpu->userLoad = (double)delta_user / (double)delta_total * 100;
    cpu->sysLoad = (double)delta_system / (double)delta_total * 100;
    cpu->totalLoad = cpu->userLoad + cpu->sysLoad;
  }

  cpu->prevLoad = cpu->load;
  cpu->hasPrevLoad = true;
}
