test_that("use, bin, Linux", {
  expect_silent(beautier::check_empty_beautier_folder())
  expect_silent(beastier::check_empty_beastier_folder())

  if (!is_beast2_installed()) return()
  if (!mauricer::is_beast2_ns_pkg_installed()) return()
  if (rappdirs::app_dir()$os != "unix") return()

  input_filename <- get_babette_path("nested_sampling.xml")

  # Works on Linux
  expect_true(
    is_beast2_input_file(
      filename = input_filename,
      beast2_path = get_default_beast2_bin_path()
    )
  )

  expect_silent(beautier::check_empty_beautier_folder())
  expect_silent(beastier::check_empty_beastier_folder())

})

test_that("use, jar, Linux, works", {
  expect_silent(beautier::check_empty_beautier_folder())
  expect_silent(beastier::check_empty_beastier_folder())

  if (!is_beast2_installed()) return()
  if (!mauricer::is_beast2_ns_pkg_installed()) return()
  if (rappdirs::app_dir()$os != "unix") return()

  input_filename <- get_babette_path("nested_sampling.xml")

  # Used to fail on Linux, with this error (see by setting verbose = TRUE)      # nolint yup, this is code indeed
  # Error detected about here:                                                  # nolint yup, this is code indeed
  #   <beast>                                                                   # nolint yup, this is code indeed
  #       <run id='mcmc' spec='beast.gss.NS'>                                   # nolint yup, this is code indeed

  expect_true(
    is_beast2_input_file(
      filename = input_filename,
      beast2_path = get_default_beast2_jar_path()
    )
  )

  expect_silent(beautier::check_empty_beautier_folder())
  expect_silent(beastier::check_empty_beastier_folder())

})

test_that("use, bin, Win, fails", {
  expect_silent(beautier::check_empty_beautier_folder())
  expect_silent(beastier::check_empty_beastier_folder())

  if (!is_beast2_installed()) return()
  if (!mauricer::is_beast2_ns_pkg_installed()) return()
  if (rappdirs::app_dir()$os != "win") return()

  input_filename <- get_babette_path("nested_sampling.xml")

  # Fails on Windows,
  expect_error(
    is_beast2_input_file(
      filename = input_filename,
      beast2_path = get_default_beast2_bin_path()
    ),
    "Cannot use the Windows executable BEAST2.exe in scripts"
  )

  expect_silent(beautier::check_empty_beautier_folder())
  expect_silent(beastier::check_empty_beastier_folder())
})

test_that("use, jar, Win, fails", {
  expect_silent(beautier::check_empty_beautier_folder())
  expect_silent(beastier::check_empty_beastier_folder())

  if (!is_beast2_installed()) return()
  if (!mauricer::is_beast2_ns_pkg_installed()) return()
  if (rappdirs::app_dir()$os != "win") return()

  input_filename <- get_babette_path("nested_sampling.xml")

  # Fails on Linux, with this error (see by setting verbose = TRUE)             # nolint yup, this is code indeed
  # Error detected about here:                                                  # nolint yup, this is code indeed
  #   <beast>                                                                   # nolint yup, this is code indeed
  #       <run id='mcmc' spec='beast.gss.NS'>                                   # nolint yup, this is code indeed
  expect_false(
    is_beast2_input_file(
      filename = input_filename,
      beast2_path = get_default_beast2_jar_path()
    )
  )

  expect_silent(beautier::check_empty_beautier_folder())
  expect_silent(beastier::check_empty_beastier_folder())
})
