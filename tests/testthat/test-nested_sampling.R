test_that("use", {

  skip("Issue #68")
  if (!beastier::is_beast2_installed()) return()
  if (rappdirs::app_dir()$os == "win") return()
  if (!mauricer::is_beast2_pkg_installed("NS")) return()

  input_filename <- get_babette_path("nested_sampling.xml")

  expect_true(
    beastier::is_beast2_input_file(
      filename = input_filename,
      beast2_path = get_default_beast2_bin_path()
    )
  )
  expect_true(
    beastier::is_beast2_input_file(
      filename = input_filename,
      beast2_path = get_default_beast2_jar_path()
    )
  )
})
