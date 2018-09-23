context("bbt_run")

test_that("use, one alignment", {
  testit::assert(beastier::is_beast2_installed())

  out <- NA

  testthat::expect_silent(
    out <- bbt_run(
      fasta_filenames = get_babette_path("anthus_aco.fas"),
      mcmc = create_mcmc(chain_length = 1000, store_every = 1000)
    )
  )
  testthat::expect_true("estimates" %in% names(out))
  testthat::expect_true("anthus_aco_trees" %in% names(out))
  testthat::expect_true("operators" %in% names(out))
  testthat::expect_true("output" %in% names(out))
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
  testit::assert(beastier::is_beast2_installed())

  testthat::expect_output(
    bbt_run(
      fasta_filenames = get_babette_path("anthus_aco.fas"),
      mcmc = create_mcmc(chain_length = 1000, store_every = 1000),
      verbose = TRUE
    )
  )
})

test_that("use, one alignment, verbose, no cleanup", {
  testit::assert(beastier::is_beast2_installed())

  fasta_filenames <- get_babette_path("anthus_aco.fas")
  beast2_input_filename <- tempfile(fileext = ".xml")
  beast2_output_log_filename <- tempfile(fileext = ".log")
  beast2_output_trees_filenames <- tempfile(
    pattern = beautier::get_alignment_ids(fasta_filenames), fileext = ".xml"
  )
  beast2_output_state_filename <- tempfile(fileext = ".xml.state")

  testit::assert(!file.exists(beast2_input_filename))
  testit::assert(!file.exists(beast2_output_log_filename))
  testit::assert(!file.exists(beast2_output_trees_filenames))
  testit::assert(!file.exists(beast2_output_state_filename))

  testthat::expect_output(
    bbt_run(
      fasta_filenames = fasta_filenames,
      mcmc = create_mcmc(chain_length = 1000, store_every = 1000),
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
})

test_that("use, one alignment, same RNG should give same results", {
  testit::assert(beastier::is_beast2_installed())

  rng_seed <- 42
  out_1 <- bbt_run(
    fasta_filenames = get_babette_path("anthus_aco.fas"),
    mcmc = create_mcmc(chain_length = 1000, store_every = 1000),
    rng_seed = rng_seed
  )
  out_2 <- bbt_run(
    fasta_filenames = get_babette_path("anthus_aco.fas"),
    mcmc = create_mcmc(chain_length = 1000, store_every = 1000),
    rng_seed = rng_seed
  )
  # The screen output will be different here:
  # [35] "Writing state to file /tmp/RtmpRyToHX/beast2_39f46a37b262.xml.state"
  # [38] "File: beast2_39f41cfb21ef.xml seed: 42 threads: 1"
  # [101] "Total calculation time: 0.197 seconds"
  out_2$output[35] <- out_1$output[35]
  out_2$output[38] <- out_1$output[38]
  out_2$output[101] <- out_1$output[101]
  testthat::expect_identical(out_1, out_2)
})

test_that("use, two alignments, estimated crown ages", {
  testit::assert(beastier::is_beast2_installed())

  out <- NA

  testthat::expect_silent(
    out <- bbt_run(
      fasta_filenames = get_babette_paths(
        c("anthus_aco.fas", "anthus_nd2.fas")
      ),
      mcmc = create_mcmc(chain_length = 1000, store_every = 1000)
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
    bbt_run(
      fasta_filenames = get_babette_path("anthus_aco.fas"),
      beast2_output_trees_filenames = c("too", "many")
    ),
    "Must have as much FASTA filenames as BEAST2 output trees filenames"
  )

})

################################################################################
# Defaults
################################################################################

test_that("Run all defaults", {
  if (!beastier:::is_on_travis()) return()
  expect_silent(
    bbt_run(
      fasta_filenames = get_beautier_path("anthus_aco_sub.fas"),
      mcmc = beautier::create_mcmc(chain_length = 2000)
    )
  )
})

################################################################################
# Site models
################################################################################

################################################################################
# Site model: GTR
################################################################################

test_that("Run GTR", {
  if (!beastier:::is_on_travis()) return()
  expect_silent(
    bbt_run(
      fasta_filenames = get_beautier_path("anthus_aco_sub.fas"),
      site_models = create_gtr_site_model(),
      mcmc = beautier::create_mcmc(chain_length = 2000)
    )
  )
})

################################################################################
# Site model: HKY
################################################################################

test_that("Run HKY", {
  if (!beastier:::is_on_travis()) return()
  expect_silent(
    bbt_run(
      fasta_filenames = get_beautier_path("anthus_aco_sub.fas"),
      site_models = create_hky_site_model(),
      mcmc = beautier::create_mcmc(chain_length = 2000)
    )
  )
})

################################################################################
# Site model: JC69
################################################################################

test_that("Run JC69", {
  if (!beastier:::is_on_travis()) return()
  expect_silent(
    bbt_run(
      fasta_filenames = get_beautier_path("anthus_aco_sub.fas"),
      site_models = create_jc69_site_model(),
      mcmc = beautier::create_mcmc(chain_length = 2000)
    )
  )
})

################################################################################
# Site model: TN93
################################################################################

test_that("Run TN93", {
  if (!beastier:::is_on_travis()) return()
  expect_silent(
    bbt_run(
      fasta_filenames = get_beautier_path("anthus_aco_sub.fas"),
      site_models = create_tn93_site_model(),
      mcmc = beautier::create_mcmc(chain_length = 2000)
    )
  )
})

################################################################################
# Clock models
################################################################################

################################################################################
# Clock model: RLN
################################################################################
test_that("Run RLN clock", {
  if (!beastier:::is_on_travis()) return()
  expect_silent(
    bbt_run(
      fasta_filenames = get_beautier_path("anthus_aco_sub.fas"),
      clock_models = create_rln_clock_model(),
      mcmc = beautier::create_mcmc(chain_length = 2000)
    )
  )
})

################################################################################
# Clock model: strict
################################################################################
test_that("Run strict clock", {
  if (!beastier:::is_on_travis()) return()
  expect_silent(
    bbt_run(
      fasta_filenames = get_beautier_path("anthus_aco_sub.fas"),
      clock_models = create_strict_clock_model(),
      mcmc = beautier::create_mcmc(chain_length = 2000)
    )
  )
})

################################################################################
# Tree priors
################################################################################

################################################################################
# Tree prior: BD
################################################################################
test_that("Run BD tree prior", {
  if (!beastier:::is_on_travis()) return()
  expect_silent(
    bbt_run(
      fasta_filenames = get_beautier_path("anthus_aco_sub.fas"),
      tree_priors = create_bd_tree_prior(),
      mcmc = beautier::create_mcmc(chain_length = 2000)
    )
  )
})

################################################################################
# Tree prior: CBS
################################################################################
test_that("Run CBS tree prior", {
  if (!beastier:::is_on_travis()) return()
  expect_silent(
    bbt_run(
      fasta_filenames = get_beautier_path("anthus_aco_sub.fas"),
      tree_priors = create_cbs_tree_prior(
        group_sizes_dimension = 4
      ),
      mcmc = beautier::create_mcmc(chain_length = 2000)
    )
  )
})

################################################################################
# Tree prior: CCP
################################################################################
test_that("Run CCP tree prior", {
  if (!beastier:::is_on_travis()) return()
  expect_silent(
    bbt_run(
      fasta_filenames = get_beautier_path("anthus_aco_sub.fas"),
      tree_priors = create_ccp_tree_prior(),
      mcmc = beautier::create_mcmc(chain_length = 2000)
    )
  )
})

################################################################################
# Tree prior: CEP
################################################################################
test_that("Run CEP tree prior", {
  if (!beastier:::is_on_travis()) return()
  expect_silent(
    bbt_run(
      fasta_filenames = get_beautier_path("anthus_aco_sub.fas"),
      tree_priors = create_cep_tree_prior(),
      mcmc = beautier::create_mcmc(chain_length = 2000)
    )
  )
})

################################################################################
# Tree prior: Yule
################################################################################
test_that("Run Yule tree prior", {
  if (!beastier:::is_on_travis()) return()
  expect_silent(
    bbt_run(
      fasta_filenames = get_beautier_path("anthus_aco_sub.fas"),
      tree_priors = create_yule_tree_prior(),
      mcmc = beautier::create_mcmc(chain_length = 2000)
    )
  )
})


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

test_that("Run MRCA, no distr, subset of taxa", {

  fasta_filename <- get_fasta_filename()
  set.seed(0)
  taxa_names <- sample(x = get_taxa_names(fasta_filename), size = 2)

  lines <- beautier::create_beast2_input(
    input_filenames = fasta_filename,
    mrca_priors = create_mrca_prior(
      alignment_id = get_alignment_id(fasta_filename),
      taxa_names = taxa_names
    )
  )
  testthat::expect_true(are_beast2_input_lines(lines))
})

################################################################################
# Initial phylogenies
################################################################################

test_that("JC69 JC69 strict strict coalescent_exp_population", {

  input_fasta_filename_1 <- get_babette_path("anthus_aco.fas")
  input_fasta_filename_2 <- get_babette_path("anthus_nd2.fas")
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

  input_fasta_filename_1 <- get_babette_path("anthus_aco.fas")
  input_fasta_filename_2 <- get_babette_path("anthus_nd2.fas")
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

  input_fasta_filename_1 <- get_babette_path("anthus_aco.fas")
  input_fasta_filename_2 <- get_babette_path("anthus_nd2.fas")
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

  input_fasta_filename_1 <- get_babette_path("anthus_aco.fas")
  input_fasta_filename_2 <- get_babette_path("anthus_nd2.fas")
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

  input_filenames <- get_babette_paths(
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

test_that("use, one alignment, plot with nLTT", {

  skip("Expose bug, https://github.com/richelbilderbeek/babette/issues/10")
  out <- bbt_run(
    fasta_filenames = get_babette_path("anthus_aco.fas"),
    mcmc = create_mcmc(chain_length = 1000, store_every = 1000)
  )
  testit::assert(
    all(grepl(pattern = "STATE_", x = names(out$anthus_aco_trees)) == FALSE)
  )
  testthat::expect_silent(
    nLTT::nltts_plot(out$anthus_aco_trees)
  )

})

test_that("use, nested sampling", {

  testit::assert(mauricer::mrc_is_installed("NS"))
  out <- bbt_run(
    fasta_filenames = get_babette_path("anthus_aco.fas"),
    mcmc = create_mcmc_nested_sampling(
      chain_length = 1000,
      sub_chain_length = 500
    ),
    beast2_path = get_default_beast2_bin_path()
  )
  expect_true("ns" %in% names(out))
  expect_true("marg_log_lik" %in% names(out$ns))
  expect_true("marg_log_lik_sd" %in% names(out$ns))
})

test_that("abuse", {

  testthat::expect_error(
    bbt_run(
      fasta_filenames = get_babette_path("anthus_aco.fas"),
      rng_seed = 0 # Error here
    ),
    "'rng_seed' should be NA or non-zero positive"
  )
})
