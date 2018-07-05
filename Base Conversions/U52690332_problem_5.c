#include <stdio.h>
#include <stdlib.h>

// binary search
//from https://www.tutorialspoint.com/c_standard_library/c_function_qsort.htm
int cmpfunc (const void * a, const void * b)
{
    return ( *(int*)a - *(int*)b );
}

int binarySearch (int value, int * beginning, int * leftBound, int * rightBound) {
  int distance = (rightBound - leftBound)/2;
  int middleValue = *(leftBound+distance);
  if (middleValue < value) return binarySearch(value,beginning,leftBound+distance,rightBound);
  else if (middleValue == value) {
    int *result = leftBound+distance;
    while ((*result)==value && result>=leftBound){
      result--;
    }
    return result + 1 - beginning;
  }
  else return binarySearch(value, beginning, leftBound, leftBound+distance); 
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
  end = values;
  values = beginning;
  
  qsort(values,a,sizeof(int),cmpfunc);

  int searchValue;
  scanf("%d",&searchValue);
  values = beginning;
  printf("%d",binarySearch(searchValue,beginning, beginning, end));
  free(values);
  printf("\n");
}
