#include <stdio.h>

void first(unsigned int a, unsigned int b);
size_t second(unsigned int a, unsigned int b);

int main(void)
{
	size_t ret;
	first(501, 499);
	// ret = second(0, 321);
	ret = second(69, 69);
	printf("ret is %zu\n", ret);

	return 0;
}
