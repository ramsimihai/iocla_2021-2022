#include <stdio.h>

extern void vuln(int sexy_arg);

int main(void)
{
	vuln(2);

	return 0;
}