context("plot_densitree")

test_that("use", {

  out <- bbt_run(
    get_babette_path("anthus_aco.fas"),
    mcmc = create_mcmc(chain_length = 10000, store_every = 1000)
  )
  testthat::expect_silent(
    plot_densitree(out$anthus_aco_trees)
  )
})

test_that("use", {
  skip("Do not test phangorn")
  phylogeny <- ape::read.tree(text = "(((A:1, B:1):1, C:2):1, D:3);")
  expect_silent(plot_densitree(c(phylogeny)))
})

test_that("abuse", {

  testthat::expect_error(
    plot_densitree("nonsense"),
    "'phylos' must be of class 'multiPhylo'"
  )
})
