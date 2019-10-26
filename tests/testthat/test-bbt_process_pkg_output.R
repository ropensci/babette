context("bbt_process_pkg_output")

test_that("no package, no change", {

  out <- list(output = babette:::bbt_create_test_ns_output())
  length_before <- length(out)
  out <- bbt_process_pkg_output(
    out = out,
    alignment_ids = "irrelevant",
    mcmc = create_test_mcmc()
  )
  length_after <- length(out)
  expect_equal(length_before, length_after)
})

test_that("NS adds ns", {

  out <- bbt_process_pkg_output(
    out = list(output = babette:::bbt_create_test_ns_output()),
    alignment_ids = "anthus_aco_sub",
    mcmc = beautier::create_test_ns_mcmc(),
    beast2_working_dir = dirname(
      get_babette_path("anthus_aco_sub.posterior.log")
    )
  )
  expect_true("ns" %in% names(out))
  expect_equal(out$ns$marg_log_lik, -141.1645, tolerance = 0.000001)
  expect_equal(out$ns$marg_log_lik_sd, 1.160143, tolerance = 0.000001)
})

test_that("abuse", {

  expect_error(
    bbt_process_pkg_output(
      out = list(output = babette:::bbt_create_test_ns_output()),
      fasta_filename = NA,
      mcmc = beautier::create_test_ns_mcmc()
    ),
    "'fasta_filename' cannot be NA when there is a nested sampling MCMC"
  )
})
