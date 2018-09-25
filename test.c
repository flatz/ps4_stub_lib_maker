#include "common.h"

struct {
	int a;
	int b;
} global_var_1;

EXPORT_OBJ(unsigned long long global_var_2);

EXPORT_FUN(int test_func_1(void));
EXPORT_FUN(int test_func_2(void));

EXPORT_FUN(int $(sceKernelOpen, 0xD46DE51751A0D64F)(const char* path, int mode, ...));
