test_that("use", {

  skip("Issue 90, Issue #90")
  filename <- get_babette_path(
    "Felinecoronavirus_Envelope_1.fas"
  )
  tipdates_filename <- get_babette_path(
    "Felinecoronavirus_Envelope_1_no_quotes.txt"
  )
  inference_model <- create_inference_model(
    mcmc = create_mcmc(chain_length = 10000),
    tipdates_filename = tipdates_filename,
    site_model = create_jc69_site_model(),
    clock_model = create_rln_clock_model(
      mean_clock_rate =  0.001,
      mean_rate_prior_distr = create_normal_distr()
    ),
    tree_prior = create_cbs_tree_prior()
  )
  check_inference_model(inference_model)

  output_filename <- tempfile()
  beautier::create_beast2_input_file_from_model(
    input_filename = filename,
    output_filename = output_filename,
    inference_model = inference_model
  )
  readLines(output_filename)
  inference_model$mcmc$tracelog$filename <- gsub(
    pattern = ".fas", ".log", filename
  )
  inference_model$mcmc$treelog$filename <- gsub(
    pattern = ".fas", ".trees", filename
  )

  expect_silent(
    bbt_run_from_model(
      fasta_filename = filename,
      beast2_options = create_beast2_options(verbose = TRUE),
      inference_model = inference_model
    )
  )
})
