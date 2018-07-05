#include <stdio.h>

//modified problem1.c code
// Converts from binary to decimal
int main() {
    int a;
    int binary[32];
    int * result = &binary[0];

    scanf("%d", &a);

    for(a; a>0; a/=2) {
        (*result) = a % 2;
        result++;
    }
    for(result--; result >= &binary[0]; result--){
      printf("%d", (*result));
    }
    printf("\n");
}
