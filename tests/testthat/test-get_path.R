context("get_babette_path")

test_that("use", {

  expect_equal(
    system.file("extdata", "anthus_nd2.fas", package = "babette"),
    get_babette_path("anthus_nd2.fas")
  )

  expect_equal(
    system.file("extdata", "anthus_aco.fas", package = "babette"),
    get_babette_path("anthus_aco.fas")
  )

})

test_that("abuse", {

  expect_error(
    get_babette_path("abs.ent"),
    "'filename' must be the name of a file in 'inst/extdata'"
  )
  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})
