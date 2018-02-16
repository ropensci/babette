context("get_path")

test_that("use", {

  testthat::expect_equal(
    system.file("extdata", "anthus_nd2.fas", package = "rbeast2"),
    rbeast2::get_path("anthus_nd2.fas")
  )

  testthat::expect_equal(
    system.file("extdata", "anthus_aco.fas", package = "rbeast2"),
    rbeast2::get_path("anthus_aco.fas")
  )

})

test_that("abuse", {

  testthat::expect_error(
    rbeast2::get_path("abs.ent"),
    "'filename' must be the name of a file in 'inst/extdata'"
  )

})
