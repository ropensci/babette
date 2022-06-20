test_that("use", {

  expect_equal(
    c(
      get_babette_path("anthus_aco.fas"),
      get_babette_path("anthus_nd2.fas")
    ),
    get_babette_paths(c("anthus_aco.fas", "anthus_nd2.fas"))
  )

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})
