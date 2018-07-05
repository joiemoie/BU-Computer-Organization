#include <stdio.h>

//modified problem1.c code
//int to hex
int main() {
    int a;
    char hex[8];
    char * result = hex;

    scanf("%d", &a);

    for(a; a>0; a/=16) {
      (*result) = (a%16<10)?(a%16+'0'):(a%16+'7');
      result++;
    }
    for(result--; result >= &hex[0]; result--){
      printf("%c", (*result));
    }
    printf("\n");
}
