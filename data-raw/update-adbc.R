
curl::curl_download(
  "https://github.com/apache/arrow-adbc/archive/3b11e33096de8c50f72762139c4258b9884de325.zip",
  "data-raw/adbc.zip"
)

unzip("data-raw/adbc.zip", exdir = "data-raw")
adbc_dir <- list.files("data-raw", "^arrow-adbc-", full.names = TRUE)
stopifnot(length(adbc_dir) == 1 && dir.exists(adbc_dir))

unlink("src/sqlite", recursive = TRUE)
fs::dir_copy(file.path(adbc_dir, "c/driver/sqlite"), "src")
fs::file_copy(file.path(adbc_dir, "adbc.h"), "src/sqlite")
fs::file_copy(file.path(adbc_dir, c("c/vendor/nanoarrow/nanoarrow.c", "c/vendor/nanoarrow/nanoarrow.h")), "src/sqlite")
