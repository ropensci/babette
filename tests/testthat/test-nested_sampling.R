test_that("use, bin, Linux", {

  if (!beastier::is_beast2_installed()) return()
  if (!mauricer::is_beast2_pkg_installed("NS")) return()
  if (rappdirs::app_dir()$os != "unix") return()

  input_filename <- get_babette_path("nested_sampling.xml")

  # Works on Linux
  expect_true(
    beastier::is_beast2_input_file(
      filename = input_filename,
      beast2_path = get_default_beast2_bin_path()
    )
  )

  # Fails on Linux
  expect_true(
    beastier::is_beast2_input_file(
      filename = input_filename,
      beast2_path = get_default_beast2_jar_path(),
      verbose = TRUE
    )
  )
})

test_that("use, jar, Linux, fails", {

  if (!beastier::is_beast2_installed()) return()
  if (!mauricer::is_beast2_pkg_installed("NS")) return()
  if (rappdirs::app_dir()$os != "unix") return()

  input_filename <- get_babette_path("nested_sampling.xml")

  # Fails on Linux, with this error (see by setting verbose = TRUE)             # nolint yup, this is code indeed
  # Error detected about here:                                                  # nolint yup, this is code indeed
  #   <beast>                                                                   # nolint yup, this is code indeed
  #       <run id='mcmc' spec='beast.gss.NS'>                                   # nolint yup, this is code indeed

  expect_false(
    beastier::is_beast2_input_file(
      filename = input_filename,
      beast2_path = get_default_beast2_jar_path()
    )
  )
})
