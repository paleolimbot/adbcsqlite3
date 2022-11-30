
test_that("adbcsqlite3() works", {
  expect_s3_class(adbcsqlite3(), "radbc_driver")
})
