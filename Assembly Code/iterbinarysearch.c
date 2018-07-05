#include <stdio.h>
#include <stdlib.h>

//from https://www.tutorialspoint.com/c_standard_library/c_function_qsort.htm
int cmpfunc (const void * a, const void * b)
{
    return ( *(int*)a - *(int*)b );
}

int binarySearch (int value, int * beginning, int size) {
  int i = size/2, leftBound = 0, rightBound = size;
  while (*(beginning+i) != value && (rightBound - leftBound) > 1) {
    if (*(beginning+i) < value) {
      leftBound = i;
      i = (rightBound+leftBound)/2;
    }
    else {
      rightBound = i;
      i = (rightBound+leftBound)/2;
    }
  }
  return i;
}


int main() {
  int a;
  scanf("%d", &a);
  int * values;
  int * beginning;
  int * end;
  values = (int*)malloc(a);
  beginning = values;
  for (int i = 0; i < a; i++, values++) {
    scanf("%d", values);
  }
  values = beginning;
  

  int searchValue;
  scanf("%d",&searchValue);
  printf("%d",binarySearch(searchValue,beginning, a));
  free(values);
  printf("\n");
}
