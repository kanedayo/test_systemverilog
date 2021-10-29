module test;
  typedef struct   {
    byte red;
    byte green;
    byte blue;
  } RGB_TYPE;

  import "DPI-C" function void set_fixed1(inout RGB_TYPE mem [10:1  ]);
  import "DPI-C" function void set_fixed2(inout RGB_TYPE mem [10:1][3:2  ]);
  import "DPI-C" function void set_fixed3(inout RGB_TYPE mem [10:1][3:2][4:3  ]);

  RGB_TYPE m1[10:1];
  RGB_TYPE m2 [10:1][3:2];
  RGB_TYPE m3 [10:1][3:2][4:3];

  initial begin
    //1-D
    for (int i=1;i<=10;i++) begin
      m1[i].red=i;
      m1[i].green=i+1;
      m1[i].blue=i+2;
    end
    set_fixed1(m1);

    //2-D
    for (int m=1;m<=10;m++) 
      for (int n=2;n<=3;n++) begin
        m2[m][n].red=m<<3 | n;
        m2[m][n].green=m<<3 |  n+1;
        m2[m][n].blue= m<< 3| n+2;
      end
    set_fixed2(m2);

    //3-D
    for (int m=1;m<=10;m++) 
      for (int n=2;n<=3;n++) 
        for (int i=3;i<=4;i++) begin
          m3[m][n][i].red=m<< 4 | n<<3 | i;
          m3[m][n][i].green=m<<4 | n<<3 | i+1;
          m3[m][n][i].blue= m<< 4 | n<<3 | i+2;
        end
    set_fixed3(m3);
  end
endmodule
