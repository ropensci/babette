context("bbt_run_from_model")

test_that("use, one alignment", {
  if (!beastier::is_beast2_installed()) return()

  bbt_out <- bbt_run_from_model(
    fasta_filename = get_babette_path("anthus_aco.fas"),
    inference_model = create_inference_model(
      mcmc = create_mcmc(chain_length = 3000, store_every = 1000)
    ),
    beast2_options = create_beast2_options(
      overwrite = TRUE
    )
  )
  expect_equal(4, length(bbt_out$anthus_aco_trees))
  expect_equal(4, nrow(bbt_out$estimates))
})

test_that("use, nested sampling", {

  if (!beastier::is_beast2_installed()) return()
  if (rappdirs::app_dir()$os == "win") return()
  if (!mauricer::is_beast2_ns_pkg_installed()) return()

  testit::assert(mauricer::is_beast2_ns_pkg_installed())
  out <- bbt_run_from_model(
    fasta_filename = get_babette_path("anthus_aco.fas"),
    inference_model = create_inference_model(
      mcmc = create_mcmc_nested_sampling(
        chain_length = 1000,
        store_every = 1000,
        sub_chain_length = 500
      )
    ),
    beast2_options = create_beast2_options(
      beast2_path = get_default_beast2_bin_path()
    )
  )
  expect_true("ns" %in% names(out))
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

test_that("use, one alignment", {
  if (!beastier::is_beast2_installed()) return()

  testit::assert(beastier::is_beast2_installed())

  bbt_out <- bbt_run_from_model(
    fasta_filename = get_babette_path("anthus_aco.fas"),
    inference_model = create_inference_model(
      tree_prior = create_yule_tree_prior(),
      mcmc = create_mcmc(chain_length = 3000, store_every = 1000)
    ),
    beast2_options = create_beast2_options(rng_seed = 42)
  )
  expect_equal(4, length(bbt_out$anthus_aco_trees))
  expect_equal(4, nrow(bbt_out$estimates))
})

test_that("use, from bug report", {

  if (!beastier::is_beast2_installed()) return()

  # Report at https://github.com/ropensci/babette/issues/65
  # Thanks @thijsjanzen
  testit::assert(beastier::is_beast2_installed())

  output_log_filename <- tempfile(fileext = ".log")

  bbt_out <- bbt_run_from_model(
    fasta_filename = get_babette_path("anthus_aco.fas"),
    inference_model = create_inference_model(
      tree_prior = create_yule_tree_prior(),
      mcmc = create_mcmc(chain_length = 3000, store_every = 1000)
    ),
    beast2_options = create_beast2_options(
      rng_seed = 42,
      verbose = TRUE,
      overwrite = TRUE,
      output_log_filename = output_log_filename
    )
  )
  # Checked: this does work on Linux
  expect_true(file.exists(output_log_filename))
})

test_that("use, sub-sub-subfolder", {
  if (!beastier::is_beast2_installed()) return()

  expect_silent(
    bbt_run_from_model(
      fasta_filename = get_babette_path("anthus_aco.fas"),
      inference_model = create_inference_model(
        mcmc = create_mcmc(chain_length = 3000, store_every = 1000)
      ),
      beast2_options = create_beast2_options(
        output_log_filename = file.path(tempdir(), "a", "b", "c", "d.log"),
        output_trees_filenames = file.path(tempdir(), "e", "f", "g", "h.trees"),
        output_state_filename = file.path(
          tempdir(), "i", "j", "k", "l.xml.state"
        ),
        overwrite = TRUE
      )
    )
  )
})
