test_that("output is well-formed", {

  if (!beastier::is_beast2_installed()) return()

  testit::assert(beastier::is_beast2_installed())

  mcmc <- create_test_mcmc()

  out <- bbt_run(
    fasta_filename = get_babette_path("anthus_aco.fas"),
    mcmc = mcmc
  )
  expect_true("estimates" %in% names(out))
  expect_true("anthus_aco_trees" %in% names(out))
  expect_true("operators" %in% names(out))
  expect_true("output" %in% names(out))
  expect_equal(class(out$anthus_aco_trees[[1]]), "phylo")

  #' The number of expected trees. The tree at state zero is also logged
  n_trees_expected <- 1 + (mcmc$chain_length / mcmc$treelog$log_every)
  expect_equal(length(out$anthus_aco_trees), n_trees_expected)

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

  if (!beastier::is_beast2_installed()) return()

  testit::assert(beastier::is_beast2_installed())

  expect_output(
    bbt_run(
      fasta_filename = get_babette_path("anthus_aco.fas"),
      mcmc = create_test_mcmc(chain_length = 2000),
      verbose = TRUE
    )
  )
})

test_that("use, one alignment, verbose, no cleanup", {

  if (!beastier::is_beast2_installed()) return()

  testit::assert(beastier::is_beast2_installed())

  fasta_filenames <- get_babette_path("anthus_aco.fas")
  beast2_input_filename <- beastier::create_temp_input_filename()
  beast2_output_state_filename <- beastier::create_temp_output_state_filename()

  testit::assert(!file.exists(beast2_input_filename))
  testit::assert(!file.exists(beast2_output_state_filename))

  expect_output(
    bbt_run(
      fasta_filename = fasta_filenames,
      mcmc = create_test_mcmc(chain_length = 2000),
      beast2_input_filename = beast2_input_filename,
      beast2_output_state_filename = beast2_output_state_filename,
      verbose = TRUE
    )
  )
  expect_true(file.exists(beast2_input_filename))
  expect_true(file.exists(beast2_output_state_filename))
})

test_that("same RNG seed gives same results", {

  if (!beastier::is_beast2_installed()) return()

  if (rappdirs::app_dir()$os == "mac") {
    return()
    # RNG seed is unreliable under macOS
  }

  testit::assert(beastier::is_beast2_installed())
  inference_model_1 <- create_test_inference_model()
  inference_model_2 <- create_test_inference_model()
  beast2_options_1 <- create_beast2_options(rng_seed = 42)
  beast2_options_2 <- create_beast2_options(rng_seed = 42)

  rng_seed <- 42
  out_1 <- bbt_run_from_model(
    fasta_filename = get_babette_path("anthus_aco.fas"),
    inference_model = inference_model_1,
    beast2_options = beast2_options_1
  )
  out_2 <- bbt_run_from_model(
    fasta_filename = get_babette_path("anthus_aco.fas"),
    inference_model = inference_model_1,
    beast2_options = beast2_options_1
  )
  expect_equal(length(out_1), length(out_2))

  # To show the lines that differ
  out_1$output[out_1$output != out_2$output]
  # Example:
  # [1] "Writing file /home/richel/.cache/tracelog_7ed358b9e023.log"
  # [2] "Writing file /home/richel/.cache/screenlog_7ed3567b6ea9.csv"
  # [3] "Writing file /home/richel/.cache/treelog_7ed3c268edc.trees"
  # [4] "Total calculation time: 0.956 seconds"

  # The screen output will be differ in four lines (see above)
  expect_equal(4, sum(out_1$output != out_2$output))

  # Here we replace the four sentences, because we know what these look like
  # After that, the text should be identical

  # The screen output will be different here:
  # [1] "Writing file /home/richel/.cache/tracelog_7ed358b9e023.log"
  replacement_1_index <- which(
    grepl(x = out_1$output, pattern = "Writing file.*/tracelog")
  )
  out_2$output[replacement_1_index] <- out_1$output[replacement_1_index]

  # [2] "Writing file /home/richel/.cache/screenlog_7ed3567b6ea9.csv"
  replacement_2_index <- which(
    grepl(x = out_1$output, pattern = "Writing file.*/screenlog")
  )
  out_2$output[replacement_2_index] <- out_1$output[replacement_2_index]

  # [3] "Writing file /home/richel/.cache/treelog_7ed3c268edc.trees"
  replacement_3_index <- which(
    grepl(x = out_1$output, pattern = "Writing file.*/treelog")
  )
  out_2$output[replacement_3_index] <- out_1$output[replacement_3_index]

  # [4] "Total calculation time: 0.956 seconds"
  replacement_4_index <- which(
    grepl(x = out_1$output, pattern = "Total calculation time: ")
  )
  out_2$output[replacement_4_index] <- out_1$output[replacement_4_index]

  expect_identical(out_1, out_2)
})

