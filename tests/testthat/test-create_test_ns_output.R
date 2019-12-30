context("create_test_ns_output")

test_that("use", {
  expect_true(
    length(babette::create_test_ns_output()) > 100
  )
})
