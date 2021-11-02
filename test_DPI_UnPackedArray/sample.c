#include <stdio.h>
#include "sample.h"

void set_fixed1(RGB_TYPE *mem){
  for (int m=0;m<10;m++){
    printf("mem1[%3d]={%2x,%2x, %2x}\n",
        m,
        mem[m].red,
        mem[m].green,
        mem[m].blue);
  }
}
void set_fixed2(RGB_TYPE *mem ){
  for (int m=0;m<10;m++){
    for (int n=0;n<2;n++){
      printf("mem2[%3d][%3d]={%2x,%2x, %2x}\n",
          m,n,
          mem[m*2+n].red,
          mem[m*2+n].green,
          mem[m*2+n].blue);
    }
  }
}

void set_fixed3(RGB_TYPE *mem){
  for (int m=0;m<10;m++){
    for (int n=0;n <2;n++){
      for (int i=0;i<2;i++){
        printf("mem3[%3d][%3d][%3d]={%2x,%2x, %2x}\n",
            m,n,i,
            mem[m*4+2*n+i].red,
            mem[m*4+2*n+i].green,
            mem[m*4+2*n+i].blue);
      }
    }
  }
}