################################################################################
# Defaults
################################################################################

test_that("Run all defaults", {

  if (!beastier::is_beast2_installed()) return()
  if (!beastier::is_on_ci()) return()

  expect_silent(
    bbt_run(
      fasta_filename = get_beautier_path("anthus_aco_sub.fas"),
      mcmc = create_test_mcmc(chain_length = 2000)
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
  if (!beastier::is_beast2_installed()) return()

  expect_silent(
    bbt_run(
      fasta_filename = get_beautier_path("anthus_aco_sub.fas"),
      site_model = create_gtr_site_model(),
      mcmc = create_test_mcmc(chain_length = 2000)
    )
  )
})

################################################################################
# Site model: HKY
################################################################################

test_that("Run HKY", {

  if (!beastier::is_on_ci()) return()
  if (!beastier::is_beast2_installed()) return()

  expect_silent(
    bbt_run(
      fasta_filename = get_beautier_path("anthus_aco_sub.fas"),
      site_model = create_hky_site_model(),
      mcmc = create_test_mcmc(chain_length = 2000)
    )
  )
})

################################################################################
# Site model: JC69
################################################################################

test_that("Run JC69", {

  if (!beastier::is_on_ci()) return()
  if (!beastier::is_beast2_installed()) return()

  expect_silent(
    bbt_run(
      fasta_filename = get_beautier_path("anthus_aco_sub.fas"),
      site_model = create_jc69_site_model(),
      mcmc = create_test_mcmc(chain_length = 2000)
    )
  )
})

################################################################################
# Site model: TN93
################################################################################

test_that("Run TN93", {

  if (!beastier::is_on_ci()) return()
  if (!beastier::is_beast2_installed()) return()

  expect_silent(
    bbt_run(
      fasta_filename = get_beautier_path("anthus_aco_sub.fas"),
      site_model = create_tn93_site_model(),
      mcmc = create_test_mcmc(chain_length = 2000)
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
  if (!beastier::is_beast2_installed()) return()

  expect_silent(
    bbt_run(
      fasta_filename = get_beautier_path("anthus_aco_sub.fas"),
      clock_model = create_rln_clock_model(),
      mcmc = create_test_mcmc(chain_length = 2000)
    )
  )
})

################################################################################
# Clock model: strict
################################################################################
test_that("Run strict clock", {

  if (!beastier::is_on_ci()) return()
  if (!beastier::is_beast2_installed()) return()

  expect_silent(
    bbt_run(
      fasta_filename = get_beautier_path("anthus_aco_sub.fas"),
      clock_model = create_strict_clock_model(),
      mcmc = create_test_mcmc(chain_length = 2000)
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
  if (!beastier::is_beast2_installed()) return()

  expect_silent(
    bbt_run(
      fasta_filename = get_beautier_path("anthus_aco_sub.fas"),
      tree_prior = create_bd_tree_prior(),
      mcmc = create_test_mcmc(chain_length = 2000)
    )
  )
})

################################################################################
# Tree prior: CBS
################################################################################
test_that("Run CBS tree prior", {

  if (!beastier::is_on_ci()) return()
  if (!beastier::is_beast2_installed()) return()

  expect_silent(
    bbt_run(
      fasta_filename = get_beautier_path("anthus_aco_sub.fas"),
      tree_prior = create_cbs_tree_prior(
        group_sizes_dimension = 4
      ),
      mcmc = create_test_mcmc(chain_length = 2000)
    )
  )
})

test_that("Run CBS tree prior with too few taxa must give clear error", {

  if (!beastier::is_on_ci()) return()
  if (!beastier::is_beast2_installed()) return()

  expect_error(
    bbt_run(
      fasta_filename = get_beautier_path("anthus_aco_sub.fas"),
      tree_prior = create_cbs_tree_prior(
        group_sizes_dimension = 123
      )
    ),
    "'group_sizes_dimension' .* must be less than the number of taxa"
  )
})

################################################################################
# Tree prior: CCP
################################################################################
test_that("Run CCP tree prior", {

  if (!beastier::is_on_ci()) return()
  if (!beastier::is_beast2_installed()) return()

  expect_silent(
    bbt_run(
      fasta_filename = get_beautier_path("anthus_aco_sub.fas"),
      tree_prior = create_ccp_tree_prior(),
      mcmc = create_test_mcmc(chain_length = 2000)
    )
  )
})

test_that("Run CCP tree prior with tip dating", {
  if (!beastier::is_on_ci()) return()
  if (!beastier::is_beast2_installed()) return()

  expect_silent(
    bbt_run(
      fasta_filename = beautier::get_beautier_path(
        "G_VII_pre2003_msa.fas"
      ),
      tipdates_filename = beautier::get_beautier_path(
        "G_VII_pre2003_dates_4.txt"
      ),
      tree_prior = create_ccp_tree_prior(),
      mcmc = create_test_mcmc(chain_length = 2000)
    )
  )
})

################################################################################
# Tree prior: CEP
################################################################################
test_that("Run CEP tree prior", {
  if (!beastier::is_on_ci()) return()
  if (!beastier::is_beast2_installed()) return()
  expect_silent(
    bbt_run(
      fasta_filename = get_beautier_path("anthus_aco_sub.fas"),
      tree_prior = create_cep_tree_prior(),
      mcmc = create_test_mcmc(chain_length = 2000)
    )
  )
})


################################################################################
# Tree prior: Yule
################################################################################
test_that("Run Yule tree prior", {
  if (!beastier::is_on_ci()) return()
  if (!beastier::is_beast2_installed()) return()
  expect_silent(
    bbt_run(
      fasta_filename = get_beautier_path("anthus_aco_sub.fas"),
      tree_prior = create_yule_tree_prior(),
      mcmc = create_test_mcmc(chain_length = 2000)
    )
  )
})


################################################################################
# MRCA priors
################################################################################
test_that("Run MRCA, no distr", {

  if (!beastier::is_beast2_installed()) return()

  fasta_filename <- get_fasta_filename()
  lines <- beautier::create_beast2_input(
    input_filename = fasta_filename,
    mrca_prior = create_mrca_prior(
      alignment_id = get_alignment_id(fasta_filename),
      taxa_names = get_taxa_names(fasta_filename)
    )
  )
  expect_true(are_beast2_input_lines(lines))
})

test_that("Run MRCA, MRCA distr", {

  if (!beastier::is_beast2_installed()) return()

  fasta_filename <- get_fasta_filename()
  lines <- beautier::create_beast2_input(
    input_filename = fasta_filename,
    mrca_prior = create_mrca_prior(
      alignment_id = get_alignment_id(fasta_filename),
      taxa_names = get_taxa_names(fasta_filename),
      mrca_distr = create_one_div_x_distr()
    )
  )
  expect_true(are_beast2_input_lines(lines))
})

test_that("Run MRCA, no distr, subset of taxa", {

  if (!beastier::is_beast2_installed()) return()

  fasta_filename <- get_fasta_filename()
  set.seed(0)
  taxa_names <- sample(x = get_taxa_names(fasta_filename), size = 2)

  lines <- beautier::create_beast2_input(
    input_filename = fasta_filename,
    mrca_prior = create_mrca_prior(
      alignment_id = get_alignment_id(fasta_filename),
      taxa_names = taxa_names
    )
  )
  expect_true(are_beast2_input_lines(lines))
})

test_that("RLN and non-monophyletic MRCA with distribution, Issue 29, #29", {

  if (!beastier::is_beast2_installed()) return()

  # Thanks to Raphael Scherrer for sharing this bug
  fasta_filename <- get_fasta_filename()
  lines <- beautier::create_beast2_input(
    input_filename = fasta_filename,
    clock_model = create_rln_clock_model(),
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

  if (!beastier::is_beast2_installed()) return()

  # Thanks to Jana Riederer for sharing this bug
  fasta_filename <- get_fasta_filename()
  lines <- beautier::create_beast2_input(
    input_filename = fasta_filename,
    clock_model = create_rln_clock_model(),
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

  if (!beastier::is_beast2_installed()) return()

    out <- bbt_run(
    fasta_filename = get_babette_path("anthus_aco.fas"),
    mcmc = create_test_mcmc(chain_length = 2000)
  )
  testit::assert(
    all(grepl(pattern = "STATE_", x = names(out$anthus_aco_trees)) == FALSE)
  )
  expect_silent(
    nLTT::nltts_plot(out$anthus_aco_trees)
  )
})

test_that("with tip dating", {

  if (!beastier::is_beast2_installed()) return()

  fasta_filename <- beautier::get_beautier_path("G_VII_pre2003_msa.fas")
  tipdates_filename <- beautier::get_beautier_path("G_VII_pre2003_dates_4.txt")
  lines <- beautier::create_beast2_input(
    input_filename = fasta_filename,
    tipdates_filename = tipdates_filename,
    tree_prior = create_ccp_tree_prior()
  )
  expect_true(are_beast2_input_lines(lines))
})

test_that("abuse", {

  # Only check for deprecated arguments, the
  # rest is checked when 'create_inference_model' is applied
  # on all argument
  expect_error(
    bbt_run(
      fasta_filenames = get_babette_path("anthus_aco.fas")
    ),
    "'fasta_filenames' is deprecated, use 'fasta_filename' instead"
  )

  expect_error(
    bbt_run(
      fasta_filename = get_babette_path("anthus_aco.fas"),
      site_models = "something"
    ),
    "'site_models' is deprecated, use 'site_model' instead"
  )

  expect_error(
    bbt_run(
      fasta_filename = get_babette_path("anthus_aco.fas"),
      clock_models = "something"
    ),
    "'clock_models' is deprecated, use 'clock_model' instead"
  )

  expect_error(
    bbt_run(
      fasta_filename = get_babette_path("anthus_aco.fas"),
      tree_priors = "something"
    ),
    "'tree_priors' is deprecated, use 'tree_prior' instead"
  )

  expect_error(
    bbt_run(
      fasta_filename = get_babette_path("anthus_aco.fas"),
      posterior_crown_age = 15
    ),
    "'posterior_crown_age' is deprecated"
  )


  expect_error(
    bbt_run(
      fasta_filename = get_babette_path("anthus_aco.fas"),
      mrca_priors = "something"
    ),
    "'mrca_priors' is deprecated, use 'mrca_prior' instead"
  )

  expect_error(
    bbt_run(
      fasta_filename = get_babette_path("anthus_aco.fas"),
      cleanup = TRUE
    ),
    "'cleanup' is deprecated, cleanup must be done by the caller"
  )

  expect_error(
    bbt_run(
      fasta_filename = get_babette_path("anthus_aco.fas"),
      beast2_output_log_filename = "irrelevant"
    ),
    "'beast2_output_log_filename' is deprecated"
  )

  expect_error(
    bbt_run(
      fasta_filename = get_babette_path("anthus_aco.fas"),
      beast2_output_trees_filenames = "irrelevant"
    ),
    "'beast2_output_trees_filenames' is deprecated"
  )

  expect_error(
    bbt_run(
      fasta_filename = get_babette_path("anthus_aco.fas"),
      beast2_working_dir = "irrelevant"
    ),
    "'beast2_working_dir' is deprecated"
  )
})
