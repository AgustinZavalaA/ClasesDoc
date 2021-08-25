/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * classifyImage.c
 *
 * Code generation for function 'classifyImage'
 *
 */

/* Include files */
#include "classifyImage.h"
#include <math.h>
#include <string.h>

/* Function Definitions */
double classifyImage(const double myNetwork[190],
                     const unsigned char myImage[7500])
{
  double x[7500];
  double b_myNetwork[160];
  double pp[16];
  double b_v5_tmp;
  double v5;
  double v6;
  double v7;
  int b_v1;
  int b_v2;
  int v1;
  int v2;
  int v3;
  int v5_tmp;
  int v5_tmp_tmp;
  int v8;
  for (v8 = 0; v8 < 7500; v8++) {
    x[v8] = (double)myImage[v8] / 255.0 - 0.5;
  }
  /* variables */
  /* init stage 1 */
  for (v1 = 0; v1 < 23; v1++) {
    b_v1 = (v1 << 1) + 2;
    for (v2 = 0; v2 < 23; v2++) {
      b_v2 = (v2 << 1) + 2;
      v5 = 0.0;
      v6 = 0.0;
      v7 = 0.0;
      v8 = 181;
      /* for v3 = 1:maskH */
      /* for v4 = 1:maskW */
      for (v3 = 0; v3 < 3; v3++) {
        v5_tmp_tmp = b_v1 + v3;
        v5_tmp = v5_tmp_tmp + 50 * (b_v2 - 1);
        v5 += x[v5_tmp - 1] * myNetwork[v8];
        v6 += x[v5_tmp + 2499] * myNetwork[v8];
        v7 += x[v5_tmp + 4999] * myNetwork[v8];
        v5_tmp = v5_tmp_tmp + 50 * b_v2;
        b_v5_tmp = myNetwork[v8 + 1];
        v5 += x[v5_tmp - 1] * b_v5_tmp;
        v6 += x[v5_tmp + 2499] * b_v5_tmp;
        v7 += x[v5_tmp + 4999] * b_v5_tmp;
        v5_tmp = v5_tmp_tmp + 50 * (b_v2 + 1);
        b_v5_tmp = myNetwork[v8 + 2];
        v5 += x[v5_tmp - 1] * b_v5_tmp;
        v6 += x[v5_tmp + 2499] * b_v5_tmp;
        v7 += x[v5_tmp + 4999] * b_v5_tmp;
        v8 += 3;
      }
      v8 = b_v1 + 50 * b_v2;
      x[v8] = v5;
      x[v8 + 2500] = v6;
      x[v8 + 5000] = v7;
    }
  }
  /* tabla de 4 x 4 */
  memset(&pp[0], 0, 16U * sizeof(double));
  v8 = 0;
  for (v1 = 0; v1 < 4; v1++) {
    b_v1 = v1 * 12;
    for (v2 = 0; v2 < 4; v2++) {
      b_v2 = v2 * 12;
      v5 = x[b_v1 + 50 * b_v2];
      for (v3 = 2; v3 < 433; v3++) {
        v5 += x[((b_v1 + (v3 - 1) % 12) + 50 * (b_v2 + (v3 - 1) / 12 % 12)) +
                2500 * ((v3 - 1) / 144)];
      }
      pp[v8 + v2] = v5;
    }
    v8 += 4;
  }
  /*  end stage 1 */
  for (v8 = 0; v8 < 16; v8++) {
    pp[v8] *= 0.01;
  }
  memcpy(&b_myNetwork[0], &myNetwork[0], 160U * sizeof(double));
  v5 = 0.0;
  for (v3 = 0; v3 < 10; v3++) {
    v6 = 0.0;
    for (v8 = 0; v8 < 16; v8++) {
      v6 += b_myNetwork[v3 + 10 * v8] * pp[v8];
    }
    v5 +=
        myNetwork[v3 + 160] * (1.0 / (exp(-(v6 + myNetwork[v3 + 170])) + 1.0));
  }
  return v5 + myNetwork[180];
}

/* End of code generation (classifyImage.c) */
