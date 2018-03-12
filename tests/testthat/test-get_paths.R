context("get_babette_paths")

test_that("use", {

  testthat::expect_equal(
    c(
      babette::get_babette_path("anthus_aco.fas"),
      babette::get_babette_path("anthus_nd2.fas")
    ),
    babette::get_babette_paths(c("anthus_aco.fas", "anthus_nd2.fas"))
  )

})
