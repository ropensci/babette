context("bbt_create_ns")

test_that("use", {
  ns <- babette:::bbt_create_ns(output = c("Marginal likelihood: -12.34(3.14)"))
  expect_true(ns$marg_log_lik == -12.34)
  expect_true(ns$marg_log_lik_sd == 3.14)
})
