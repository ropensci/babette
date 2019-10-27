test_that("update in silence", {
  if (!beastier::is_on_travis()) return()
  update_babette()
  expect_silent(update_babette())
})
