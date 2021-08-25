/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_classifyImage_api.c
 *
 * Code generation for function 'classifyImage'
 *
 */

/* Include files */
#include "_coder_classifyImage_api.h"
#include "_coder_classifyImage_mex.h"

/* Variable Definitions */
emlrtCTX emlrtRootTLSGlobal = NULL;

emlrtContext emlrtContextGlobal = {
    true,                                                 /* bFirstTime */
    false,                                                /* bInitialized */
    131610U,                                              /* fVersionInfo */
    NULL,                                                 /* fErrorFunction */
    "classifyImage",                                      /* fFunctionName */
    NULL,                                                 /* fRTCallStack */
    false,                                                /* bDebugMode */
    {2045744189U, 2170104910U, 2743257031U, 4284093946U}, /* fSigWrd */
    NULL                                                  /* fSigMem */
};

/* Function Declarations */
static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId))[190];

static uint8_T (*c_emlrt_marshallIn(const emlrtStack *sp,
                                    const mxArray *myImage,
                                    const char_T *identifier))[7500];

static uint8_T (*d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId))[7500];

static real_T (*e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                   const emlrtMsgIdentifier *msgId))[190];

static real_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *myNetwork,
                                 const char_T *identifier))[190];

static const mxArray *emlrt_marshallOut(const real_T u);

static uint8_T (*f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                    const emlrtMsgIdentifier *msgId))[7500];

/* Function Definitions */
static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId))[190]
{
  real_T(*y)[190];
  y = e_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static uint8_T (*c_emlrt_marshallIn(const emlrtStack *sp,
                                    const mxArray *myImage,
                                    const char_T *identifier))[7500]
{
  emlrtMsgIdentifier thisId;
  uint8_T(*y)[7500];
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = d_emlrt_marshallIn(sp, emlrtAlias(myImage), &thisId);
  emlrtDestroyArray(&myImage);
  return y;
}

static uint8_T (*d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId))[7500]
{
  uint8_T(*y)[7500];
  y = f_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T (*e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                   const emlrtMsgIdentifier *msgId))[190]
{
  static const int32_T dims = 190;
  real_T(*ret)[190];
  emlrtCheckBuiltInR2012b((emlrtCTX)sp, msgId, src, (const char_T *)"double",
                          false, 1U, (void *)&dims);
  ret = (real_T(*)[190])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static real_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *myNetwork,
                                 const char_T *identifier))[190]
{
  emlrtMsgIdentifier thisId;
  real_T(*y)[190];
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(sp, emlrtAlias(myNetwork), &thisId);
  emlrtDestroyArray(&myNetwork);
  return y;
}

static const mxArray *emlrt_marshallOut(const real_T u)
{
  const mxArray *m;
  const mxArray *y;
  y = NULL;
  m = emlrtCreateDoubleScalar(u);
  emlrtAssign(&y, m);
  return y;
}

static uint8_T (*f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                    const emlrtMsgIdentifier *msgId))[7500]
{
  static const int32_T dims[3] = {50, 50, 3};
  uint8_T(*ret)[7500];
  emlrtCheckBuiltInR2012b((emlrtCTX)sp, msgId, src, (const char_T *)"uint8",
                          false, 3U, (void *)&dims[0]);
  ret = (uint8_T(*)[7500])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

void classifyImage_api(const mxArray *const prhs[2], const mxArray **plhs)
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  real_T(*myNetwork)[190];
  real_T a;
  uint8_T(*myImage)[7500];
  st.tls = emlrtRootTLSGlobal;
  /* Marshall function inputs */
  myNetwork = emlrt_marshallIn(&st, emlrtAlias(prhs[0]), "myNetwork");
  myImage = c_emlrt_marshallIn(&st, emlrtAlias(prhs[1]), "myImage");
  /* Invoke the target function */
  a = classifyImage(*myNetwork, *myImage);
  /* Marshall function outputs */
  *plhs = emlrt_marshallOut(a);
}

void classifyImage_atexit(void)
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  classifyImage_xil_terminate();
  classifyImage_xil_shutdown();
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

void classifyImage_initialize(void)
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, NULL);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

void classifyImage_terminate(void)
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (_coder_classifyImage_api.c) */
