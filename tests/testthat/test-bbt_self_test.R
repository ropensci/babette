test_that("use", {
  if (!beastier::is_beast2_installed()) return()
  expect_silent(bbt_self_test())
})
