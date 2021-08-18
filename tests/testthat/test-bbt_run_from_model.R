test_that("minimal use", {
  if (!beastier::is_beast2_installed()) return()

  inference_model <- beautier::create_test_inference_model()
  beast2_options <- create_beast2_options()

  bbt_out <- bbt_run_from_model(
    fasta_filename = get_babette_path("anthus_aco.fas"),
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  expect_equal(4, length(bbt_out$anthus_aco_trees))
  expect_equal(4, nrow(bbt_out$estimates))
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  beautier::check_empty_beautier_folder()
  beastier::check_empty_beastier_folder()
  # beastierinstall::clear_beautier_cache() ; beastierinstall::clear_beastier_cache() # nolint
})

test_that("minimal use with BEAUti shorthand", {
  if (!beastier::is_beast2_installed()) return()

  inference_model <- beautier::create_test_inference_model(
    mcmc = create_test_mcmc(
      tracelog = create_test_tracelog(filename = NA),
      treelog = create_test_treelog("$(tree).trees")
    )
  )
  beast2_options <- create_beast2_options()

  expect_silent(
    bbt_run_from_model(
      fasta_filename = get_babette_path("anthus_aco.fas"),
      inference_model = inference_model,
      beast2_options = beast2_options
    )
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  beautier::check_empty_beautier_folder()
  beastier::check_empty_beastier_folder()
  beastierinstall::clear_beastier_cache()
  beastierinstall::clear_beautier_cache()
})

test_that("use, nested sampling", {

  if (!beastier::is_beast2_installed()) return()
  if (rappdirs::app_dir()$os == "win") return()
  if (!mauricer::is_beast2_ns_pkg_installed()) return()

  inference_model <- create_inference_model(
    mcmc = beautier::create_test_ns_mcmc()
  )
  beast2_options <- create_beast2_options(
    beast2_path = get_default_beast2_bin_path()
  )

  out <- bbt_run_from_model(
    fasta_filename = get_babette_path("anthus_aco.fas"),
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  expect_true("ns" %in% names(out))
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  beautier::check_empty_beautier_folder()
  beastier::check_empty_beastier_folder()
  beastierinstall::clear_beautier_cache()
  beastierinstall::clear_beastier_cache()
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
  beastier::check_empty_beastier_folder()
  beautier::check_empty_beautier_folder()
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
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )
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
  inference_model <- create_inference_model(mcmc = mcmc)

  bbt_out <- bbt_run_from_model(
    fasta_filename = get_babette_path("anthus_aco.fas"),
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  # Checked: this does work on Linux
  expect_true(file.exists(mcmc$tracelog$filename))
  expect_true(file.exists(mcmc$screenlog$filename))
  expect_true(file.exists(mcmc$screenlog$filename))
  expect_true(file.exists(beast2_options$output_state_filename))
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )
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
  beautier::check_empty_beautier_folder()
  beastier::check_empty_beastier_folder()
})

test_that("use, nested sampling, in custom folder", {

  if (rappdirs::app_dir()$os == "win") return()
  if (!beastier::is_on_ci()) return()
  if (!curl::has_internet()) return()

  # Cannot use tempfile on Travis CI
  beast2_folder <- file.path(
    rappdirs::user_cache_dir(),
    basename(tempfile(pattern = "babette_"))
  )
  beastierinstall::install_beast2(folder_name = beast2_folder)
  mauricerinstall::install_beast2_pkg(
    name = "NS",
    beast2_folder = beast2_folder
  )
  expect_true(mauricer::is_beast2_ns_pkg_installed(
    beast2_folder = beast2_folder)
  )
  expect_silent(
    bbt_run_from_model(
      fasta_filename = get_babette_path("anthus_aco.fas"),
      inference_model = beautier::create_test_ns_inference_model(),
      beast2_options = create_beast2_options(
        beast2_path = get_default_beast2_bin_path(beast2_folder = beast2_folder)
      )
    )
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )
})
