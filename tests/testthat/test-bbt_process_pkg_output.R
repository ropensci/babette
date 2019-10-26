context("bbt_process_pkg_output")

test_that("no package, no change", {

  out <- list(output = babette:::bbt_create_test_ns_output())
  length_before <- length(out)
  out <- bbt_process_pkg_output(
    out = out,
    inference_model = beautier::create_test_inference_model()
  )
  length_after <- length(out)
  expect_equal(length_before, length_after)
})

test_that("NS adds ns", {

  inference_model = beautier::create_test_inference_model(
    mcmc = create_test_ns_mcmc()
  )

  out <- bbt_process_pkg_output(
    out = list(output = babette:::bbt_create_test_ns_output()),
    inference_model = inference_model
  )
  expect_true("ns" %in% names(out))

  # Values are obtained from the text
  expect_equal(out$ns$marg_log_lik, -141.1645, tolerance = 0.000001)
  expect_equal(out$ns$marg_log_lik_sd, 1.160143, tolerance = 0.000001)
})
