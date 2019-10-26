test_that("NS adds ns", {

  skip("Issue 74, Issue #74")
  out <- bbt_process_pkg_output_ns(
    out = list(output = babette:::bbt_create_test_ns_output()),
    alignment_ids = "anthus_aco_sub",
    beast2_working_dir = dirname(
      get_babette_path("anthus_aco_sub.posterior.log")
    )
  )
  expect_true("ns" %in% names(out))
  expect_equal(out$ns$marg_log_lik, -141.1645, tolerance = 0.000001)
  expect_equal(out$ns$marg_log_lik_sd, 1.160143, tolerance = 0.000001)
})

test_that("abuse", {

  skip("Issue 74, Issue #74")
  expect_error(
    bbt_process_pkg_output_ns(
      out = list(output = babette:::bbt_create_test_ns_output()),
      alignment_ids = NA
    ),
    "'alignment_ids' cannot be NA when there is a nested sampling MCMC"
  )

  expect_error(
    bbt_process_pkg_output_ns(
      out = list(output = babette:::bbt_create_test_ns_output()),
      alignment_ids = "absent"
    ),
    "File '.*' not found"
  )
})
