#' @keywords internal
#' @aliases NULL
"_PACKAGE"

## usethis namespace: start
#' @importFrom radbc radbc_database_init
#' @importFrom radbc radbc_connection_init
#' @importFrom radbc radbc_statement_init
#' @useDynLib adbcsqlite3, .registration = TRUE
## usethis namespace: end
NULL

#' ADBC SQLite3 Driver
#'
#' @return An [radbc::radbc_driver()]
#' @export
#'
#' @examples
#' adbcsqlite3()
#'
adbcsqlite3 <- function() {
  radbc::radbc_driver(
    .Call(adbcsqlite3_c_sqlite3),
    subclass = "adbcsqlite3_driver_sqlite3"
  )
}

#' @export
radbc_database_init.adbcsqlite3_driver_sqlite3 <- function(driver, uri = ":memory:") {
  radbc::radbc_database_init_default(
    driver,
    list(uri = uri),
    subclass = "adbcsqlite3_database"
  )
}

#' @export
radbc_connection_init.adbcsqlite3_driver_sqlite3 <- function(database,
                                                             adbc.connection.autocommit = NULL) {
  radbc::radbc_connection_init_default(
    database,
    list(adbc.connection.autocommit = adbc.connection.autocommit),
    subclass = "adbcsqlite3_connection"
  )
}

#' @export
radbc_statement_init.adbcsqlite3_driver_sqlite3 <- function(connection, stream,
                                                            adbc.ingest.target_table = NULL,
                                                            adbc.ingest.mode = NULL,
                                                            adbc.sqlite.query.batch_rows = NULL) {
  radbc::radbc_statement_init_default(
    connection,
    list(
      adbc.ingest.target_table = adbc.ingest.target_table,
      adbc.ingest.mode = adbc.ingest.mode,
      adbc.sqlite.query.batch_rows = adbc.sqlite.query.batch_rows
    ),
    subclass = "adbcsqlite3_statement"
  )
}
