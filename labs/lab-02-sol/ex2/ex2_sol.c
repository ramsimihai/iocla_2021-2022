#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>

char* delete_first(char *s, char *pattern) {
    char *found = strstr(s, pattern);

    if (!found) {
    	return strdup(s);
    }

    int nbefore = found - s;
    int nremoved = strlen(pattern);
    char *result = malloc(strlen(s) + 1 - nremoved);
    assert(result != NULL);

    strncpy(result, s, nbefore);
    strcpy(result + nbefore, found + nremoved);

    return result;
}

int main() {
	char *s = "Ana are mere";
	char *pattern = "re";

	printf("%s\n", delete_first(s, pattern));
	
	return 0;
}
