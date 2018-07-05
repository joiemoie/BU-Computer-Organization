#include <stdio.h>

//fibonacci
int main() {
  int a;
  int prev = 1, result = 1;
  scanf("%d", &a);
  for(int i = 3; i <= a; i++){
    result += prev;
    prev = result - prev;
  }
  if (a == 0) result = 0;
  printf("%d", result);
  
  printf("\n");
}
