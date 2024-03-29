test_that("use, bin (Linux only)", {
  if (!beastier::is_beast2_installed()) return()
  if (rappdirs::app_dir()$os == "win") return()
  if (!mauricer::is_beast2_ns_pkg_installed()) return()

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()

  inference_model <- create_test_inference_model(
    mcmc = create_test_ns_mcmc(),
  )
  beast2_options <- create_beast2_options(
    beast2_path = get_default_beast2_bin_path()
  )
  out <- bbt_run_from_model(
    fasta_filename = get_babette_path("anthus_aco_sub.fas"),
    inference_model = inference_model,
    beast2_options = beast2_options
  )

  expect_true("estimates" %in% names(out))
  expect_true("anthus_aco_sub_trees" %in% names(out))
  expect_true("operators" %in% names(out))
  expect_true("output" %in% names(out))

  if (1 == 2) {
    # This assumption is false: a Nested Sampling run runs until
    # convergence
    testthat::expect_true(inherits(out$anthus_aco_trees[[1]], "phylo"))
    testthat::expect_equal(length(out$anthus_aco_trees), 2)
  }

  expect_true("Sample" %in% names(out$estimates))
  expect_true("posterior" %in% names(out$estimates))
  expect_true("likelihood" %in% names(out$estimates))
  expect_true("prior" %in% names(out$estimates))
  expect_true("treeLikelihood" %in% names(out$estimates))
  expect_true("TreeHeight" %in% names(out$estimates))
  expect_true("YuleModel" %in% names(out$estimates))
  expect_true("birthRate" %in% names(out$estimates))

  expect_true("operator" %in% names(out$operators))
  expect_true("p" %in% names(out$operators))
  expect_true("accept" %in% names(out$operators))
  expect_true("reject" %in% names(out$operators))
  expect_true("acceptFC" %in% names(out$operators))
  expect_true("rejectFC" %in% names(out$operators))
  expect_true("rejectIv" %in% names(out$operators))
  expect_true("rejectOp" %in% names(out$operators))

  expect_true("ns" %in% names(out))
  expect_true("marg_log_lik" %in% names(out$ns))
  expect_true("marg_log_lik_sd" %in% names(out$ns))

  expect_true("ess" %in% names(out$ns))
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})

test_that("be verbose (yet muted)", {
  if (!beastier::is_beast2_installed()) return()
  if (rappdirs::app_dir()$os != "win") return()
  if (!mauricer::is_beast2_ns_pkg_installed()) return()

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()

  inference_model <- create_test_inference_model(
    mcmc = create_test_ns_mcmc()
  )
  beast2_options <- create_beast2_options(
    beast2_path = get_default_beast2_jar_path(),
    verbose = TRUE
  )
  # No need to
  #
  # sink("/dev/null") # nolint fine that this is code
  #
  # as this test is run on Windows only
  bbt_run_from_model(
    fasta_filename = get_babette_path("anthus_aco.fas"),
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  # sink() # nolint fine that this is code
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})

test_that("abuse", {

  if (!beastier::is_beast2_installed()) return()
  if (!mauricer::is_beast2_ns_pkg_installed()) return()

  inference_model <- create_test_inference_model(
    mcmc = create_mcmc_nested_sampling(
      chain_length = 1000,
      sub_chain_length = 500
    )
  )
  beast2_options <- create_beast2_options(
    beast2_path = get_default_beast2_jar_path()
  )
  expect_error(
    bbt_run_from_model(
      fasta_filename = get_babette_path("anthus_aco.fas"),
      inference_model = inference_model,
      beast2_options = beast2_options
    ),
    paste0(
      "When using nested sampling \\(that is, ",
      "using 'create_ns_mcmc'\\), ",
      "one must use the binary 'BEAST2' executable \\(that is, using ",
      "'beast2_path = get_default_beast2_bin_path\\(\\)'\\)"
    )
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})
