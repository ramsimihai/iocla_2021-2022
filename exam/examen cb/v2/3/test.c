#include <stdio.h>
#include <string.h>

void barney(unsigned int a);
size_t ted(unsigned int a, unsigned int b);
void robin(unsigned int a, unsigned int b, unsigned int *out, const unsigned char *msg);

static unsigned const char message[30];

int main(void)
{
	unsigned int out[7];
  size_t ret;

	barney(100);
	ret = ted(182, 210);
	printf("ret: %zu\n", ret);
	static unsigned const char my_message[] = "Carrots and peas";
	// printf("[%s]\n",my_message);
	robin(1, 0, out, my_message);

	return 0;
}
