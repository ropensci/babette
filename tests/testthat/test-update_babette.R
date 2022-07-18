test_that("update in silence", {
  if (!beautier::is_on_gha()) return()
  update_babette()
  expect_silent(update_babette())
})
