#include <stdio.h>

void joey(unsigned int a);
size_t chandler(unsigned int a, unsigned int b);
void ross(unsigned int a, unsigned int b, unsigned int *out, const unsigned char *msg);

static unsigned const char message[] = "Unagi is a total state of awareness";

int main(void)
{
	unsigned int out[7];
  size_t ret;

	joey(9);
// param 1 + param 2 = 262
	ret = chandler(162, 100);
	printf("ret: %zu\n", ret);
	
	ross(4,3 , out, message);

	return 0;
}
