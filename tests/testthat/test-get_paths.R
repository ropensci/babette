test_that("use", {

  expect_equal(
    c(
      get_babette_path("anthus_aco.fas"),
      get_babette_path("anthus_nd2.fas")
    ),
    get_babette_paths(c("anthus_aco.fas", "anthus_nd2.fas"))
  )
  beastier::check_empty_beastier_folder()
  beautier::check_empty_beautier_folder()
})
