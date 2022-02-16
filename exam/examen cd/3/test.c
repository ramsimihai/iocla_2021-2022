#include <stdio.h>

void tokyo(unsigned int a);
size_t nairobi(unsigned int a, unsigned int b);
void denver(unsigned int a, unsigned int b, unsigned int *out, const unsigned char *msg);

static unsigned const char message[30];

int main(void)
{
	unsigned int out[7];
  size_t ret;
  	tokyo(20);
	// TODO a: pelati functia tokyo() din fisierul hidden.o astfel ıncat sa se
	//         afiseze mesajul "In the end love is a good thing for everything to fall apart"
	tokyo(0);

	// TODO b: Apelati functia nairobi() din fisierul hidden.o pentru a ıntoarce valoarea 41.
	ret = nairobi(216, 321);
	printf("ret: %zu\n", ret);

	// TODO c:  Apelati functia denver() din fisierul hidden.o pentru a obtine
	//          mesajul "I told her stories and she laughed a lot"
	denver(0, 0x18, out, message);

	return 0;
}
