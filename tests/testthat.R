library(testthat)
library(babette)

# Make sure no temp files are left undeleted
expect_silent(beautier::check_empty_beautier_folder())
expect_silent(beastier::check_empty_beastier_folder())

test_check("babette")

expect_silent(beautier::check_empty_beautier_folder())
expect_silent(beastier::check_empty_beastier_folder())

# beastierinstall::clear_beautier_cache() ; beastierinstall::clear_beastier_cache() # nolint
unlink(
  dirname(beastier::get_beastier_tempfilename()),
  recursive = TRUE
)
