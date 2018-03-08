context("run_beast2")

test_that("use, one alignment", {

  out <- NA

  testthat::expect_silent(
    out <- run_beast2(
      fasta_filenames = get_path("anthus_aco.fas"),
      mcmc = create_mcmc(chain_length = 2000, store_every = 1000)
    )
  )

  testthat::expect_true("estimates" %in% names(out))
  testthat::expect_true("anthus_aco_trees" %in% names(out))
  testthat::expect_true("operators" %in% names(out))
  testthat::expect_equal(class(out$anthus_aco_trees[[1]]), "phylo")
  testthat::expect_equal(length(out$anthus_aco_trees), 2)

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

test_that("use, one alignment, verbose, cleanup", {

  testthat::expect_output(
    run_beast2(
      fasta_filenames = get_path("anthus_aco.fas"),
      mcmc = create_mcmc(chain_length = 2000, store_every = 1000),
      verbose = TRUE
    )
  )
})

test_that("use, one alignment, verbose, no cleanup", {

  fasta_filenames <- get_path("anthus_aco.fas")
  beast2_input_filename <- "tmp_beast2.xml"
  beast2_output_log_filename <- "tmp_beast2.log"
  beast2_output_trees_filenames <- paste0(
    beautier::get_ids(fasta_filenames), "_tmp.trees"
  )
  beast2_output_state_filename <- "tmp_beast2.xml.state"

  testit::assert(!file.exists(beast2_input_filename))
  testit::assert(!file.exists(beast2_output_log_filename))
  testit::assert(!file.exists(beast2_output_trees_filenames))
  testit::assert(!file.exists(beast2_output_state_filename))

  testthat::expect_output(
    run_beast2(
      fasta_filenames = fasta_filenames,
      mcmc = create_mcmc(chain_length = 2000, store_every = 1000),
      beast2_input_filename = beast2_input_filename,
      beast2_output_log_filename = beast2_output_log_filename,
      beast2_output_trees_filenames = beast2_output_trees_filenames,
      beast2_output_state_filename = beast2_output_state_filename,
      verbose = TRUE,
      cleanup = FALSE
    )
  )
  testthat::expect_true(file.exists(beast2_input_filename))
  testthat::expect_true(file.exists(beast2_output_log_filename))
  testthat::expect_true(file.exists(beast2_output_trees_filenames))
  testthat::expect_true(file.exists(beast2_output_state_filename))

  file.remove(beast2_input_filename)
  file.remove(beast2_output_log_filename)
  file.remove(beast2_output_trees_filenames)
  file.remove(beast2_output_state_filename)


})

test_that("use, one alignment, same RNG should give same results", {

  rng_seed <- 42
  out_1 <- run_beast2(
    fasta_filenames = get_path("anthus_aco.fas"),
    mcmc = create_mcmc(chain_length = 2000, store_every = 1000),
    rng_seed = rng_seed
  )
  out_2 <- run_beast2(
    fasta_filenames = get_path("anthus_aco.fas"),
    mcmc = create_mcmc(chain_length = 2000, store_every = 1000),
    rng_seed = rng_seed
  )
  testthat::expect_identical(out_1, out_2)

})

test_that("use, two alignments, estimated crown ages", {

  out <- NA

  testthat::expect_silent(
    out <- run_beast2(
      fasta_filenames = get_paths(c("anthus_aco.fas", "anthus_nd2.fas")),
      mcmc = create_mcmc(chain_length = 2000, store_every = 1000)
    )
  )
  testthat::expect_true("estimates" %in% names(out))
  testthat::expect_true("anthus_aco_trees" %in% names(out))
  testthat::expect_true("anthus_nd2_trees" %in% names(out))
  testthat::expect_true("operators" %in% names(out))
  testthat::expect_equal(class(out$anthus_aco_trees[[1]]), "phylo")
  testthat::expect_equal(class(out$anthus_nd2_trees[[1]]), "phylo")
  testthat::expect_equal(length(out$anthus_aco_trees), 2)
  testthat::expect_equal(length(out$anthus_nd2_trees), 2)

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




test_that("abuse", {

  testthat::expect_error(
    run_beast2(
      fasta_filenames = get_path("anthus_aco.fas"),
      beast2_output_trees_filenames = c("too", "many")
    ),
    "Must have as much FASTA filenames as BEAST2 output trees fileanames"
  )

})

################################################################################
# Defaults
################################################################################

test_that("Run all defaults", {

  created <- beautier::create_beast2_input(
    input_filenames = beautier::get_fasta_filename()
  )

  testthat::expect_true(are_beast2_input_lines(created))
})

################################################################################
# Site models
################################################################################

################################################################################
# Site model: GTR
################################################################################

test_that("Run GTR", {

  created <- beautier::create_beast2_input(
    input_filenames = beautier::get_fasta_filename(),
    site_models = create_gtr_site_model()
  )

  testthat::expect_true(are_beast2_input_lines(created))
})

################################################################################
# Site model: HKY
################################################################################

################################################################################
# Site model: JC69
################################################################################


################################################################################
# Site model: TN93
################################################################################


################################################################################
# Clock models
################################################################################

################################################################################
# Clock model: RLN
################################################################################

test_that("Use of a strict clock", {

  input_fasta_filename <- beautier::get_fasta_filename()
  id <- get_id(input_fasta_filename)
  lines <- beautier::create_beast2_input(
    input_filenames = input_fasta_filename,
    clock_models = create_strict_clock_model(
      clock_rate_param = create_clock_rate_param(id = id)
    )
  )
  testthat::expect_true(are_beast2_input_lines(lines))
})

test_that("Use of a RLN clock", {

  lines <- beautier::create_beast2_input(
    input_filenames = beautier::get_fasta_filename(),
    clock_models = create_rln_clock_model()
  )
  testthat::expect_true(are_beast2_input_lines(lines))

})

################################################################################
# Clock model: strict
################################################################################



################################################################################
# Tree priors
################################################################################

################################################################################
# Tree prior: BD
################################################################################

test_that("Run BD tree prior", {

  created <- beautier::create_beast2_input(
    input_filenames = beautier::get_fasta_filename(),
    tree_priors = create_bd_tree_prior()
  )

  testthat::expect_true(are_beast2_input_lines(created))
})


################################################################################
# Tree prior: CBS
################################################################################

test_that("Run CBP", {

  lines <- create_beast2_input(
    input_filenames = get_beautier_path("anthus_aco_sub.fas"),
    tree_priors = create_cbs_tree_prior(group_sizes_dimension = 4)
  )
  testthat::expect_true(are_beast2_input_lines(lines))
})

################################################################################
# Tree prior: CCP
################################################################################

################################################################################
# Tree prior: CEP
################################################################################

test_that("Run CEP", {

  lines <- beautier::create_beast2_input(
    input_filenames = beautier::get_fasta_filename(),
    tree_priors = beautier::create_cep_tree_prior()
  )
  testthat::expect_true(are_beast2_input_lines(lines))

})

################################################################################
# Tree prior: Yule
################################################################################


################################################################################
# MRCA priors
################################################################################

test_that("Run MRCA, no distr", {

  fasta_filename <- get_fasta_filename()
  lines <- beautier::create_beast2_input(
    input_filenames = fasta_filename,
    mrca_priors = create_mrca_prior(
      alignment_id = get_alignment_id(fasta_filename),
      taxa_names = get_taxa_names(fasta_filename)
    )
  )
  testthat::expect_true(are_beast2_input_lines(lines))
})

test_that("Run MRCA, MRCA distr", {

  fasta_filename <- get_fasta_filename()
  lines <- beautier::create_beast2_input(
    input_filenames = fasta_filename,
    mrca_priors = create_mrca_prior(
      alignment_id = get_alignment_id(fasta_filename),
      taxa_names = get_taxa_names(fasta_filename),
      mrca_distr = create_one_div_x_distr()
    )
  )
  testthat::expect_true(are_beast2_input_lines(lines))
})


################################################################################
# Initial phylogenies
################################################################################

test_that("JC69 JC69 strict strict coalescent_exp_population", {

  input_fasta_filename_1 <- get_path("anthus_aco.fas")
  input_fasta_filename_2 <- get_path("anthus_nd2.fas")
  input_filenames <- c(input_fasta_filename_1, input_fasta_filename_2)
  site_model_1 <- create_jc69_site_model()
  site_model_2 <- create_jc69_site_model()
  clock_model_1 <- create_strict_clock_model()
  clock_model_2 <- create_strict_clock_model()
  tree_prior <- create_cep_tree_prior()
  lines <- create_beast2_input(
    input_filenames = input_filenames,
    site_models = list(site_model_1, site_model_2),
    clock_models = list(clock_model_1, clock_model_2),
    tree_priors = list(tree_prior, tree_prior)
  )
  testthat::expect_true(are_beast2_input_lines(lines))
})

test_that("TN93 TN93 strict strict yule", {

  input_fasta_filename_1 <- get_path("anthus_aco.fas")
  input_fasta_filename_2 <- get_path("anthus_nd2.fas")
  input_filenames <- c(input_fasta_filename_1, input_fasta_filename_2)
  site_model_1 <- create_tn93_site_model()
  site_model_2 <- create_tn93_site_model()
  clock_model_1 <- create_strict_clock_model()
  clock_model_2 <- create_strict_clock_model()
  tree_prior <- create_yule_tree_prior()
  lines <- create_beast2_input(
    input_filenames = input_filenames,
    site_models = list(site_model_1, site_model_2),
    clock_models = list(clock_model_1, clock_model_2),
    tree_priors = list(tree_prior, tree_prior)
  )
  testthat::expect_true(are_beast2_input_lines(lines))
})



test_that("GTR GTR strict strict yule", {

  input_fasta_filename_1 <- get_path("anthus_aco.fas")
  input_fasta_filename_2 <- get_path("anthus_nd2.fas")
  input_filenames <- c(input_fasta_filename_1, input_fasta_filename_2)
  site_model_1 <- create_gtr_site_model()
  site_model_2 <- create_gtr_site_model()
  clock_model_1 <- create_strict_clock_model()
  clock_model_2 <- create_strict_clock_model()
  tree_prior <- create_yule_tree_prior()
  lines <- create_beast2_input(
    input_filenames = input_filenames,
    site_models = list(site_model_1, site_model_2),
    clock_models = list(clock_model_1, clock_model_2),
    tree_priors = list(tree_prior, tree_prior)
  )
  testthat::expect_true(are_beast2_input_lines(lines))
})


test_that("GTR TN93 strict strict yule", {

  input_fasta_filename_1 <- get_path("anthus_aco.fas")
  input_fasta_filename_2 <- get_path("anthus_nd2.fas")
  input_filenames <- c(input_fasta_filename_1, input_fasta_filename_2)
  site_model_1 <- create_gtr_site_model()
  site_model_2 <- create_tn93_site_model()
  clock_model_1 <- create_strict_clock_model()
  clock_model_2 <- create_strict_clock_model()
  tree_prior <- create_yule_tree_prior()
  lines <- create_beast2_input(
    input_filenames = input_filenames,
    site_models = list(site_model_1, site_model_2),
    clock_models = list(clock_model_1, clock_model_2),
    tree_priors = list(tree_prior, tree_prior)
  )
  testthat::expect_true(are_beast2_input_lines(lines))
})

test_that("JC69 JC69 strict relaxed_log_normal Yule", {

  input_filenames <- get_paths(
    c("anthus_aco.fas", "anthus_nd2.fas")
  )
  site_model_1 <- create_jc69_site_model()
  site_model_2 <- create_jc69_site_model()
  clock_model_1 <- create_strict_clock_model()
  clock_model_2 <- create_rln_clock_model()
  tree_prior <- create_yule_tree_prior()
  lines <- create_beast2_input(
    input_filenames = input_filenames,
    site_models = list(site_model_1, site_model_2),
    clock_models = list(clock_model_1, clock_model_2),
    tree_priors = list(tree_prior, tree_prior)
  )
  testthat::expect_true(
    are_beast2_input_lines(lines)
  )
})
