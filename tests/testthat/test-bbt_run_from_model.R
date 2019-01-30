context("bbt_run_from_model")

test_that("use, one alignment", {
  testit::assert(beastier::is_beast2_installed())

  expect_silent(
    bbt_run_from_model(
      fasta_filename = get_babette_path("anthus_aco.fas"),
      inference_model = create_inference_model(
        mcmc = create_mcmc(chain_length = 1000, store_every = 1000)
      ),
      beast2_options = create_beast2_options(
        overwrite = TRUE
      )
    )
  )
})

test_that("abuse", {

  expect_error(
    bbt_run_from_model(
      fasta_filename = get_babette_path("anthus_aco.fas"),
      inference_model = "nonsense"
    ),
    "'inference_model' must be a valid inference model"
  )
  expect_error(
    bbt_run_from_model(
      fasta_filename = get_babette_path("anthus_aco.fas"),
      beast2_options = "nonsense"
    ),
    "'beast2_options' must be a valid BEAST2 options object"
  )
})
