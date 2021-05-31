library(testthat)
library(babette)

test_check("babette")

testthat::expect_equal(
  0,
  length(list.files(rappdirs::user_cache_dir(appname = "beautier")))
)

testthat::expect_equal(
  0,
  length(list.files(rappdirs::user_cache_dir(appname = "beastier")))
)
