test_that("use", {

  if (!beastier::is_beast2_installed()) return()

  inference_model <- create_test_inference_model()
  beast2_options <- create_beast2_options()

  expect_silent(
    bbt_run_from_model(
      fasta_filename = get_fasta_filename(),
      inference_model = inference_model,
      beast2_options = beast2_options
    )
  )
  # Temp files created
  expect_true(file.exists(inference_model$mcmc$tracelog$filename))
  expect_true(file.exists(inference_model$mcmc$treelog$filename))
  expect_true(file.exists(inference_model$mcmc$screenlog$filename))
  expect_true(file.exists(beast2_options$input_filename))
  expect_true(file.exists(beast2_options$output_state_filename))

  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )

  # Temp files created
  expect_false(file.exists(inference_model$mcmc$tracelog$filename))
  expect_false(file.exists(inference_model$mcmc$treelog$filename))
  expect_false(file.exists(inference_model$mcmc$screenlog$filename))
  expect_false(file.exists(beast2_options$input_filename))
  expect_false(file.exists(beast2_options$output_state_filename))
})
