#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>

extern int solve(int64_t *args, size_t argc);
extern int solve_2(int64_t *args, size_t argc);

int main() {
  int64_t nums[2048];
  size_t i = 0;
  while (!feof(stdin) && scanf("%" SCNd64 "\n", &nums[i++]) != EOF)
    ;
#ifndef PART_2
  printf("part 1: %d\n", solve(nums, i));
#else
  printf("part 2: %d\n", solve_2(nums, i));
#endif
  return 0;
}
