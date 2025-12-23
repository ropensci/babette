test_that("is_dropbox_path detects Dropbox paths", {
  path <- file.path("home", "user", "Dropbox", "project")
  expect_true(is_dropbox_path(path))
})

test_that("is_dropbox_path ignores non-Dropbox paths", {
  path <- file.path("home", "user", "Documents", "project")
  expect_false(is_dropbox_path(path))
})
