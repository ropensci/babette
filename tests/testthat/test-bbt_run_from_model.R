test_that("minimal use", {
  if (!beastier::is_beast2_installed()) return()

  bbt_out <- bbt_run_from_model(
    fasta_filename = get_babette_path("anthus_aco.fas"),
    inference_model = beautier::create_test_inference_model()
  )
  expect_equal(4, length(bbt_out$anthus_aco_trees))
  expect_equal(4, nrow(bbt_out$estimates))
})

test_that("minimal use with BEAUti shorthand", {
  if (!beastier::is_beast2_installed()) return()

  expect_silent(
    bbt_run_from_model(
      fasta_filename = get_babette_path("anthus_aco.fas"),
      inference_model = beautier::create_test_inference_model(
        mcmc = create_test_mcmc(
          tracelog = create_test_tracelog(filename = NA),
          treelog = create_test_treelog("$(tree).trees")
        )
      )
    )
  )
})

test_that("use, nested sampling", {

  if (!beastier::is_beast2_installed()) return()
  if (rappdirs::app_dir()$os == "win") return()
  if (!mauricer::is_beast2_ns_pkg_installed()) return()

  testit::assert(mauricer::is_beast2_ns_pkg_installed())
  out <- bbt_run_from_model(
    fasta_filename = get_babette_path("anthus_aco.fas"),
    inference_model = create_inference_model(
      mcmc = beautier::create_test_ns_mcmc()
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
    "'beast2_options' must be a valid 'BEAST2' options object"
  )
})

test_that("creates files", {

  if (!beastier::is_beast2_installed()) return()
  testit::assert(beastier::is_beast2_installed())

  inference_model <- create_test_inference_model()
  beast2_options <- create_beast2_options()

  bbt_out <- bbt_run_from_model(
    fasta_filename = get_babette_path("anthus_aco.fas"),
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  expect_true(file.exists(inference_model$mcmc$tracelog$filename))
  expect_true(file.exists(inference_model$mcmc$screenlog$filename))
  expect_true(file.exists(inference_model$mcmc$screenlog$filename))
  expect_true(file.exists(beast2_options$output_state_filename))
})

test_that("use, sub-sub-subfolder", {
  if (!beastier::is_beast2_installed()) return()

  mcmc <- beautier::create_test_mcmc(
    tracelog = create_test_tracelog(
      filename = file.path(
        tempfile(), "a", "b", "c", ".csv"
      )
    ),
    screenlog = create_test_screenlog(
      filename = file.path(
        tempfile(), "d", "e", "f", ".txt"
      )
    ),
    treelog = create_test_treelog(
      filename = file.path(
        tempfile(), "g", "h", "i", ".trees"
      )
    )
  )
  beast2_options <- create_beast2_options(
    output_state_filename = file.path(tempdir(), "j", "k", "l", ".xml.state")
  )

  bbt_out <- bbt_run_from_model(
    fasta_filename = get_babette_path("anthus_aco.fas"),
    inference_model = create_inference_model(mcmc = mcmc),
    beast2_options = beast2_options
  )
  # Checked: this does work on Linux
  expect_true(file.exists(mcmc$tracelog$filename))
  expect_true(file.exists(mcmc$screenlog$filename))
  expect_true(file.exists(mcmc$screenlog$filename))
  expect_true(file.exists(beast2_options$output_state_filename))
})

test_that("Run CBS tree prior with too few taxa must give clear error", {

  if (!beastier::is_on_ci()) return()
  if (!beastier::is_beast2_installed()) return()

  expect_error(
    bbt_run_from_model(
      fasta_filename = get_beautier_path("anthus_aco_sub.fas"),
      create_inference_model(
        tree_prior = create_cbs_tree_prior(
          group_sizes_dimension = 123
        )
      )
    ),
    "'group_sizes_dimension' .* must be less than the number of taxa"
  )
})
