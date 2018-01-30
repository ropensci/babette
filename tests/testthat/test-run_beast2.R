context("run_beast2")

test_that("use", {

  out <- NA

  testthat::expect_silent(
    out <- run_beast2(
      fasta_filenames = get_path("anthus_aco.fas"),
      mcmc = beautier::create_mcmc(chain_length = 10000, store_every = 1000)
    )
  )

  testthat::expect_true("log" %in% names(out))
  testthat::expect_true("trees" %in% names(out))
  testthat::expect_true("operators" %in% names(out))
  testthat::expect_equal(class(out$trees[[1]]), "phylo")
  testthat::expect_equal(length(out$trees), 10)

  testthat::expect_true("Sample" %in% names(out$log))
  testthat::expect_true("posterior" %in% names(out$log))
  testthat::expect_true("likelihood" %in% names(out$log))
  testthat::expect_true("prior" %in% names(out$log))
  testthat::expect_true("treeLikelihood" %in% names(out$log))
  testthat::expect_true("TreeHeight" %in% names(out$log))
  testthat::expect_true("YuleModel" %in% names(out$log))
  testthat::expect_true("birthRate" %in% names(out$log))

  testthat::expect_true("operator" %in% names(out$operators))
  testthat::expect_true("p" %in% names(out$operators))
  testthat::expect_true("accept" %in% names(out$operators))
  testthat::expect_true("reject" %in% names(out$operators))
  testthat::expect_true("acceptFC" %in% names(out$operators))
  testthat::expect_true("rejectFC" %in% names(out$operators))
  testthat::expect_true("rejectIv" %in% names(out$operators))
  testthat::expect_true("rejectOp" %in% names(out$operators))



})
