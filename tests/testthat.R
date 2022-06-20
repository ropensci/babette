library(testthat)
library(babette)

# Make sure no temp files are left undeleted
beastier::remove_beaustier_folders()
beastier::check_empty_beaustier_folders()

test_check("babette")

beastier::remove_beaustier_folders()
beastier::check_empty_beaustier_folders()
