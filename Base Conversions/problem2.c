#include <stdio.h>

// First accepts the size of the array, then that many array values.
// Prints out the reversed array.
int main() {
    int size;
    int array[size];
    
    scanf("%d", &size);

    for(int i=0; i<size; i++) {
        scanf("%d", &array[i]);
    }

    for(int i=size-1; i>=0; i--) {
        printf("%d ", array[i]);
    }

    printf("\n");
}
