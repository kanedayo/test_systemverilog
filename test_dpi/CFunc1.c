#include "stdio.h"
int CFunc_x2( const int c_value )
{
  int new_value;
  new_value = c_value * 2;
  printf("<<MSG>> : CFunc_x2, c_value = %d, new_value = %d\n", c_value, new_value );
  return new_value;
}
