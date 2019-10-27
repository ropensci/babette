test_that("use", {
  inference_model <- beautier::create_test_inference_model()
  beast2_options <- create_beast2_options()
  expect_silent(prepare_file_creation(inference_model, beast2_options))
})

test_that("tracelog file in sub-sub-sub-folder", {
  filename <- file.path(
    tempfile(tmpdir = rappdirs::user_cache_dir()),
    "sub", "sub", "sub", "file.log"
  )

  # Cannot create the file yet, as the sub-sub-folders are not created
  expect_warning(file.create(filename))

  inference_model <- beautier::create_test_inference_model(
    mcmc = create_test_mcmc(
      tracelog = create_test_tracelog(
        filename = filename
      )
    )
  )
  beast2_options <- create_beast2_options()
  expect_silent(prepare_file_creation(inference_model, beast2_options))
})

test_that("screenlog file in sub-sub-sub-folder", {
  filename <- file.path(
    tempfile(tmpdir = rappdirs::user_cache_dir()),
    "sub", "sub", "sub", "file.csv"
  )

  # Cannot create the file yet, as the sub-sub-folders are not created
  expect_warning(file.create(filename))

  inference_model <- beautier::create_test_inference_model(
    mcmc = create_test_mcmc(
      screenlog = create_test_screenlog(
        filename = filename
      )
    )
  )
  beast2_options <- create_beast2_options()
  expect_silent(prepare_file_creation(inference_model, beast2_options))
})

test_that("treelog file in sub-sub-sub-folder", {
  filename <- file.path(
    tempfile(tmpdir = rappdirs::user_cache_dir()),
    "sub", "sub", "sub", "file.trees"
  )

  # Cannot create the file yet, as the sub-sub-folders are not created
  expect_warning(file.create(filename))

  inference_model <- beautier::create_test_inference_model(
    mcmc = create_test_mcmc(
      treelog = create_test_treelog(
        filename = filename
      )
    )
  )
  beast2_options <- create_beast2_options()
  expect_silent(prepare_file_creation(inference_model, beast2_options))
})

test_that("output_state_filename in sub-sub-sub-folder", {
  filename <- file.path(
    tempfile(tmpdir = rappdirs::user_cache_dir()),
    "sub", "sub", "sub", "file.xml.state"
  )

  # Cannot create the file yet, as the sub-sub-folders are not created
  expect_warning(file.create(filename))

  inference_model <- beautier::create_test_inference_model()
  beast2_options <- create_beast2_options(
    output_state_filename = filename
  )
  expect_silent(prepare_file_creation(inference_model, beast2_options))
})

test_that("state file in root folder", {
  filename <- "/not_in_root_please.xml.state"

  # Cannot create the file yet, as the sub-sub-folders are not created
  expect_warning(file.create(filename))

  inference_model <- beautier::create_test_inference_model()
  beast2_options <- create_beast2_options(
    output_state_filename = filename
  )
  expect_error(prepare_file_creation(inference_model, beast2_options))
})
