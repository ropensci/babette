context("run_beast2")

test_that("use, one alignment", {

  out <- NA

  testthat::expect_silent(
    out <- run_beast2(
      fasta_filenames = get_path("anthus_aco_sub.fas"),
      mcmc = create_mcmc(chain_length = 2000, store_every = 1000)
    )
  )

  testthat::expect_true("estimates" %in% names(out))
  testthat::expect_true("anthus_aco_sub_trees" %in% names(out))
  testthat::expect_true("operators" %in% names(out))
  testthat::expect_equal(class(out$anthus_aco_sub_trees[[1]]), "phylo")
  testthat::expect_equal(length(out$anthus_aco_sub_trees), 2)

  testthat::expect_true("Sample" %in% names(out$estimates))
  testthat::expect_true("posterior" %in% names(out$estimates))
  testthat::expect_true("likelihood" %in% names(out$estimates))
  testthat::expect_true("prior" %in% names(out$estimates))
  testthat::expect_true("treeLikelihood" %in% names(out$estimates))
  testthat::expect_true("TreeHeight" %in% names(out$estimates))
  testthat::expect_true("YuleModel" %in% names(out$estimates))
  testthat::expect_true("birthRate" %in% names(out$estimates))

  testthat::expect_true("operator" %in% names(out$operators))
  testthat::expect_true("p" %in% names(out$operators))
  testthat::expect_true("accept" %in% names(out$operators))
  testthat::expect_true("reject" %in% names(out$operators))
  testthat::expect_true("acceptFC" %in% names(out$operators))
  testthat::expect_true("rejectFC" %in% names(out$operators))
  testthat::expect_true("rejectIv" %in% names(out$operators))
  testthat::expect_true("rejectOp" %in% names(out$operators))



})

test_that("use, one alignment, verbose, cleanup", {

  testthat::expect_output(
    run_beast2(
      fasta_filenames = get_path("anthus_aco_sub.fas"),
      mcmc = create_mcmc(chain_length = 2000, store_every = 1000),
      verbose = TRUE
    )
  )
})

test_that("use, one alignment, verbose, no cleanup", {

  fasta_filenames <- get_path("anthus_aco_sub.fas")
  beast2_input_filename <- "tmp_beast2.xml"
  beast2_output_log_filename <- "tmp_beast2.log"
  beast2_output_trees_filenames <- paste0(
    beautier::get_ids(fasta_filenames), "_tmp.trees"
  )
  beast2_output_state_filename <- "tmp_beast2.xml.state"

  testit::assert(!file.exists(beast2_input_filename))
  testit::assert(!file.exists(beast2_output_log_filename))
  testit::assert(!file.exists(beast2_output_trees_filenames))
  testit::assert(!file.exists(beast2_output_state_filename))

  testthat::expect_output(
    run_beast2(
      fasta_filenames = fasta_filenames,
      mcmc = create_mcmc(chain_length = 2000, store_every = 1000),
      beast2_input_filename = beast2_input_filename,
      beast2_output_log_filename = beast2_output_log_filename,
      beast2_output_trees_filenames = beast2_output_trees_filenames,
      beast2_output_state_filename = beast2_output_state_filename,
      verbose = TRUE,
      cleanup = FALSE
    )
  )
  testthat::expect_true(file.exists(beast2_input_filename))
  testthat::expect_true(file.exists(beast2_output_log_filename))
  testthat::expect_true(file.exists(beast2_output_trees_filenames))
  testthat::expect_true(file.exists(beast2_output_state_filename))

  file.remove(beast2_input_filename)
  file.remove(beast2_output_log_filename)
  file.remove(beast2_output_trees_filenames)
  file.remove(beast2_output_state_filename)


})

test_that("use, two alignments, estimated crown ages", {

  out <- NA

  testthat::expect_silent(
    out <- run_beast2(
      fasta_filenames = get_paths(
        c("anthus_aco_sub.fas", "anthus_nd2_sub.fas")
      ),
      mcmc = create_mcmc(chain_length = 2000, store_every = 1000)
    )
  )
  testthat::expect_true("estimates" %in% names(out))
  testthat::expect_true("anthus_aco_sub_trees" %in% names(out))
  testthat::expect_true("anthus_nd2_sub_trees" %in% names(out))
  testthat::expect_true("operators" %in% names(out))
  testthat::expect_equal(class(out$anthus_aco_sub_trees[[1]]), "phylo")
  testthat::expect_equal(class(out$anthus_nd2_sub_trees[[1]]), "phylo")
  testthat::expect_equal(length(out$anthus_aco_sub_trees), 2)
  testthat::expect_equal(length(out$anthus_nd2_sub_trees), 2)

  testthat::expect_true("Sample" %in% names(out$estimates))
  testthat::expect_true("posterior" %in% names(out$estimates))
  testthat::expect_true("likelihood" %in% names(out$estimates))
  testthat::expect_true("prior" %in% names(out$estimates))
  testthat::expect_true("treeLikelihood.aco_sub" %in% names(out$estimates))
  testthat::expect_true("treeLikelihood.nd2_sub" %in% names(out$estimates))
  testthat::expect_true("TreeHeight.aco_sub" %in% names(out$estimates))
  testthat::expect_true("TreeHeight.nd2_sub" %in% names(out$estimates))
  testthat::expect_true("YuleModel.aco_sub" %in% names(out$estimates))
  testthat::expect_true("YuleModel.nd2_sub" %in% names(out$estimates))
  testthat::expect_true("birthRate.aco_sub" %in% names(out$estimates))
  testthat::expect_true("birthRate.nd2_sub" %in% names(out$estimates))

  testthat::expect_true("operator" %in% names(out$operators))
  testthat::expect_true("p" %in% names(out$operators))
  testthat::expect_true("accept" %in% names(out$operators))
  testthat::expect_true("reject" %in% names(out$operators))
  testthat::expect_true("acceptFC" %in% names(out$operators))
  testthat::expect_true("rejectFC" %in% names(out$operators))
  testthat::expect_true("rejectIv" %in% names(out$operators))
  testthat::expect_true("rejectOp" %in% names(out$operators))

})




test_that("abuse", {

  testthat::expect_error(
    run_beast2(
      fasta_filenames = get_path("anthus_aco_sub.fas"),
      beast2_output_trees_filenames = c("too", "many")
    ),
    "Must have as much FASTA filenames as BEAST2 output trees fileanames"
  )

})
