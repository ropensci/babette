context("bbt_create_ns")

test_that("use", {
  ns <- babette:::bbt_create_ns(
    output = babette:::bbt_create_test_ns_output()
  )
  expect_equal(ns$marg_log_lik, -141, tolerance = 0.2)
  expect_equal(ns$marg_log_lik_sd, 1.60, tolerance = 0.5)

  skip("TODO: NS max ESS")
  expect_equal(ns$max_ess == 5.4945059635784155)
})
