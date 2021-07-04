test_that("use", {
  expect_true(length(create_test_ns_output()) > 100)

  beastier::check_empty_beastier_folder()
  beautier::check_empty_beautier_folder()
})
