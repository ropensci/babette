test_that("use", {

  if (!beastier::is_on_ci()) return()

  expect_silent(install_babette_deps())

  expect_message(
    remotes::install_github("ropensci/beautier", dependencies = TRUE),
    paste0(
      "Skipping install of \'beautier\' from a github remote, ",
      "the SHA1 \\(.*\\) has not changed since last install"
    )
  )
  expect_message(
    remotes::install_github("ropensci/tracerer", dependencies = TRUE),
    paste0(
      "Skipping install of \'tracerer\' from a github remote, ",
      "the SHA1 \\(.*\\) has not changed since last install"
    )
  )
  expect_message(
    remotes::install_github("ropensci/beastier", dependencies = TRUE),
    paste0(
      "Skipping install of \'beastier\' from a github remote, ",
      "the SHA1 \\(.*\\) has not changed since last install"
    )
  )
  expect_message(
    remotes::install_github("ropensci/mauricer", dependencies = TRUE),
    paste0(
      "Skipping install of \'mauricer\' from a github remote, ",
      "the SHA1 \\(.*\\) has not changed since last install"
    )
  )
  expect_true(beastier::is_beast2_installed())
  expect_true(mauricer::is_beast2_png_installed("NS"))

})
