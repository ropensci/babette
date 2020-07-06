test_that("use", {

  skip("Issue 90, Issue #90")
  filename <- get_babette_path(
    "Felinecoronavirus_Envelope_1.fas"
  )
  tipdates_filename <- get_babette_path(
    "Felinecoronavirus_Envelope_1_no_quotes.txt"
  )
  inference_model <- create_inference_model(
    tipdates_filename = tipdates_filename,
    clock_model = create_rln_clock_model()
  )
  #check_inference_model(inference_model)

  # output_filename <- tempfile()
  # beautier::create_beast2_input_file_from_model(
  #   input_filename = filename,
  #   output_filename = output_filename,
  #   inference_model = inference_model
  # )

  # Could not find object associated with idref clockRate.c:Felinecoronavirus_Envelope_1          # nolint
  #                                                                                               # nolint
  # Error detected about here:                                                                    # nolint
  #                                                                                               # nolint
  # <beast>                                                                                       # nolint
  #   <run id='mcmc' spec='MCMC'>                                                                 # nolint
  #     <operator id='StrictClockRateScaler.c:Felinecoronavirus_Envelope_1' spec='ScaleOperator'> # nolint
  #       <input>                                                                                 # nolint

  expect_silent(
    bbt_run_from_model(
      fasta_filename = filename,
      beast2_options = create_beast2_options(verbose = TRUE),
      inference_model = inference_model
    )
  )
})
