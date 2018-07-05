#include <stdio.h>

// accepts an integer a, and prints it out in binary.
// notice that the output is reversed - it should be read left to right, not the usual right to left.
int main() {
    int a;
    
    scanf("%d", &a);

    for(int i=0; i<8; i++) {
        int bit = a % 2;
        a = a >> 1;
        printf("%d", bit);
    }

    printf("\n");
}
