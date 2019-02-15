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
#'     when running \code{bbt_run_from_model} with
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
#'     will exist only when \code{create_mcmc_nested_sampling} was
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
#'  out <- bbt_run_from_model(
#'    fasta_filename = get_babette_path("anthus_aco.fas"),
#'    inference_model = create_inference_model(
#'      mcmc = create_mcmc(chain_length = 1000, store_every = 1000)
#'    )
#'  )
#'
#'  testit::assert("estimates" %in% names(out))
#'  testit::assert("anthus_aco_trees" %in% names(out))
#'  testit::assert("operators" %in% names(out))
#'  testit::assert("output" %in% names(out))
#'  testit::assert(class(out$anthus_aco_trees[[1]]) == "phylo")
#'  testit::assert(length(out$anthus_aco_trees) == 2)
#'
#'  testit::assert("Sample" %in% names(out$estimates))
#'  testit::assert("posterior" %in% names(out$estimates))
#'  testit::assert("likelihood" %in% names(out$estimates))
#'  testit::assert("prior" %in% names(out$estimates))
#'  testit::assert("treeLikelihood" %in% names(out$estimates))
#'  testit::assert("TreeHeight" %in% names(out$estimates))
#'  testit::assert("YuleModel" %in% names(out$estimates))
#'  testit::assert("birthRate" %in% names(out$estimates))
#'
#'  testit::assert("operator" %in% names(out$operators))
#'  testit::assert("p" %in% names(out$operators))
#'  testit::assert("accept" %in% names(out$operators))
#'  testit::assert("reject" %in% names(out$operators))
#'  testit::assert("acceptFC" %in% names(out$operators))
#'  testit::assert("rejectFC" %in% names(out$operators))
#'  testit::assert("rejectIv" %in% names(out$operators))
#'  testit::assert("rejectOp" %in% names(out$operators))
#' @seealso Use \code{\link[tracerer]{remove_burn_ins}}
#'   to remove the burn-ins from
#'   the posterior's estimates (\code{posterior$estimates})
#' @export
bbt_run_from_model <- function(
  fasta_filename,
  inference_model = create_inference_model(),
  beast2_options = create_beast2_options()
) {
  tryCatch(
    check_inference_model(inference_model),
    error = function(e) {
      stop(
        "'inference_model' must be a valid inference model\n",
        "Error: ", e$message, "\n",
        "Value: ", inference_model
      )
    }
  )
  tryCatch(
    check_beast2_options(beast2_options),
    error = function(e) {
      stop(
        "'beast2_options' must be a valid BEAST2 options object\n",
        "Error: ", e$message, "\n",
        "Value: ", beast2_options
      )
    }
  )

  bbt_run(
    fasta_filename = fasta_filename,
    tipdates_filename = inference_model$tipdates_filename,
    site_model = inference_model$site_model,
    clock_model = inference_model$clock_model,
    tree_prior = inference_model$tree_prior,
    mrca_prior = inference_model$mrca_prior,
    mcmc = inference_model$mcmc,
    beast2_input_filename = beast2_options$input_filename,
    rng_seed = beast2_options$rng_seed,
    beast2_output_log_filename = beast2_options$output_log_filename,
    beast2_output_trees_filenames = beast2_options$output_trees_filenames,
    beast2_output_state_filename = beast2_options$output_state_filename,
    beast2_path = beast2_options$beast2_path,
    overwrite = beast2_options$overwrite,
    verbose = beast2_options$verbose
  )
}
