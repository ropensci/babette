test_that("update in silence", {
  update_babette()
  expect_silent(update_babette())
})
