
test_that("adbc_driver_sqlite3() works", {
  expect_s3_class(adbc_driver_sqlite3(), "radbc_driver")
})
