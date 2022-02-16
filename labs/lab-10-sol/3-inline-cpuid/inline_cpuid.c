#include <stdio.h>

int main(void)
{
	char cpuid_str[13];

	__asm__ (
	"xor eax, eax\n\t"
	"cpuid\n\t"
	"mov eax, %0\n\t"
	"mov [eax], ebx\n\t"
	"mov [eax+4], edx\n\t"
	"mov [eax+8], ecx\n\t"
	:
	: "r" (cpuid_str)
	: "eax", "ebx", "ecx", "edx"
	);

	cpuid_str[12] = '\0';

	printf("CPUID string: %s\n", cpuid_str);

	return 0;
}
