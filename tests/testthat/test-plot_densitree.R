context("plot_densitree")

test_that("use", {

  out <- run(
    get_babette_path("anthus_aco.fas"),
    mcmc = create_mcmc(chain_length = 10000, store_every = 1000)
  )
  testthat::expect_silent(
    plot_densitree(out$anthus_aco_trees)
  )
})

test_that("abuse", {

  testthat::expect_error(
    plot_densitree("nonsense"),
    "'phylos' must be of class 'multiPhylo'"
  )
})
