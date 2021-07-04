test_that("use", {
  if (is_beast2_installed()) {
    expect_silent(bbt_self_test())
  } else {
    expect_error(bbt_self_test())
  }
  beastier::check_empty_beastier_folder()
  beautier::check_empty_beautier_folder()
  beastierinstall::clear_beautier_cache()
  beastierinstall::clear_beastier_cache()
})
