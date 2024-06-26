test_that("output is well-formed", {

  skip_if_not(beastier::is_beast2_installed(), message = "beast2 not installed")

  mcmc <- create_test_mcmc()
  inference_model <- beautier::create_inference_model(
    mcmc = mcmc
  )
  beast2_options <- create_beast2_options()
  out <- bbt_run_from_model(
    fasta_filename = get_babette_path("anthus_aco.fas"),
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )

  expect_true("estimates" %in% names(out))
  expect_true("anthus_aco_trees" %in% names(out))
  expect_true("operators" %in% names(out))
  expect_true("output" %in% names(out))
  expect_true(inherits(out$anthus_aco_trees[[1]], "phylo"))

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

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})

test_that("use, one alignment, verbose, cleanup", {

  if (!beastier::is_beast2_installed()) return()

  inference_model <- beautier::create_test_inference_model()
  beast2_options <- create_beast2_options(verbose = TRUE)

  suppressMessages(
    expect_output(
      bbt_run_from_model(
        fasta_filename = get_babette_path("anthus_aco.fas"),
        inference_model = inference_model,
        beast2_options = beast2_options
      )
    )
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})

test_that("use, one alignment, verbose, no cleanup", {

  if (!beastier::is_beast2_installed()) return()

  inference_model <- beautier::create_test_inference_model()
  beast2_input_filename <- beastier::create_temp_input_filename()
  beast2_output_state_filename <- beastier::create_temp_state_filename()
  expect_false(file.exists(beast2_input_filename))
  expect_false(file.exists(beast2_output_state_filename))
  beast2_options <- create_beast2_options(
    input_filename = beast2_input_filename,
    output_state_filename = beast2_output_state_filename
  )
  bbt_out <- bbt_run_from_model(
    fasta_filename = get_babette_path("anthus_aco.fas"),
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  expect_true(file.exists(beast2_input_filename))
  expect_true(file.exists(beast2_output_state_filename))
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})

test_that("same RNG seed gives same results", {

  skip_if_not(beastier::is_beast2_installed(), message = "beast2 not installed")
  skip_on_os("mac")
  # RNG seed is unreliable under macOS

  rng_seed <- 42
  inference_model_1 <- create_test_inference_model()
  inference_model_2 <- create_test_inference_model()
  beast2_options_1 <- create_beast2_options(rng_seed = rng_seed)
  beast2_options_2 <- create_beast2_options(rng_seed = rng_seed)

  out_1 <- bbt_run_from_model(
    fasta_filename = get_babette_path("anthus_aco.fas"),
    inference_model = inference_model_1,
    beast2_options = beast2_options_1
  )
  out_2 <- bbt_run_from_model(
    fasta_filename = get_babette_path("anthus_aco.fas"),
    inference_model = inference_model_2,
    beast2_options = beast2_options_2
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
  expect_equal(6, sum(out_1$output != out_2$output))

  # Here we replace the six sentences, because we know what these look like
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


  # [5] "Writing state to file
  # /home/richel/.cache/beastier/beast2_77d06866b6d2.xml.state"
  replacement_5_index <- which(
    grepl(x = out_1$output, pattern = "Writing state to file")
  )
  out_2$output[replacement_5_index] <- out_1$output[replacement_5_index]

  # [6] "File: beast2_77d035d6bccb.xml seed: 42 threads: 1"
  replacement_6_index <- which(
    grepl(x = out_1$output, pattern = "File.*seed:.*threads")
  )
  out_2$output[replacement_6_index] <- out_1$output[replacement_6_index]

  expect_identical(out_1, out_2)
  bbt_delete_temp_files(
    inference_model = inference_model_1,
    beast2_options = beast2_options_1
  )
  bbt_delete_temp_files(
    inference_model = inference_model_2,
    beast2_options = beast2_options_2
  )

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})

################################################################################
# Defaults
################################################################################

test_that("Run all defaults", {

  if (!beastier::is_beast2_installed()) return()
  if (!beautier::is_on_ci()) return()

  inference_model <- beautier::create_test_inference_model()
  beast2_options <- create_beast2_options()
  bbt_out <- bbt_run_from_model(
    fasta_filename = get_beautier_path("anthus_aco_sub.fas"),
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})

################################################################################
# Site models
################################################################################

################################################################################
# Site model: GTR
################################################################################

test_that("Run GTR", {

  if (!beautier::is_on_ci()) return()
  skip_if_not(beastier::is_beast2_installed(), message = "beast2 not installed")

  inference_model <- beautier::create_test_inference_model(
    site_model = create_gtr_site_model()
  )
  beast2_options <- create_beast2_options()
  bbt_out <- bbt_run_from_model(
    fasta_filename = get_beautier_path("anthus_aco_sub.fas"),
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})

################################################################################
# Site model: HKY
################################################################################

test_that("Run HKY", {

  if (!beautier::is_on_ci()) return()
  skip_if_not(beastier::is_beast2_installed(), message = "beast2 not installed")

  inference_model <- beautier::create_test_inference_model(
    site_model = create_hky_site_model()
  )
  beast2_options <- create_beast2_options()
  bbt_out <- bbt_run_from_model(
    fasta_filename = get_beautier_path("anthus_aco_sub.fas"),
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})

################################################################################
# Site model: JC69
################################################################################

test_that("Run JC69", {

  if (!beautier::is_on_ci()) return()
  skip_if_not(beastier::is_beast2_installed(), message = "beast2 not installed")

  inference_model <- beautier::create_test_inference_model(
    site_model = create_jc69_site_model()
  )
  beast2_options <- create_beast2_options()
  bbt_out <- bbt_run_from_model(
    fasta_filename = get_beautier_path("anthus_aco_sub.fas"),
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})

################################################################################
# Site model: TN93
################################################################################

test_that("Run TN93", {

  if (!beautier::is_on_ci()) return()
  skip_if_not(beastier::is_beast2_installed(), message = "beast2 not installed")

  inference_model <- beautier::create_test_inference_model(
    site_model = create_tn93_site_model()
  )
  beast2_options <- create_beast2_options()
  bbt_out <- bbt_run_from_model(
    fasta_filename = get_beautier_path("anthus_aco_sub.fas"),
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})

################################################################################
# Clock models
################################################################################

################################################################################
# Clock model: RLN
################################################################################
test_that("Run RLN clock", {

  if (!beautier::is_on_ci()) return()
  if (!beastier::is_beast2_installed()) return()

  inference_model <- beautier::create_test_inference_model(
    clock_model = create_rln_clock_model()
  )
  beast2_options <- create_beast2_options()
  bbt_out <- bbt_run_from_model(
    fasta_filename = get_beautier_path("anthus_aco_sub.fas"),
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})

################################################################################
# Clock model: strict
################################################################################
test_that("Run strict clock", {

  if (!beautier::is_on_ci()) return()
  if (!beastier::is_beast2_installed()) return()

  inference_model <- beautier::create_test_inference_model(
    clock_model = create_strict_clock_model(),
  )
  beast2_options <- create_beast2_options()
  bbt_out <- bbt_run_from_model(
    fasta_filename = get_beautier_path("anthus_aco_sub.fas"),
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})

################################################################################
# Tree priors
################################################################################

################################################################################
# Tree prior: BD
################################################################################
test_that("Run BD tree prior", {

  if (!beautier::is_on_ci()) return()
  skip_if_not(beastier::is_beast2_installed(), message = "beast2 not installed")

  inference_model <- beautier::create_test_inference_model(
    tree_prior = create_bd_tree_prior()
  )
  beast2_options <- create_beast2_options()
  bbt_out <- bbt_run_from_model(
    fasta_filename = get_beautier_path("anthus_aco_sub.fas"),
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})

################################################################################
# Tree prior: CBS
################################################################################
test_that("Run CBS tree prior", {

  if (!beautier::is_on_ci()) return()
  skip_if_not(beastier::is_beast2_installed(), message = "beast2 not installed")

  inference_model <- beautier::create_inference_model(
    tree_prior = create_cbs_tree_prior(
      group_sizes_dimension = 4
    )
  )
  beast2_options <- create_beast2_options()
  bbt_out <- bbt_run_from_model(
    fasta_filename = get_beautier_path("anthus_aco_sub.fas"),
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})

test_that("Run CBS tree prior with too few taxa must give clear error", {

  if (!beautier::is_on_ci()) return()
  if (!beastier::is_beast2_installed()) return()

  inference_model <- beautier::create_test_inference_model(
    tree_prior = create_cbs_tree_prior(
      group_sizes_dimension = 123
    )
  )
  beast2_options <- create_beast2_options()
  expect_error(
    bbt_run_from_model(
      fasta_filename = get_beautier_path("anthus_aco_sub.fas"),
      inference_model = inference_model,
      beast2_options = beast2_options
    ),
    "'group_sizes_dimension' .* must be less than the number of taxa"
  )

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})

################################################################################
# Tree prior: CCP
################################################################################
test_that("Run CCP tree prior", {

  if (!beautier::is_on_ci()) return()
  skip_if_not(beastier::is_beast2_installed(), message = "beast2 not installed")
  inference_model <- beautier::create_test_inference_model(
    tree_prior = create_ccp_tree_prior()
  )
  beast2_options <- create_beast2_options()
  bbt_out <- bbt_run_from_model(
    fasta_filename = get_beautier_path("anthus_aco_sub.fas"),
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})

test_that("Run CCP tree prior with tip dating", {
  if (!beautier::is_on_ci()) return()
  skip_if_not(beastier::is_beast2_installed(), message = "beast2 not installed")
  inference_model <- beautier::create_test_inference_model(
    tree_prior = create_ccp_tree_prior(),
    tipdates_filename = beautier::get_beautier_path(
      "G_VII_pre2003_dates_4.txt"
    )
  )
  beast2_options <- create_beast2_options()
  bbt_out <- bbt_run_from_model(
    fasta_filename = beautier::get_beautier_path(
      "G_VII_pre2003_msa.fas"
    ),
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})

################################################################################
# Tree prior: CEP
################################################################################
test_that("Run CEP tree prior", {
  if (!beautier::is_on_ci()) return()
  if (!beastier::is_beast2_installed()) return()
  inference_model <- beautier::create_test_inference_model(
    tree_prior = create_cep_tree_prior()
  )
  beast2_options <- create_beast2_options()
  bbt_out <- bbt_run_from_model(
    fasta_filename = get_beautier_path("anthus_aco_sub.fas"),
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})


################################################################################
# Tree prior: Yule
################################################################################
test_that("Run Yule tree prior", {
  if (!beautier::is_on_ci()) return()
  skip_if_not(beastier::is_beast2_installed(), message = "beast2 not installed")
  inference_model <- create_inference_model(
    tree_prior = create_yule_tree_prior(),
    mcmc = create_test_mcmc(chain_length = 2000)
  )
  beast2_options <- create_beast2_options()
  bbt_run_from_model(
    fasta_filename = get_beautier_path("anthus_aco_sub.fas"),
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})


################################################################################
# MRCA priors
################################################################################
test_that("Run MRCA, no distr", {
  skip_if_not(beastier::is_beast2_installed(), message = "beast2 not installed")

  fasta_filename <- get_fasta_filename()
  lines <- beautier::create_beast2_input(
    input_filename = fasta_filename,
    mrca_prior = create_mrca_prior(
      alignment_id = get_alignment_id(fasta_filename),
      taxa_names = get_taxa_names(fasta_filename)
    )
  )
  expect_true(are_beast2_input_lines(lines))
  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})

test_that("Run MRCA, MRCA distr", {

  skip_if_not(beastier::is_beast2_installed(), message = "beast2 not installed")

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

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
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

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})

test_that("RLN and non-monophyletic MRCA with distribution, Issue 29, #29", {
  skip("#29")

  skip_if_not(beastier::is_beast2_installed(), message = "beast2 not installed")


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
    ),
    beauti_options = create_beauti_options_v2_6()
  )
  expect_true(
    are_beast2_input_lines(
      lines, method = "deep"
    )
  )

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})

test_that("RLN and monophyletic MRCA with distribution, Issue 29, #29", {
  skip("#29")

  skip_if_not(beastier::is_beast2_installed(), message = "beast2 not installed")

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
    ),
    beauti_options = create_beauti_options_v2_6()
  )
  expect_true(
    are_beast2_input_lines(
      lines, method = "deep"
    )
  )
  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()

})

################################################################################
# nLTT
################################################################################

test_that("use, one alignment, plot with nLTT", {

  if (!beastier::is_beast2_installed()) return()

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()

  inference_model <- create_test_inference_model()
  beast2_options <- create_beast2_options()
  out <- bbt_run_from_model(
    fasta_filename = get_babette_path("anthus_aco.fas"),
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  expect_silent(
    nLTT::nltts_plot(out$anthus_aco_trees)
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})

test_that("with tip dating", {

  skip_if_not(beastier::is_beast2_installed(), message = "beast2 not installed")

  fasta_filename <- beautier::get_beautier_path("G_VII_pre2003_msa.fas")
  tipdates_filename <- beautier::get_beautier_path("G_VII_pre2003_dates_4.txt")
  lines <- beautier::create_beast2_input(
    input_filename = fasta_filename,
    tipdates_filename = tipdates_filename,
    tree_prior = create_ccp_tree_prior()
  )
  expect_true(are_beast2_input_lines(lines))

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})
