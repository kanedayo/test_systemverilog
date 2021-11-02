#include <stdio.h>
#include <complex.h>
#include "matrix.h"
#include <math.h>
#include "libplot_iq.h"

int plot_iq_init(void)
{
  if( !mclInitializeApplication(NULL,0) )
  {
    fprintf(stderr, "Could not initialize the application.\n");
    return -1;
  }
  if (!libplot_iqInitialize()){
    fprintf(stderr,"Could not initialize the library.\n");
    return -2;
  }
  return 0;
}
int plot_iq_term(void)
{
  mclWaitForFiguresToDie(NULL);
  mclTerminateApplication();
  printf("[INFO]:plot_iq:Done!!\n");
  return 0;
}

int plot_iq(double complex * matC, const int len)
{

  mxArray *mxC;
  mxC = mxCreateDoubleMatrix(len,1,mxCOMPLEX);
#if 0
  // cf. http://nalab.mind.meiji.ac.jp/~mk/labo/text/complex-c.pdf
  mxComplexDouble *d = mxGetData(mxC);
  for(int i=0; i<len; i++)
  {
    //d[i].real = __real__ matC[i];
    //d[i].imag = __imag__ matC[i];
    d[i] = (mxComplexDouble){__real__ matC[i],__imag__ matC[i]};
  }
#else
  double complex *d = mxGetData(mxC);
  for(int i=0; i<len; i++)
  {
    d[i] = matC[i];
  }
#endif

  mlfPlot_iq(mxC);

  mxDestroyArray(mxC); mxC = NULL;

  return 0;
}

int dump_real_imag(double *re, double *im, const int len)
{
  for(int i=0; i<len; i++){
    printf("(re,im)[%2d]=(%+f,%+f)\n", i, re[i], im[i]);
  }
  return 0;
}

int plot_real_imag(double *re, double *im, const int len)
{
  mxArray *mxC;
  mxC = mxCreateDoubleMatrix(len,1,mxCOMPLEX);

  mxComplexDouble *d = mxGetData(mxC);
  for(int i=0; i<len; i++)
  {
    //d[i].real = re[i];
    //d[i].imag = im[i];
    d[i] = (mxComplexDouble){re[i],im[i]};
  }

  mlfPlot_iq(mxC);

  mxDestroyArray(mxC); mxC = NULL;


  return 0;
}

#define MATCLEN 10
int main(void)
{
  (void)plot_iq_init();

  int len = MATCLEN;
  //double complex matC[MATCLEN];
  double re[MATCLEN],im[MATCLEN];
  for(int i=0; i<len; i++)
  {
    //matC[i] = i + (i * 1.0J);
    re[i] = i;
    im[i] = i;
  }

  //plot_iq( matC, 10 ); // GUI TEST
  dump_real_imag( re, im, len ); // CLI TEST

  (void)plot_iq_term();

  return 0;
}
