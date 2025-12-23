test_that("warn_if_dropbox emits warning for Dropbox paths", {
  dropbox_path <- file.path("home", "user", "Dropbox", "project")

  expect_warning(
    warn_if_dropbox(dropbox_path),
    "Dropbox"
  )
})

test_that("warn_if_dropbox is silent for non-Dropbox paths", {
  normal_path <- file.path("home", "user", "Documents", "project")

  expect_warning(
    warn_if_dropbox(normal_path),
    regexp = NA
  )
})
