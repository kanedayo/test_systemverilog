#include <stdio.h>
typedef struct{
  char f1;
  int f2;
} s1;
void SimpleFcn(const s1 * in, s1 * out)
{
  printf("In the C funciton the struct in has f1: %d\n",in->f1);
  printf("In the C funciton the struct in has f2: %d\n",in->f2);
  //out->f1=!(in->f1);
  //out->f2=!(in->f2);
  out->f1=!(in->f1);
  out->f2= (in->f2)+100;
}
