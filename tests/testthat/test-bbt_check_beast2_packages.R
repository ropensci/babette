context("bbt_check_beast2_packages")

test_that("use", {

  if (!beastier::is_beast2_installed()) return()

  # This test uninstalls the NS BEAST2 package.
  # Only do that on CI services, else a user without internet
  # suddenly finds the NS BEAST2 package installed and unable
  # to reinstall it
  if (!beastier::is_on_ci()) return()

  beast2_package_name <- "NS"
  # Check to need to install NS later
  was_ns_installed <- mauricer::is_beast2_pkg_installed(beast2_package_name)

  if (mauricer::is_beast2_pkg_installed(beast2_package_name)) {
    mauricer::uninstall_beast2_pkg(beast2_package_name)
  }
  testit::assert(!mauricer::is_beast2_pkg_installed(beast2_package_name))

  expect_error(
    babette:::bbt_check_beast2_packages(
      mcmc = create_mcmc_nested_sampling(),
      beast2_path = get_default_beast2_bin_path()
    ),
    paste0(
      "Must install 'NS' to use 'create_mcmc_nested_sampling'."
    )
  )

  mauricer::install_beast2_pkg(beast2_package_name)

  expect_silent(
    babette:::bbt_check_beast2_packages(
      mcmc = create_mcmc_nested_sampling(),
      beast2_path = get_default_beast2_bin_path()
    )
  )

  if (!was_ns_installed) {
    mauricer::uninstall_beast2_pkg(beast2_package_name)
  }
})
