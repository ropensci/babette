test_that("minimal use", {
  if (!beastier::is_beast2_installed()) return()

  fasta_filename <- beautier::get_beautier_path("test_output_0.fas")
  inference_model <- beautier::create_test_inference_model()
  beast2_options <- beastier::create_beast2_options()

  bbt_out <- bbt_run_from_model(
    fasta_filename = fasta_filename,
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  expect_equal(4, length(bbt_out$test_output_0_trees))
  expect_equal(4, nrow(bbt_out$estimates))
  bbt_out <- bbt_continue(
    fasta_filename = fasta_filename,
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  expect_equal(7, length(bbt_out$test_output_0_trees))
  expect_equal(7, nrow(bbt_out$estimates))
  bbt_out <- bbt_continue(
    fasta_filename = fasta_filename,
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  expect_equal(10, length(bbt_out$test_output_0_trees))
  expect_equal(10, nrow(bbt_out$estimates))
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )
})


test_that("different lengths", {
  if (!beastier::is_beast2_installed()) return()

  fasta_filename <- beautier::get_beautier_path("test_output_0.fas")
  inference_model <- beautier::create_test_inference_model()
  beast2_options <- beastier::create_beast2_options()

  bbt_out <- bbt_run_from_model(
    fasta_filename = fasta_filename,
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  expect_equal(4, length(bbt_out$test_output_0_trees))
  expect_equal(4, nrow(bbt_out$estimates))

  # Double next length
  inference_model$mcmc$chain_length <- inference_model$mcmc$chain_length * 2
  beautier::create_beast2_input_file_from_model(
    input_filename = fasta_filename,
    output_filename = beast2_options$input_filename,
    inference_model = inference_model
  )

  bbt_out <- bbt_continue(
    fasta_filename = fasta_filename,
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  expect_equal(10, length(bbt_out$test_output_0_trees))
  expect_equal(10, nrow(bbt_out$estimates))
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )
})
