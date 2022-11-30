
<!-- README.md is generated from README.Rmd. Please edit that file -->

# adbcsqlite3

<!-- badges: start -->

[![R-CMD-check](https://github.com/paleolimbot/adbcsqlite3/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/paleolimbot/adbcsqlite3/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of adbcsqlite3 is to wrap the
[ADBC](https://github.com/apache/arrow-adbc) [sqlite
driver](https://github.com/apache/arrow-adbc/tree/main/c/driver/sqlite).

## Installation

You can install the development version of adbcsqlite3 from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("paleolimbot/adbcsqlite3")
```

## Example

Very minimal example:

``` r
library(adbcsqlite3)
library(radbc)

db <- radbc_database_init(adbcsqlite3())
con <- radbc_connection_init(db)

radbc_statement_init(con) |> 
  radbc_statement_set_sql_query(
    "CREATE TABLE crossfit (exercise TEXT, difficulty_level INTEGER)"
  ) |> 
  radbc_statement_execute_query() |> 
  as.data.frame()
#> data frame with 0 columns and 0 rows

stmt <- radbc_statement_init(con) |> 
  radbc_statement_set_sql_query(
    "INSERT INTO crossfit values
      ('Push Ups', 3),
      ('Pull Ups', 5),
      ('Push Jerk', 7),
      ('Bar Muscle Up', 10);"
  ) |> 
  radbc_statement_execute_query() |> 
  as.data.frame()

radbc_statement_init(con) |> 
  radbc_statement_set_sql_query(
    "SELECT * from crossfit"
  ) |> 
  radbc_statement_execute_query() |> 
  as.data.frame()
#>        exercise difficulty_level
#> 1      Push Ups                3
#> 2      Pull Ups                5
#> 3     Push Jerk                7
#> 4 Bar Muscle Up               10
```
