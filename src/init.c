#define R_NO_REMAP
#include <R.h>
#include <Rinternals.h>

#include <adbc.h>

AdbcStatusCode SqliteDriverInit(int version, void* raw_driver, struct AdbcError* error);

static SEXP init_func_xptr = 0;

SEXP adbcsqlite3_c_sqlite3(void) {
  return init_func_xptr;
}

static const R_CallMethodDef CallEntries[] = {
  {"adbcsqlite3_c_sqlite3", (DL_FUNC)&adbcsqlite3_c_sqlite3, 0},
  {NULL, NULL, 0}};

void R_init_adbcsqlite3(DllInfo* dll) {
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);

  init_func_xptr = PROTECT(R_MakeExternalPtrFn((DL_FUNC)SqliteDriverInit, R_NilValue, R_NilValue));
  Rf_setAttrib(init_func_xptr, R_ClassSymbol, Rf_mkString("radbc_driver_init_func"));
  R_PreserveObject(init_func_xptr);
  UNPROTECT(1);
}
