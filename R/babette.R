#' babette: A package for Bayesian phylogenetics.
#'
#' 'babette' provides for an alternative workflow of using
#' the popular phylogenetics tool 'BEAST2', including
#' it peripheral tools. From an alignment and
#' inference model, a posterior of jointly estimated
#' phylogenies and parameter estimates is generated.
#'
#' @examples
#' library(testthat)
#'
#' if (is_beast2_installed()) {
#'
#'   inference_model <- create_test_inference_model()
#'
#'   out <- bbt_run_from_model(
#'     fasta_filename = get_babette_path("anthus_aco.fas"),
#'     inference_model = inference_model
#'   )
#'
#'   expect_true("estimates" %in% names(out))
#'   expect_true("anthus_aco_trees" %in% names(out))
#'   expect_true("operators" %in% names(out))
#'   expect_true("output" %in% names(out))
#'   expect_true(is_phylo(out$anthus_aco_trees[[1]]))
#'
#'   #' The number of expected trees. The tree at state zero is also logged
#'   n_trees_expected <- 1 + (inference_model$mcmc$chain_length /
#'     inference_model$mcmc$treelog$log_every
#'   )
#'   expect_equal(length(out$anthus_aco_trees), n_trees_expected)
#'
#'   expect_true("Sample" %in% names(out$estimates))
#'   expect_true("posterior" %in% names(out$estimates))
#'   expect_true("likelihood" %in% names(out$estimates))
#'   expect_true("prior" %in% names(out$estimates))
#'   expect_true("treeLikelihood" %in% names(out$estimates))
#'   expect_true("TreeHeight" %in% names(out$estimates))
#'   expect_true("YuleModel" %in% names(out$estimates))
#'   expect_true("birthRate" %in% names(out$estimates))
#'
#'   expect_true("operator" %in% names(out$operators))
#'   expect_true("p" %in% names(out$operators))
#'   expect_true("accept" %in% names(out$operators))
#'   expect_true("reject" %in% names(out$operators))
#'   expect_true("acceptFC" %in% names(out$operators))
#'   expect_true("rejectFC" %in% names(out$operators))
#'   expect_true("rejectIv" %in% names(out$operators))
#'   expect_true("rejectOp" %in% names(out$operators))
#' }
#' @seealso
#' These are packages associated with 'babette':
#' \itemize{
#'   \item{
#'     '\link[beautier]{beautier}' creates 'BEAST2' input files.
#'   }
#'   \item{
#'     '\link[beastier]{beastier}' runs 'BEAST2'.
#'   }
#'   \item{
#'     '\link[mauricer]{mauricer}' does 'BEAST2' package management.
#'   }
#'   \item{
#'     '\link[tracerer]{tracerer}' parses 'BEAST2' output files.
#'   }
#' }
#' @docType package
#' @name babette
#' @import beautier tracerer beastier mauricer
NULL
