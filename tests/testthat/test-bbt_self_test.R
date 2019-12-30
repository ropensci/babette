test_that("use", {
  if (is_beast2_installed()) {
    expect_silent(bbt_self_test())
  } else {
    expect_error(bbt_self_test())
  }
})
