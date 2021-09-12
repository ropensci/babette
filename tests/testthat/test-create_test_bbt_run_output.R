test_that("use", {

  out <- create_test_bbt_run_output()

  # Same tests as in code examples
  expect_true("estimates" %in% names(out))
  expect_true("anthus_aco_trees" %in% names(out))
  expect_true("operators" %in% names(out))
  expect_true("output" %in% names(out))
  expect_true(class(out$anthus_aco_trees[[1]]) == "phylo")
  expect_true(length(out$anthus_aco_trees) == 2)

  expect_true("Sample" %in% names(out$estimates))
  expect_true("posterior" %in% names(out$estimates))
  expect_true("likelihood" %in% names(out$estimates))
  expect_true("prior" %in% names(out$estimates))
  expect_true("treeLikelihood" %in% names(out$estimates))
  expect_true("TreeHeight" %in% names(out$estimates))
  expect_true("YuleModel" %in% names(out$estimates))
  expect_true("birthRate" %in% names(out$estimates))

  expect_true("operator" %in% names(out$operators))
  expect_true("p" %in% names(out$operators))
  expect_true("accept" %in% names(out$operators))
  expect_true("reject" %in% names(out$operators))
  expect_true("acceptFC" %in% names(out$operators))
  expect_true("rejectFC" %in% names(out$operators))
  expect_true("rejectIv" %in% names(out$operators))
  expect_true("rejectOp" %in% names(out$operators))
  beastier::check_empty_beastier_folder()
  beautier::check_empty_beautier_folder()
  # beastierinstall::clear_beautier_cache() ; beastierinstall::clear_beastier_cache() # nolint
})
