#include <stdio.h>

int main() {
    int v[] = {0xCAFEBABE, 0xDEADBEEF, 0x0B00B135, 0xBAADF00D, 0xDEADC0DE};
    unsigned char *char_ptr = (unsigned char *) &v;
    unsigned short *short_ptr = (unsigned short *) &v;
    unsigned int *int_ptr = (unsigned int *) &v;

    for (int i = 0 ; i < sizeof(v) / sizeof(*char_ptr); ++i) {
        printf("%p -> 0x%x\n", char_ptr, *char_ptr);
        ++char_ptr;
    }
    printf("-------------------------------\n");

    for (int i = 0 ; i < sizeof(v) / sizeof(*short_ptr); ++i) {
        printf("%p -> 0x%x\n", short_ptr, *short_ptr);
        ++short_ptr;
    }
    printf("-------------------------------\n");

    for (int i = 0 ; i < sizeof(v) / sizeof(*int_ptr); ++i) {
        printf("%p -> 0x%x\n", int_ptr, *int_ptr);
        ++int_ptr;
    }

    return 0;
}
