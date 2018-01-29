context("get_paths")

test_that("use", {

  testthat::expect_equal(
    c(
      beautier::get_path("anthus_nd2.fas"),
      beautier::get_path("anthus_nd3.fas")
    ),
    beautier::get_paths(c("anthus_nd2.fas", "anthus_nd3.fas"))
  )

})
