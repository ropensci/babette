test_that("use", {
  expect_true(length(create_test_ns_output()) > 100)

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})
