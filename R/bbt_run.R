#' Do a full run: create a BEAST2 configuration file (like BEAUti 2),
#' run BEAST2, parse results (like Tracer)
#' @inheritParams bbt_default_params_doc
#' @return a list with the following elements:\cr
#' \itemize{
#'   \item{
#'     \code{estimates}: a data frame with BEAST2
#'     parameter estimates
#'   }
#'   \item{
#'     \code{[alignment_id]_trees}: a \code{multiPhylo}
#'     containing the phylogenies
#'     in the BEAST2 posterior. \code{[alignment_id]}
#'     is the ID of the alignment. For example,
#'     when running \code{bbt_run} with
#'     \code{anthus_aco.fas}, this element will have
#'     name \code{anthus_aco_trees}
#'   }
#'   \item{
#'     \code{operators}: a data frame with the
#'     BEAST2 MCMC operator acceptances
#'   }
#'   \item{
#'     \code{output}: a numeric vector with the output
#'     sent to standard output and error streams
#'   }
#'   \item{
#'     \code{ns}: (optional) the results of a marginal likelihood estimation,
#'     will exist only when \code{create_ns_mcmc()} was
#'     used for \code{mcmc}.
#'     This structure will contain the following elements:
#'     \itemize{
#'       \item \code{marg_log_lik} the marginal log likelihood estimate
#'       \item \code{marg_log_lik_sd} the standard deviation around the estimate
#'       \item \code{estimates} the parameter estimates
#'         created during the marginal likelihood estimation
#'       \item \code{trees} the trees
#'         created during the marginal likelihood estimation
#'     }
#'   }
#' }
#' @author Richèl J.C. Bilderbeek
#' @examples
#'  if (is_beast2_installed()) {
#'
#'    mcmc <- create_test_mcmc()
#'
#'    out <- bbt_run(
#'      fasta_filename = get_babette_path("anthus_aco.fas"),
#'      mcmc = mcmc
#'    )
#'
#'    library(testthat)
#'    expect_true("estimates" %in% names(out))
#'    expect_true("anthus_aco_trees" %in% names(out))
#'    expect_true("operators" %in% names(out))
#'    expect_true("output" %in% names(out))
#'    expect_true(is_phylo(out$anthus_aco_trees[[1]]))
#'
#'    #' The number of expected trees. The tree at state zero is also logged
#'    n_trees_expected <- 1 + (mcmc$chain_length / mcmc$treelog$log_every)
#'    expect_equal(length(out$anthus_aco_trees), n_trees_expected)
#'
#'    expect_true("Sample" %in% names(out$estimates))
#'    expect_true("posterior" %in% names(out$estimates))
#'    expect_true("likelihood" %in% names(out$estimates))
#'    expect_true("prior" %in% names(out$estimates))
#'    expect_true("treeLikelihood" %in% names(out$estimates))
#'    expect_true("TreeHeight" %in% names(out$estimates))
#'    expect_true("YuleModel" %in% names(out$estimates))
#'    expect_true("birthRate" %in% names(out$estimates))
#'
#'    expect_true("operator" %in% names(out$operators))
#'    expect_true("p" %in% names(out$operators))
#'    expect_true("accept" %in% names(out$operators))
#'    expect_true("reject" %in% names(out$operators))
#'    expect_true("acceptFC" %in% names(out$operators))
#'    expect_true("rejectFC" %in% names(out$operators))
#'    expect_true("rejectIv" %in% names(out$operators))
#'    expect_true("rejectOp" %in% names(out$operators))
#'  }
#' @seealso Use \code{\link[tracerer]{remove_burn_ins}}
#'   to remove the burn-ins from
#'   the posterior's estimates (\code{posterior$estimates})
#' @export
bbt_run <- function(
  fasta_filename,
  tipdates_filename = NA,
  site_model = beautier::create_jc69_site_model(),
  clock_model = beautier::create_strict_clock_model(),
  tree_prior = beautier::create_yule_tree_prior(),
  mrca_prior = NA,
  mcmc = beautier::create_mcmc(),
  beast2_input_filename = beastier::create_temp_input_filename(),
  rng_seed = 1,
  beast2_output_state_filename = beastier::create_temp_output_state_filename(),
  beast2_path = beastier::get_default_beast2_path(),
  overwrite = TRUE,
  verbose = FALSE,
  # Deprecated parameters
  beast2_output_log_filename = "deprecated",
  beast2_output_trees_filenames = "deprecated",
  beast2_working_dir = "beast2_working_dir_trees_filenames_is_deprecated",
  fasta_filenames = "deprecated",
  site_models = "deprecated",
  clock_models = "deprecated",
  tree_priors = "deprecated",
  mrca_priors = "deprecated",
  posterior_crown_age = "deprecated",
  cleanup = "deprecated"
) {

  # Check for deprecated argument names
  calls <- names(sapply(match.call(), deparse))[-1]
  if (any("posterior_crown_age" %in% calls)) {
    stop(
      "'posterior_crown_age' is deprecated. \n",
      "Tip: use an MRCA prior ",
      "with a narrow distribution around the crown age instead. \n",
      "See 'create_mrca_prior' or the example below:\n",
      "\n",
      "fasta_filename <- get_beautier_path(\"anthus_aco.fas\")\n",
      "crown_age <- 15\n",
      "\n",
      "mrca_prior <- create_mrca_prior(\n",
      "  alignment_id = get_alignment_id(fasta_filename = fasta_filename),\n",
      "  taxa_names = get_taxa_names(filename = fasta_filename),\n",
      "  mrca_distr = create_normal_distr(\n",
      "    mean = crown_age,\n",
      "    sigma = 0.0001\n",
      "  ),\n",
      "  is_monophyletic = TRUE\n",
      ")\n",
      "\n",
      "bbt_run(\n",
      "  fasta_filename = fasta_filename,\n",
      "  mrca_prior = mrca_prior\n",
      ")\n"
    )
  }
  if (any("fasta_filenames" %in% calls)) {
    stop("'fasta_filenames' is deprecated, use 'fasta_filename' instead.")
  }
  if (any("site_models" %in% calls)) {
    stop("'site_models' is deprecated, use 'site_model' instead.")
  }
  if (any("clock_models" %in% calls)) {
    stop("'clock_models' is deprecated, use 'clock_model' instead.")
  }
  if (any("tree_priors" %in% calls)) {
    stop("'tree_priors' is deprecated, use 'tree_prior' instead.")
  }
  if (any("mrca_priors" %in% calls)) {
    stop("'mrca_priors' is deprecated, use 'mrca_prior' instead.")
  }
  if (any("cleanup" %in% calls)) {
    stop(
      "'cleanup' is deprecated, cleanup must be done by the caller.\n",
      "\n",
      "Tip: use these lines:\n",
      "\n",
      "file.remove(beast2_input_filename)\n",
      "file.remove(mcmc$tracelog$filename)\n",
      "file.remove(mcmc$treelog$filename)\n",
      "file.remove(beast2_output_state_filename)\n"
    )
  }
  if (any("output_log_filename" %in% calls)) {
    stop(
      "'output_log_filename' is deprecated, it is stored in the BEAST2 XML"
    )
  }
  if (any("output_trees_filenames" %in% calls)) {
    stop(
      "'output_trees_filenames' is deprecated, it is stored in the BEAST2 XML"
    )
  }
  if (any("beast2_working_dir" %in% calls)) {
    stop(
      "'beast2_working_dir' is deprecated"
    )
  }

  inference_model <- beautier::create_inference_model(
    site_model = site_model,
    clock_model = clock_model,
    tree_prior = tree_prior,
    mrca_prior = mrca_prior,
    mcmc = mcmc,
    tipdates_filename = tipdates_filename
  )
  beast2_options <- beastier::create_beast2_options(
    input_filename = beast2_input_filename,
    rng_seed = rng_seed,
    output_state_filename = beast2_output_state_filename,
    beast2_path = beast2_path,
    overwrite = overwrite,
    verbose = verbose
  )
  bbt_run_from_model(
    fasta_filename = fasta_filename,
    inference_model = inference_model,
    beast2_options = beast2_options
  )
}
