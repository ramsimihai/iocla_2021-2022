#include <stdio.h>

void first(unsigned int a, unsigned int b);
size_t second(unsigned int a, unsigned int b);

int main(void)
{
	size_t ret;
	first(500, 0);
	ret = second(0, 0);
	printf("ret is %zu\n", ret);

	return 0;
}
