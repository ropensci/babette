context("bbt_run_ns")

test_that("use", {

  if (!beastier::is_beast2_installed()) return()
  if (rappdirs::app_dir()$os == "win") return()
  if (!mauricer::is_beast2_pkg_installed("NS")) return()

  testit::assert(mauricer::is_beast2_pkg_installed("NS"))
  out <- bbt_run(
    fasta_filename = get_babette_path("anthus_aco.fas"),
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

  expect_true("estimates" %in% names(out$ns))
  expect_true("trees" %in% names(out$ns))

  skip("TODO: measure Nested Sampling ESS. Issue 37, #37")
  # https://github.com/ropensci/babette/issues/37
  expect_true("ess" %in% names(out$ns))
})

test_that("Nested sampling run should create no temporaries", {

  if (!beastier::is_beast2_installed()) return()
  if (rappdirs::app_dir()$os == "win") return()
  if (!mauricer::is_beast2_pkg_installed("NS")) return()

  # From https://github.com/ropensci/babette/issues/36
  testit::assert(mauricer::is_beast2_pkg_installed("NS"))

  # Run babette in a different folder
  old_work_dir <- getwd()
  new_work_dir <- tempdir()
  setwd(new_work_dir)
  files_before <- list.files(new_work_dir)

  # Temporary files created
  beast2_input_filename <- tempfile(".xml")
  beast2_output_log_filename <- tempfile("log")
  beast2_output_trees_filenames <- tempfile("trees")
  beast2_output_state_filename <- tempfile(".state.xml")

  bbt_run(
    fasta_filename = get_babette_path("anthus_aco.fas"),
    mcmc = create_mcmc_nested_sampling(
      chain_length = 1000,
      store_every = 1000,
      sub_chain_length = 500,
      epsilon = 1.0
    ),
    beast2_path = get_default_beast2_bin_path(),
    beast2_input_filename = beast2_input_filename,
    beast2_output_log_filename = beast2_output_log_filename,
    beast2_output_trees_filenames = beast2_output_trees_filenames,
    beast2_output_state_filename = beast2_output_state_filename
  )

  # Delete the temporary files
  file.remove(beast2_input_filename)
  file.remove(beast2_output_log_filename)
  file.remove(beast2_output_trees_filenames)
  file.remove(beast2_output_state_filename)

  files_after <- list.files(new_work_dir)
  setwd(old_work_dir)
  list.files(new_work_dir)
  expect_equal(files_before, files_after)
})

test_that("abuse", {

  if (!beastier::is_beast2_installed()) return()
  if (!mauricer::is_beast2_pkg_installed("NS")) return()

  testit::assert(mauricer::is_beast2_pkg_installed("NS"))

  expect_error(
    bbt_run(
      fasta_filename = get_babette_path("anthus_aco.fas"),
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
