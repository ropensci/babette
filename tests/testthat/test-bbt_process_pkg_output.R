context("bbt_process_pkg_output")

test_that("no package, no change", {

  skip("WIP")
  out <- bbt_process_pkg_output(
    out = NA,
    mcmc = create_mcmc()
  )
  expect_equal(length(names(out) == 5))
})

test_that("NS adds ns", {

  skip("WIP")
  out <- bbt_process_pkg_output(
    out = list(output = c("Marginal likelihood: -12.34(3.14)")),
    mcmc = create_mcmc()
  )
  expect_true("ns" %in% names(out))
  expect_true(out$ns$marg_log_lik == -12.34)
  expect_true(out$ns$marg_log_lik_sd == 3.14)
})
