context("bbt_create_ns")

test_that("use", {
  ns <- babette:::bbt_create_ns(
    output = babette:::bbt_create_test_ns_output()
  )
  expect_true(ns$marg_log_lik == -141.1645)
  expect_true(ns$marg_log_lik_sd == 1.462246661656647)
  expect_true(ns$max_ess == 5.4945059635784155)
})
