#include <stdio.h>

void direct(const char *s, unsigned int perturb);
size_t obvious(unsigned int a, unsigned int b);
void crypto(const unsigned char *in, unsigned char *out, size_t len, const unsigned char *key, size_t klen);

int main(void)
{
	unsigned char in[128] = {0x1d,0x06,0x42,0x0f,0x06,0x1b,0x09,0x45,
		0x01,0x10,0x42,0x0a,0x06,0x1c,0x47,0x5e,0x1f,0x0d,0x42,0x01,
		0x0c,0x00};
		// 1d06420f061b09450110420a061c475e1f0d42010c00
	unsigned char out[128] = "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0";
	unsigned char k[16] = "sibling1";
//no country for old men
	direct("bad",700); // >639 sau ceva
	printf("%u\n", obvious(179, 681)); // primul trebuie sa dea rest 0 la impartirea cu 179
	crypto(in, out, 21, k, 8); // efectiv xor encription, googlee it
	printf("%s\n", out);
	
	return 0;
}
