context("bbt_run")

test_that("use, one alignment", {
  testit::assert(beastier::is_beast2_installed())

  out <- NA

  expect_silent(
    out <- bbt_run(
      fasta_filenames = get_babette_path("anthus_aco.fas"),
      mcmc = create_mcmc(chain_length = 1000, store_every = 1000)
    )
  )
  expect_true("estimates" %in% names(out))
  expect_true("anthus_aco_trees" %in% names(out))
  expect_true("operators" %in% names(out))
  expect_true("output" %in% names(out))
  expect_equal(class(out$anthus_aco_trees[[1]]), "phylo")
  expect_equal(length(out$anthus_aco_trees), 2)

  expect_true("Sample" %in% names(out$estimates))
  expect_true("posterior" %in% names(out$estimates))
  expect_true("likelihood" %in% names(out$estimates))
  expect_true("prior" %in% names(out$estimates))
  expect_true("treeLikelihood" %in% names(out$estimates))
  expect_true("TreeHeight" %in% names(out$estimates))
  expect_true("YuleModel" %in% names(out$estimates))
  expect_true("birthRate" %in% names(out$estimates))

  expect_true("operator" %in% names(out$operators))
  expect_true("p" %in% names(out$operators))
  expect_true("accept" %in% names(out$operators))
  expect_true("reject" %in% names(out$operators))
  expect_true("acceptFC" %in% names(out$operators))
  expect_true("rejectFC" %in% names(out$operators))
  expect_true("rejectIv" %in% names(out$operators))
  expect_true("rejectOp" %in% names(out$operators))
})

