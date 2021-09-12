library(testthat)
library(babette)

# Make sure no temp files are left undeleted
beautier::check_empty_beautier_folder()
beastier::check_empty_beastier_folder()

test_check("babette")

beautier::check_empty_beautier_folder()
beastier::check_empty_beastier_folder()
# beastierinstall::clear_beautier_cache() ; beastierinstall::clear_beastier_cache() # nolint
unlink(
  dirname(beastier::get_beastier_tempfilename()),
  recursive = TRUE
)
