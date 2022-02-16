#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <stdlib.h>

int my_strcmp(const char *s1, const char *s2) {
	for (; *s1 == *s2 ; ++s1, ++s2){
		if (*s1 == '\0') {
		    return 0;
		}
	}

	return *(const unsigned char *) s1 - *(const unsigned char *) s2;
}

void *my_memcpy(void *dest, const void *src, size_t n) {
	unsigned char *d = (unsigned char *) dest;
	const unsigned char *s = (const unsigned char *) src;

	for (int i = 0 ; i < n ; ++i) {
		*d++ = *s++;
	}

	return dest;
}

char *my_strcpy(char *dest, const char *src) {
	char *old_dest = dest;
	while (*dest++ = *src++);

	return old_dest;
}

int main() {
	char s1[] = "Abracadabra";
	char s2[] = "Abracababra";
	char src[] = "Learn IOCLA, you must!";
	char *dest = malloc(sizeof(src));

	assert(my_strcmp(s1, s2) == strcmp(s1, s2));
	assert(my_memcpy(dest, src, sizeof(src)) == memcpy(dest, src, sizeof(src)));
	assert(my_strcpy(dest, src) == strcpy(dest, src));

	free(dest);

	return 0;
}
