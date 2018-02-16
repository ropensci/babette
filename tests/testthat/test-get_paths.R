context("get_paths")

test_that("use", {

  testthat::expect_equal(
    c(
      rbeast2::get_path("anthus_aco.fas"),
      rbeast2::get_path("anthus_nd2.fas")
    ),
    rbeast2::get_paths(c("anthus_aco.fas", "anthus_nd2.fas"))
  )

})
