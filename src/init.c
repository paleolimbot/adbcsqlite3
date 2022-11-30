#define R_NO_REMAP
#include <R.h>
#include <Rinternals.h>

SEXP adbcsqlite3_c_init(void) {
  return R_NilValue;
}

static const R_CallMethodDef CallEntries[] = {
  {"adbcsqlite3_c_init", (DL_FUNC)&adbcsqlite3_c_init, 0},
  {NULL, NULL, 0}};

void R_init_adbcsqlite3(DllInfo* dll) {
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
