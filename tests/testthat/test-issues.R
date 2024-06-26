test_that("use", {
  if (!is_beast2_installed()) return()

  filename <- get_babette_path(
    "Felinecoronavirus_Envelope_1.fas"
  )
  tipdates_filename <- get_babette_path(
    "Felinecoronavirus_Envelope_1_no_quotes.txt"
  )
  inference_model <- create_test_inference_model(
    tipdates_filename = tipdates_filename,
    clock_model = create_rln_clock_model(),
    beauti_options = create_beauti_options_v2_6()
  )

  # Could not find object associated with idref clockRate.c:Felinecoronavirus_Envelope_1          # nolint
  #                                                                                               # nolint
  # Error detected about here:                                                                    # nolint
  #                                                                                               # nolint
  # <beast>                                                                                       # nolint
  #   <run id='mcmc' spec='MCMC'>                                                                 # nolint
  #     <operator id='StrictClockRateScaler.c:Felinecoronavirus_Envelope_1' spec='ScaleOperator'> # nolint
  #       <input>                                                                                 # nolint
  beast2_options <- create_beast2_options()

  expect_silent(
    bbt_run_from_model(
      fasta_filename = filename,
      inference_model = inference_model,
      beast2_options = beast2_options
    )
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})

test_that("use", {
  if (!is_beast2_installed()) return()
  # Must be similar XML as
  # beautier::get_beautier_path("rln_and_tipdates_babette_issue_26.xml")
  inference_model <- create_test_inference_model(
    clock_model = create_rln_clock_model(),
    tipdates_filename = beautier::get_beautier_path(
      "test_output_0_tipdates.tsv"
    ),
    beauti_options = create_beauti_options_v2_6()
  )
  beast2_options <- create_beast2_options()
  bbt_run_from_model(
    fasta_filename = get_fasta_filename(),
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )
})

test_that("clockRate.c ID and ClockPrior.c ID added twice", {

  if (!is_beast2_installed()) return()

  # clock_model
  clock_rate <- 0.0000001
  clock_model <- create_strict_clock_model(
    clock_rate_param = create_clock_rate_param(value = clock_rate),
    clock_rate_distr = create_log_normal_distr(
      value = clock_rate,
      m = 1,
      s = 1.25
    )
  )

  # MRCA PRIOR
  mrca_prior <- create_mrca_prior(
    is_monophyletic = TRUE,
    mrca_distr = create_laplace_distr(mu = 1990)
  )

  inference_model <- create_test_inference_model(
    clock_model = clock_model,
    mrca_prior = mrca_prior,
    tipdates_filename = beautier::get_beautier_path(
      "THAILAND_TEST.clust_1.dated.txt"
    ),
    mcmc = create_test_mcmc()
  )
  beast2_options <- create_beast2_options()
  expect_silent(
    bbt_run_from_model(
      fasta_filename = beautier::get_beautier_path(
        "THAILAND_TEST.clust_1.dated.fa"
      ),
      inference_model = inference_model,
      beast2_options = beast2_options
    )
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})


test_that("Issue 106. Issue #106", {

  if (!is_on_ci()) return()
  if (!is_beast2_installed()) return()

  fasta_filename <- beautier::get_fasta_filename()
  sample_interval <- 10000
  mrca_pr <- beautier::create_mrca_prior(
    taxa_names = beautier::get_taxa_names(fasta_filename),
    is_monophyletic = TRUE,
    mrca_distr = beautier::create_distr_normal(mean = 66, sigma = 1)
  )

  inf_model <- beautier::create_inference_model(
    tree_prior = beautier::create_bd_tree_prior(),
    clock_model = beautier::create_clock_model_rln(mean_clock_rate = ),
    mcmc = beautier::create_mcmc(
      chain_length = 1e6,
      store_every = sample_interval
    ),
    mrca_prior = mrca_pr,
    beauti_options = beautier::create_beauti_options_v2_6()
  )

  expect_silent(
    babette::bbt_run_from_model(
      fasta_filename = fasta_filename,
      inference_model = inf_model,
      beast2_options = beastier::create_beast2_options(rng_seed = 42)
    )
  )
})
