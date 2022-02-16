#include <stdio.h>

#define NUM	0x12345678

int main(void)
{
	size_t n = NUM;
	size_t rot_left;
	size_t rot_right;

	__asm__ (
	"mov eax, %2\n\t"
	"rol eax, 8\n\t"
	"mov %0, eax\n\t"

	"mov eax, %2\n\t"
	"ror eax, 8\n\t"
	"mov %1, eax\n\t"
	: "=r" (rot_left), "=r" (rot_right)
	: "r" (n)
	: "eax"
	);

	printf("init: 0x%08x, rot_left: 0x%08x, rot_right: 0x%08x\n",
			n, rot_left, rot_right);

	return 0;
}
