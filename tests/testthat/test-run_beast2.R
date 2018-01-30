context("run_beast2")

test_that("use, one alignment", {

  out <- NA

  testthat::expect_silent(
    out <- run_beast2(
      fasta_filenames = get_path("anthus_aco.fas"),
      mcmc = beautier::create_mcmc(chain_length = 10000, store_every = 1000)
    )
  )

  testthat::expect_true("estimates" %in% names(out))
  testthat::expect_true("anthus_aco_trees" %in% names(out))
  testthat::expect_true("operators" %in% names(out))
  testthat::expect_equal(class(out$anthus_aco_trees[[1]]), "phylo")
  testthat::expect_equal(length(out$anthus_aco_trees), 10)

  testthat::expect_true("Sample" %in% names(out$estimates))
  testthat::expect_true("posterior" %in% names(out$estimates))
  testthat::expect_true("likelihood" %in% names(out$estimates))
  testthat::expect_true("prior" %in% names(out$estimates))
  testthat::expect_true("treeLikelihood" %in% names(out$estimates))
  testthat::expect_true("TreeHeight" %in% names(out$estimates))
  testthat::expect_true("YuleModel" %in% names(out$estimates))
  testthat::expect_true("birthRate" %in% names(out$estimates))

  testthat::expect_true("operator" %in% names(out$operators))
  testthat::expect_true("p" %in% names(out$operators))
  testthat::expect_true("accept" %in% names(out$operators))
  testthat::expect_true("reject" %in% names(out$operators))
  testthat::expect_true("acceptFC" %in% names(out$operators))
  testthat::expect_true("rejectFC" %in% names(out$operators))
  testthat::expect_true("rejectIv" %in% names(out$operators))
  testthat::expect_true("rejectOp" %in% names(out$operators))



})

test_that("use, two alignments, estimated crown ages", {

  out <- NA

  testthat::expect_silent(
    out <- run_beast2(
      fasta_filenames = get_paths(c("anthus_aco.fas", "anthus_nd2.fas")),
      mcmc = beautier::create_mcmc(chain_length = 10000, store_every = 1000)
    )
  )
  testthat::expect_true("estimates" %in% names(out))
  testthat::expect_true("anthus_aco_trees" %in% names(out))
  testthat::expect_true("anthus_nd2_trees" %in% names(out))
  testthat::expect_true("operators" %in% names(out))
  testthat::expect_equal(class(out$anthus_aco_trees[[1]]), "phylo")
  testthat::expect_equal(class(out$anthus_nd2_trees[[1]]), "phylo")
  testthat::expect_equal(length(out$anthus_aco_trees), 10)
  testthat::expect_equal(length(out$anthus_nd2_trees), 10)

  testthat::expect_true("Sample" %in% names(out$estimates))
  testthat::expect_true("posterior" %in% names(out$estimates))
  testthat::expect_true("likelihood" %in% names(out$estimates))
  testthat::expect_true("prior" %in% names(out$estimates))
  testthat::expect_true("treeLikelihood.aco" %in% names(out$estimates))
  testthat::expect_true("treeLikelihood.nd2" %in% names(out$estimates))
  testthat::expect_true("TreeHeight.aco" %in% names(out$estimates))
  testthat::expect_true("TreeHeight.nd2" %in% names(out$estimates))
  testthat::expect_true("YuleModel.aco" %in% names(out$estimates))
  testthat::expect_true("YuleModel.nd2" %in% names(out$estimates))
  testthat::expect_true("birthRate.aco" %in% names(out$estimates))
  testthat::expect_true("birthRate.nd2" %in% names(out$estimates))

  testthat::expect_true("operator" %in% names(out$operators))
  testthat::expect_true("p" %in% names(out$operators))
  testthat::expect_true("accept" %in% names(out$operators))
  testthat::expect_true("reject" %in% names(out$operators))
  testthat::expect_true("acceptFC" %in% names(out$operators))
  testthat::expect_true("rejectFC" %in% names(out$operators))
  testthat::expect_true("rejectIv" %in% names(out$operators))
  testthat::expect_true("rejectOp" %in% names(out$operators))

})
