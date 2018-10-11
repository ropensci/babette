context("bbt_create_test_ns_output")

test_that("use", {
  expect_true(
    length(babette:::bbt_create_test_ns_output()) > 100
  )
})
