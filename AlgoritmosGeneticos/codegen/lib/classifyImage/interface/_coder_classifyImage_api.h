/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_classifyImage_api.h
 *
 * Code generation for function 'classifyImage'
 *
 */

#ifndef _CODER_CLASSIFYIMAGE_API_H
#define _CODER_CLASSIFYIMAGE_API_H

/* Include files */
#include "emlrt.h"
#include "tmwtypes.h"
#include <string.h>

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

#ifdef __cplusplus
extern "C" {
#endif

/* Function Declarations */
real_T classifyImage(real_T myNetwork[190], uint8_T myImage[7500]);

void classifyImage_api(const mxArray *const prhs[2], const mxArray **plhs);

void classifyImage_atexit(void);

void classifyImage_initialize(void);

void classifyImage_terminate(void);

void classifyImage_xil_shutdown(void);

void classifyImage_xil_terminate(void);

#ifdef __cplusplus
}
#endif

#endif
/* End of code generation (_coder_classifyImage_api.h) */
