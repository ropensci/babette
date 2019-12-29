context("bbt_create_ns")

test_that("use", {
  ns <- bbt_create_ns(
    output = bbt_create_test_ns_output()
  )
  expect_equal(ns$marg_log_lik, -141, tolerance = 0.2)
  expect_equal(ns$marg_log_lik_sd, 1.60, tolerance = 0.5)
  expect_equal(ns$ess, 5.49, tolerance = 0.2)
})
