test_that("is_dropbox_path detects Dropbox paths", {
  path <- file.path("home", "user", "Dropbox", "project")
  expect_true(is_dropbox_path(path))
})

test_that("is_dropbox_path ignores non-Dropbox paths", {
  path <- file.path("home", "user", "Documents", "project")
  expect_false(is_dropbox_path(path))
})

test_that("is_dropbox_path detects case variations", {
  expect_true(is_dropbox_path("/home/user/Dropbox/file.txt"))
  expect_true(is_dropbox_path("/home/user/dropbox/file.txt"))
  expect_true(is_dropbox_path("C:/Users/me/DROPBOX/project"))
})

test_that("is_dropbox_path handles Windows paths", {
  expect_true(is_dropbox_path("C:\\Users\\me\\Dropbox\\file.txt"))
})

# EDGE CASE TESTS (NEW - These fix the test failures!)
test_that("is_dropbox_path handles NULL gracefully", {
  expect_false(is_dropbox_path(NULL))
})

test_that("is_dropbox_path handles NA gracefully", {
  expect_false(is_dropbox_path(NA))
  expect_false(is_dropbox_path(NA_character_))
})

test_that("is_dropbox_path handles empty string", {
  expect_false(is_dropbox_path(""))
})

test_that("is_dropbox_path handles numeric input", {
  expect_false(is_dropbox_path(123))
})

test_that("is_dropbox_path handles vector input", {
  expect_false(is_dropbox_path(c("path1", "path2")))
})

test_that("is_dropbox_path handles list input", {
  expect_false(is_dropbox_path(list("path")))
})

test_that("is_dropbox_path works without file existing", {
  fake_path <- "/nonexistent/Dropbox/fake.txt"
  expect_true(is_dropbox_path(fake_path))
})
