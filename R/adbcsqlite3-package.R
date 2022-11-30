#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @useDynLib adbcsqlite3, .registration = TRUE
## usethis namespace: end
NULL

#' ADBC SQLite3 Driver
#'
#' @return An [radbc::radbc_driver()]
#' @export
#'
#' @examples
#' adbc_driver_sqlite3()
#'
adbc_driver_sqlite3 <- function() {
  radbc::radbc_driver(
    .Call(adbcsqlite3_c_sqlite3),
    subclass = "adbcsqlite3_driver_sqlite3"
  )
}
