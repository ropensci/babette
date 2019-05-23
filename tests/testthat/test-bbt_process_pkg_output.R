context("bbt_process_pkg_output")

test_that("no package, no change", {

  out <- list(output = babette:::bbt_create_test_ns_output())
  length_before <- length(out)
  out <- bbt_process_pkg_output(
    out = out,
    alignment_ids = "irrelevant",
    mcmc = create_mcmc()
  )
  length_after <- length(out)
  expect_equal(length_before, length_after)
})

test_that("NS adds ns", {

  skip("WIP")
  out <- bbt_process_pkg_output(
    out = list(output = babette:::bbt_create_test_ns_output()),
    alignment_ids = "anthus_aco_sub",
    mcmc = create_nested_sampling_mcmc()
  )
  expect_true("ns" %in% names(out))
  expect_true(out$ns$marg_log_lik == -12.34)
  expect_true(out$ns$marg_log_lik_sd == 3.14)
})

test_that("abuse", {

  expect_error(
    bbt_process_pkg_output(
      out = list(output = babette:::bbt_create_test_ns_output()),
      alignment_ids = NA,
      mcmc = create_nested_sampling_mcmc()
    ),
    "'alignment_ids' cannot be NA when there is a nested sampling MCMC"
  )
})
