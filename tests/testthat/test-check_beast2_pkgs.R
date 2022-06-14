test_that("use", {

  if (!beastier::is_beast2_installed()) return()

  # This test uninstalls the NS 'BEAST2' package.
  # Only do that on CI services, else a user without internet
  # suddenly finds the NS 'BEAST2' package installed and unable
  # to reinstall it
  if (!beastier::is_on_ci()) return()

  # Check to need to install NS later
  was_ns_installed <- mauricer::is_beast2_ns_pkg_installed()

  if (mauricer::is_beast2_ns_pkg_installed()) {
    mauricerinstall::uninstall_beast2_pkg("NS")
  }

  expect_error(
    check_beast2_pkgs(
      mcmc = create_mcmc_nested_sampling(),
      beast2_path = get_default_beast2_bin_path()
    ),
    "Must install 'NS' to use 'create_ns_mcmc'."
  )

  mauricerinstall::install_beast2_pkg("NS")

  expect_silent(
    check_beast2_pkgs(
      mcmc = create_mcmc_nested_sampling(),
      beast2_path = get_default_beast2_bin_path()
    )
  )

  if (!was_ns_installed) {
    mauricerinstall::uninstall_beast2_pkg("BS")
  }

  beastier::remove_beaustier_folder()
  beastier::check_empty_beaustier_folders()
})
