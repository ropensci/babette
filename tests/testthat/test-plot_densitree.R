context("plot_densitree")

test_that("use", {

  fasta_filename <- get_babette_path("anthus_aco.fas")
  out <- bbt_run(
    fasta_filename = fasta_filename,
    mcmc = create_mcmc(chain_length = 10000, store_every = 1000),
    mrca_prior = beautier::create_mrca_prior(
      alignment_id = get_alignment_id(fasta_filename),
      taxa_names = get_taxa_names(fasta_filename),
      is_monophyletic = TRUE,
      mrca_distr = create_normal_distr(mean = 1.0, sigma = 0.01)
    )
  )
  expect_silent(
    plot_densitree(out$anthus_aco_trees[5:10])
  )
})

test_that("minimal use", {
  # Submitted at https://github.com/KlausVigo/phangorn/commit/8440b88fb09249a2653562f0eaee04a51789bcba # nolint indeed URLs can be long
  phylogeny_1 <- ape::read.tree(text = "((A:2, B:2):1, C:3);")
  phylogeny_2 <- ape::read.tree(text = "((A:1, B:1):2, C:3);")
  trees <- c(phylogeny_1, phylogeny_2)
  expect_silent(phangorn::densiTree(trees))
  expect_silent(plot_densitree(trees))
})

test_that("abuse", {

  testthat::expect_error(
    plot_densitree("nonsense"),
    "'phylos' must be of class 'multiPhylo'"
  )
})
