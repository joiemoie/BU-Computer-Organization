#include <stdio.h>

//float to binary

//reversed binary
char * int2binary(int integer, char * binary) {
  int value = integer;
  char * ptr = binary;
  for(value; value>0; value/=2) {
    (*ptr) = '0' + value % 2;
    ptr++;
  }
  ptr--;
  return ptr;
}

int main() {
  char decimal[32];
  scanf("%s", decimal);
  char floating[32];
  char * ptr;
  char * decimalBeginning = &decimal[0];
  if (decimal[0] == '-') {
    floating[0] = '1';
    decimalBeginning = &decimal[1];
  }
  else floating[0] = '0';
  ptr = decimalBeginning;
  int wholeNum = 0;
  while((*ptr)!='.' && (*ptr)!=0){
    ptr++;

  }
  char * decimalPtr = ptr + 1;
  ptr--;


  int powOfTen = 1;
  for(ptr; ptr >= decimalBeginning; ptr--) {
    wholeNum+=powOfTen * ((*ptr)-'0');
    powOfTen*=10;
  }
  char wholeNums[23];
  char * wholeNumsEnd = int2binary(wholeNum, wholeNums);

  long double decimalMantissa = 0;
  long double decimalPowOfTen = .1;
  ptr = decimalPtr;
  for(ptr; *ptr != 0; ptr++) {
    decimalMantissa+=decimalPowOfTen * ((*ptr)-'0');
    decimalPowOfTen/=10;

  }
  char mantissa[23];
  for (int i = 0; i < 23; i++) {
    decimalMantissa*=2;
    if (decimalMantissa >= 1) {
      decimalMantissa -=1;
      mantissa[i] = '1';
    }
    else mantissa[i] = '0';
  }
  printf("%c",'\n');
  char * mantissaPtr = &floating[9];
  int exp = 0;
  if (*wholeNumsEnd!=0) {
    ptr = wholeNumsEnd-1;
    
    for (ptr; ptr >= wholeNums; ptr--){
      *mantissaPtr = *ptr;
      mantissaPtr++;
      exp++;
    }
    ptr = mantissa;
    for (ptr; *ptr != 0; ptr++){
      *mantissaPtr = *ptr;
      mantissaPtr++;
    }
  }
  else {
    exp--;
    ptr = mantissa;
    while (*ptr!='1') {
      ptr++;
      exp--;
    }
    ptr++;
    mantissaPtr = &floating[9];
    while (mantissaPtr<=&floating[32]) {
      if(ptr < &mantissa[22]) 
      {
        *mantissaPtr = *ptr;
        ptr++;
        mantissaPtr++;
      }
      else { 
        *mantissaPtr = '0';
        mantissaPtr++;
      }
    }
  }
  
  exp += 127;
  char exponent[8];

  char * exponentEnd = int2binary(exp, exponent);
  
  char * exponentPtr = &floating[8];
  for (ptr = exponent; exponentPtr >= &floating[1]; ptr++){
    if (ptr <= exponentEnd) {
      *exponentPtr = *ptr;
      exponentPtr--;
    }
    else {
      *exponentPtr = '0';
      exponentPtr--;
    }
  }

  ptr = &floating[0];
  for(ptr; ptr < &floating[1]; ptr++){
    printf("%c",*ptr);  
  }
  printf("%c", ' ');
  for(ptr; ptr < &floating[9]; ptr++){
    printf("%c",*ptr);  
  }
  printf("%c", ' ');
  for(ptr; ptr < &floating[32]; ptr++){
    printf("%c",*ptr);  
  }

  printf("\n");
}
