#include "stdio.h"
#include "svdpi.h"
void DumpInfo( void )
{
  svScope scope = svGetScope();
  printf("\n<<MSG>> : C(DumpInfo), %s\n", svGetNameFromScope(scope));
}
