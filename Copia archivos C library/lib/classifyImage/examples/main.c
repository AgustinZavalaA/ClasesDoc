/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * main.c
 *
 * Code generation for function 'main'
 *
 */

/*************************************************************************/
/* This automatically generated example C main file shows how to call    */
/* entry-point functions that MATLAB Coder generated. You must customize */
/* this file for your application. Do not modify this file directly.     */
/* Instead, make a copy of this file, modify it, and integrate it into   */
/* your development environment.                                         */
/*                                                                       */
/* This file initializes entry-point function arguments to a default     */
/* size and value before calling the entry-point functions. It does      */
/* not store or use any values returned from the entry-point functions.  */
/* If necessary, it does pre-allocate memory for returned values.        */
/* You can use this file as a starting point for a main function that    */
/* you can deploy in your application.                                   */
/*                                                                       */
/* After you copy the file, and before you deploy it, you must make the  */
/* following changes:                                                    */
/* * For variable-size function arguments, change the example sizes to   */
/* the sizes that your application requires.                             */
/* * Change the example values of function arguments to the values that  */
/* your application requires.                                            */
/* * If the entry-point functions return values, store these values or   */
/* otherwise use them as required by your application.                   */
/*                                                                       */
/*************************************************************************/

/* Include files */
#include "main.h"
#include "classifyImage.h"
#include "classifyImage_terminate.h"

/* Function Declarations */
static void argInit_190x1_real_T(double result[190]);

static void argInit_50x50x3_uint8_T(unsigned char result[7500]);

static double argInit_real_T(void);

static unsigned char argInit_uint8_T(void);

static void main_classifyImage(void);

/* Function Definitions */
static void argInit_190x1_real_T(double result[190])
{
  int idx0;
  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 190; idx0++) {
    /* Set the value of the array element.
Change this value to the value that the application requires. */
    result[idx0] = argInit_real_T();
  }
}

static void argInit_50x50x3_uint8_T(unsigned char result[7500])
{
  int idx0;
  int idx1;
  int idx2;
  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 50; idx0++) {
    for (idx1 = 0; idx1 < 50; idx1++) {
      for (idx2 = 0; idx2 < 3; idx2++) {
        /* Set the value of the array element.
Change this value to the value that the application requires. */
        result[(idx0 + 50 * idx1) + 2500 * idx2] = argInit_uint8_T();
      }
    }
  }
}

static double argInit_real_T(void)
{
  return 0.0;
}

static unsigned char argInit_uint8_T(void)
{
  return 0U;
}

static void main_classifyImage(void)
{
  double dv[190];
  double a;
  unsigned char uv[7500];
  /* Initialize function 'classifyImage' input arguments. */
  /* Initialize function input argument 'myNetwork'. */
  /* Initialize function input argument 'myImage'. */
  /* Call the entry-point 'classifyImage'. */
  argInit_190x1_real_T(dv);
  argInit_50x50x3_uint8_T(uv);
  a = classifyImage(dv, uv);
}

int main(int argc, char **argv)
{
  (void)argc;
  (void)argv;
  /* The initialize function is being called automatically from your entry-point
   * function. So, a call to initialize is not included here. */
  /* Invoke the entry-point functions.
You can call entry-point functions multiple times. */
  main_classifyImage();
  /* Terminate the application.
You do not need to do this more than one time. */
  classifyImage_terminate();
  return 0;
}

/* End of code generation (main.c) */