test_that("use, one alignment, verbose, cleanup", {
  testit::assert(beastier::is_beast2_installed())

  expect_output(
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

  expect_output(
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
  expect_true(file.exists(beast2_input_filename))
  expect_true(file.exists(beast2_output_log_filename))
  expect_true(file.exists(beast2_output_trees_filenames))
  expect_true(file.exists(beast2_output_state_filename))
})

test_that("use, one alignment, same RNG should give same results", {

  if (rappdirs::app_dir()$os == "mac") {
    skip("RNG seed is unreliable under macOS")
  }

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
  expect_identical(out_1, out_2)
})

test_that("abuse", {

  expect_error(
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
  if (!beastier::is_on_ci()) return()
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
  if (!beastier::is_on_ci()) return()
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
  if (!beastier::is_on_ci()) return()
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
  if (!beastier::is_on_ci()) return()
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
  if (!beastier::is_on_ci()) return()
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
  if (!beastier::is_on_ci()) return()
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
  if (!beastier::is_on_ci()) return()
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
  if (!beastier::is_on_ci()) return()
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
  if (!beastier::is_on_ci()) return()
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
  if (!beastier::is_on_ci()) return()
  expect_silent(
    bbt_run(
      fasta_filenames = get_beautier_path("anthus_aco_sub.fas"),
      tree_priors = create_ccp_tree_prior(),
      mcmc = beautier::create_mcmc(chain_length = 2000)
    )
  )
})

test_that("Run CCP tree prior with tip dating", {
  if (!beastier::is_on_ci()) return()
  expect_silent(
    bbt_run(
      fasta_filenames = beautier::get_beautier_path(
        "G_VII_pre2003_msa.fas"
      ),
      tipdates_filename = beautier::get_beautier_path(
        "G_VII_pre2003_dates_4.txt"
      ),
      tree_priors = create_ccp_tree_prior(),
      mcmc = beautier::create_mcmc(chain_length = 2000)
    )
  )
})

################################################################################
# Tree prior: CEP
################################################################################
test_that("Run CEP tree prior", {
  if (!beastier::is_on_ci()) return()
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
  if (!beastier::is_on_ci()) return()
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
    mrca_prior = create_mrca_prior(
      alignment_id = get_alignment_id(fasta_filename),
      taxa_names = get_taxa_names(fasta_filename)
    )
  )
  expect_true(are_beast2_input_lines(lines))
})

test_that("Run MRCA, MRCA distr", {

  fasta_filename <- get_fasta_filename()
  lines <- beautier::create_beast2_input(
    input_filenames = fasta_filename,
    mrca_prior = create_mrca_prior(
      alignment_id = get_alignment_id(fasta_filename),
      taxa_names = get_taxa_names(fasta_filename),
      mrca_distr = create_one_div_x_distr()
    )
  )
  expect_true(are_beast2_input_lines(lines))
})

test_that("Run MRCA, no distr, subset of taxa", {

  fasta_filename <- get_fasta_filename()
  set.seed(0)
  taxa_names <- sample(x = get_taxa_names(fasta_filename), size = 2)

  lines <- beautier::create_beast2_input(
    input_filenames = fasta_filename,
    mrca_prior = create_mrca_prior(
      alignment_id = get_alignment_id(fasta_filename),
      taxa_names = taxa_names
    )
  )
  expect_true(are_beast2_input_lines(lines))
})

test_that("RLN and non-monophyletic MRCA with distribution, Issue 29, #29", {

  # Thanks to Raphael Scherrer for sharing this bug
  fasta_filename <- get_fasta_filename()
  lines <- beautier::create_beast2_input(
    input_filenames = fasta_filename,
    clock_models = create_rln_clock_model(),
    mrca_prior = create_mrca_prior(
      alignment_id = get_alignment_id(fasta_filename),
      taxa_names = get_taxa_names(fasta_filename),
      is_monophyletic = FALSE,
      mrca_distr = create_one_div_x_distr() # Use simpler distribution
    )
  )
  expect_true(
    are_beast2_input_lines(
      lines, method = "deep"
    )
  )
})

test_that("RLN and monophyletic MRCA with distribution, Issue 29, #29", {

  # Thanks to Jana Riederer for sharing this bug
  fasta_filename <- get_fasta_filename()
  lines <- beautier::create_beast2_input(
    input_filenames = fasta_filename,
    clock_models = create_rln_clock_model(),
    mrca_prior = create_mrca_prior(
      alignment_id = get_alignment_id(fasta_filename),
      taxa_names = get_taxa_names(fasta_filename),
      is_monophyletic = TRUE,
      mrca_distr = create_one_div_x_distr() # Use simpler distributiob
    )
  )
  expect_true(
    are_beast2_input_lines(
      lines, method = "deep"
    )
  )
})

################################################################################
# nLTT
################################################################################

test_that("use, one alignment, plot with nLTT", {

  skip("Expose bug, https://github.com/richelbilderbeek/babette/issues/10")
  out <- bbt_run(
    fasta_filenames = get_babette_path("anthus_aco.fas"),
    mcmc = create_mcmc(chain_length = 1000, store_every = 1000)
  )
  testit::assert(
    all(grepl(pattern = "STATE_", x = names(out$anthus_aco_trees)) == FALSE)
  )
  expect_silent(
    nLTT::nltts_plot(out$anthus_aco_trees)
  )

})

test_that("with tip dating", {

  fasta_filename <- beautier::get_beautier_path("G_VII_pre2003_msa.fas")
  tipdates_filename <- beautier::get_beautier_path("G_VII_pre2003_dates_4.txt")
  lines <- beautier::create_beast2_input(
    input_filenames = fasta_filename,
    tipdates_filename = tipdates_filename,
    tree_priors = create_ccp_tree_prior()
  )
  expect_true(are_beast2_input_lines(lines))
})

test_that("abuse", {

  expect_error(
    bbt_run(
      fasta_filenames = get_babette_path("anthus_aco.fas"),
      rng_seed = 0 # Error here
    ),
    "'rng_seed' should be NA or non-zero positive"
  )


  expect_error(
    bbt_run(
      fasta_filenames = get_babette_path("anthus_aco.fas"),
      posterior_crown_age = 15
    ),
    "'posterior_crown_age' is deprecated"
  )

  expect_error(
    bbt_run(
      fasta_filenames = get_babette_path("anthus_aco.fas"),
      mrca_priors = "something"
    ),
    "'mrca_priors' is deprecated, use 'mrca_prior' instead"
  )

  expect_error(
    bbt_run(
      fasta_filenames = get_babette_path("anthus_aco.fas"),
      tree_prior = "something"
    ),
    "'tree_priors' is deprecated, use 'tree_prior' instead"
  )

})
