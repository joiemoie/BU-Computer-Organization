#include <stdio.h>

//binary to int
int main() {
    char binary[8];
    int result = 0;
    scanf("%s", binary);
    int highestBit = 128;
    result -= highestBit*(binary[0]-'0');
    highestBit/=2;
    for(int i = 1; i < 8; i++) {
      result+=highestBit*(binary[i]-'0');
      highestBit/=2;
    }
    printf("%d", result);
    printf("\n");
}
