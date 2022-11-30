
test_that("adbcsqlite3() works", {
  expect_s3_class(adbcsqlite3(), "radbc_driver")
})

test_that("default options can open a database and execute a query", {
  db <- radbc::radbc_database_init(adbcsqlite3())
  con <- radbc::radbc_connection_init(db)

  stmt <- radbc::radbc_statement_init(con)
  radbc::radbc_statement_set_sql_query(
    stmt,
    "CREATE TABLE crossfit (exercise TEXT, difficulty_level INTEGER)"
  )
  radbc::radbc_statement_execute_query(stmt)$release()
  radbc::radbc_statement_release(stmt)

  stmt <- radbc::radbc_statement_init(con)
  radbc::radbc_statement_set_sql_query(
    stmt,
    "INSERT INTO crossfit values
      ('Push Ups', 3),
      ('Pull Ups', 5),
      ('Push Jerk', 7),
      ('Bar Muscle Up', 10);"
  )
  radbc::radbc_statement_execute_query(stmt)$release()
  radbc::radbc_statement_release(stmt)

  stmt <- radbc::radbc_statement_init(con)
  radbc::radbc_statement_set_sql_query(
    stmt,
    "SELECT * from crossfit"
  )

  expect_identical(
    as.data.frame(radbc::radbc_statement_execute_query(stmt)),
    data.frame(
      exercise = c("Push Ups", "Pull Ups", "Push Jerk", "Bar Muscle Up"),
      difficulty_level = c(3, 5, 7, 10),
      stringsAsFactors = FALSE
    )
  )

  radbc::radbc_statement_release(stmt)
  radbc::radbc_connection_release(con)
  radbc::radbc_database_release(db)
})
