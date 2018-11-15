context("bbt_run_ns")

test_that("use", {

  if (rappdirs::app_dir()$os == "win") {
    skip("Cannot run Nested Sampling package from Windows")
  }

  testit::assert(mauricer::mrc_is_installed("NS"))
  beautier::create_beast2_input_file(
    get_babette_path("anthus_aco.fas"),
    "~/anthus_aco_ns",
    mcmc = create_mcmc_nested_sampling()
  )


  out <- bbt_run(
    fasta_filenames = get_babette_path("anthus_aco.fas"),
    mcmc = create_mcmc_nested_sampling(
      chain_length = 1000,
      store_every = 1000,
      sub_chain_length = 500
    ),
    beast2_path = get_default_beast2_bin_path()
  )

  testthat::expect_true("estimates" %in% names(out))
  testthat::expect_true("anthus_aco_trees" %in% names(out))
  testthat::expect_true("operators" %in% names(out))
  testthat::expect_true("output" %in% names(out))

  if (1 == 2) {
    # This assumption is false: a Nested Sampling run runs until
    # convergence
    testthat::expect_equal(class(out$anthus_aco_trees[[1]]), "phylo")
    testthat::expect_equal(length(out$anthus_aco_trees), 2)
  }

  testthat::expect_true("Sample" %in% names(out$estimates))
  testthat::expect_true("posterior" %in% names(out$estimates))
  testthat::expect_true("likelihood" %in% names(out$estimates))
  testthat::expect_true("prior" %in% names(out$estimates))
  testthat::expect_true("treeLikelihood" %in% names(out$estimates))
  testthat::expect_true("TreeHeight" %in% names(out$estimates))
  testthat::expect_true("YuleModel" %in% names(out$estimates))
  testthat::expect_true("birthRate" %in% names(out$estimates))

  testthat::expect_true("operator" %in% names(out$operators))
  testthat::expect_true("p" %in% names(out$operators))
  testthat::expect_true("accept" %in% names(out$operators))
  testthat::expect_true("reject" %in% names(out$operators))
  testthat::expect_true("acceptFC" %in% names(out$operators))
  testthat::expect_true("rejectFC" %in% names(out$operators))
  testthat::expect_true("rejectIv" %in% names(out$operators))
  testthat::expect_true("rejectOp" %in% names(out$operators))


  expect_true("ns" %in% names(out))
  expect_true("marg_log_lik" %in% names(out$ns))
  expect_true("marg_log_lik_sd" %in% names(out$ns))
  skip("TODO: measure Nested Sampling ESS")
  expect_true("ess" %in% names(out$ns))
})

test_that("abuse", {

  expect_error(
    bbt_run(
      fasta_filenames = get_babette_path("anthus_aco.fas"),
      mcmc = create_mcmc_nested_sampling(
        chain_length = 1000,
        sub_chain_length = 500
      ),
      beast2_path = get_default_beast2_jar_path()
    ),
    paste0(
      "When using nested sampling \\(that is, ",
      "using 'create_mcmc_nested_sampling'\\), ",
      "one must use the binary BEAST2 executable \\(that is, using ",
      "'beast2_path = get_default_beast2_bin_path\\(\\)'\\)"
    )
  )
})
