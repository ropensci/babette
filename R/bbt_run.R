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
#' @author Richel J.C. Bilderbeek
#' @usage
#' bbt_run(
#'   fasta_filenames,
#'   site_models = list(
#'     beautier::create_jc69_site_model(
#'       beautier::get_alignment_id(fasta_filenames)
#'     )
#'   ),
#'   clock_models = list(
#'     beautier::create_strict_clock_model(
#'       beautier::get_alignment_id(fasta_filenames)
#'     )
#'   ),
#'   tree_priors = list(
#'     beautier::create_yule_tree_prior(
#'       beautier::get_alignment_id(fasta_filenames)
#'     )
#'   ),
#'   mrca_priors = NA,
#'   mcmc = beautier::create_mcmc(),
#'   posterior_crown_age = NA,
#'   beast2_input_filename = tempfile(pattern = "beast2_", fileext = ".xml"),
#'   rng_seed = 1,
#'   beast2_output_log_filename = tempfile(
#'     pattern = "beast2_", fileext = "log"
#'   ),
#'   beast2_output_trees_filenames = tempfile(
#'     pattern = paste0(
#'       "beast2_",
#'       beautier::get_alignment_ids(fasta_filenames), "_"
#'     ),
#'     fileext = ".trees"
#'   ),
#'   beast2_output_state_filename = tempfile(
#'     pattern = "beast2_", fileext = ".xml.state"
#'   ),
#'   beast2_path = beastier::get_default_beast2_path(),
#'   verbose = FALSE,
#'   cleanup = TRUE
#' )
#' @examples
#'  out <- bbt_run(
#'    fasta_filenames = get_babette_path("anthus_aco.fas"),
#'    mcmc = create_mcmc(chain_length = 1000, store_every = 1000)
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
bbt_run <- function(
  fasta_filenames,
  tipdates_filename = NA,
  site_models = list(
    beautier::create_jc69_site_model(
      beautier::get_alignment_id(fasta_filenames)
    )
  ),
  clock_models = list(
    beautier::create_strict_clock_model(
      beautier::get_alignment_id(fasta_filenames)
    )
  ),
  tree_priors = list(
    beautier::create_yule_tree_prior(
      beautier::get_alignment_id(fasta_filenames)
    )
  ),
  mrca_priors = NA,
  mcmc = beautier::create_mcmc(),
  posterior_crown_age = NA,
  beast2_input_filename = tempfile(pattern = "beast2_", fileext = ".xml"),
  rng_seed = 1,
  beast2_output_log_filename = tempfile(pattern = "beast2_", fileext = "log"),
  beast2_output_trees_filenames = tempfile(
    pattern = paste0(
      "beast2_",
      beautier::get_alignment_ids(fasta_filenames), "_"
    ),
    fileext = ".trees"
  ),
  beast2_output_state_filename = tempfile(
    pattern = "beast2_", fileext = ".xml.state"
  ),
  beast2_path = beastier::get_default_beast2_path(),
  overwrite = FALSE,
  verbose = FALSE,
  cleanup = TRUE
) {

  # Check for deprecated argument names
  calls <- names(sapply(match.call(), deparse))[-1]
  if(any("posterior_crown_age" %in% calls)) {
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




  if (length(fasta_filenames) != length(beast2_output_trees_filenames)) {
    stop("Must have as much FASTA filenames as BEAST2 output trees filenames")
  }
  if (!is.na(rng_seed) && !(rng_seed > 0)) {
    stop("'rng_seed' should be NA or non-zero positive")
  }
  beastier::check_beast2_path(beast2_path)
  bbt_check_beast2_packages(
    mcmc = mcmc,
    beast2_path = beast2_path
  )

  beautier::create_beast2_input_file(
    input_filenames = fasta_filenames,
    site_models = site_models,
    clock_models = clock_models,
    tree_priors = tree_priors,
    mrca_priors = mrca_priors,
    mcmc = mcmc,
    posterior_crown_age = posterior_crown_age,
    output_filename = beast2_input_filename,
    tipdates_filename = tipdates_filename
  )
  testit::assert(file.exists(beast2_input_filename))

  output <- beastier::run_beast2(
    input_filename = beast2_input_filename,
    rng_seed = rng_seed,
    output_log_filename = beast2_output_log_filename,
    output_trees_filenames = beast2_output_trees_filenames,
    output_state_filename = beast2_output_state_filename,
    beast2_path = beast2_path,
    overwrite = overwrite,
    verbose = verbose
  )

  testit::assert(file.exists(beast2_output_log_filename))
  testit::assert(file.exists(beast2_output_trees_filenames))
  testit::assert(file.exists(beast2_output_state_filename))

  out <- tracerer::parse_beast_output_files(
    trees_filenames = beast2_output_trees_filenames,
    log_filename = beast2_output_log_filename,
    state_filename = beast2_output_state_filename
  )

  # Cleanup
  if (cleanup == TRUE) {
    if (verbose == TRUE) {
      print(
        paste(
          "Removing files:", beast2_input_filename, beast2_output_log_filename,
          beast2_output_trees_filenames, beast2_output_state_filename
        )
      )
    }
    file.remove(beast2_input_filename)
    file.remove(beast2_output_log_filename)
    file.remove(beast2_output_trees_filenames)
    file.remove(beast2_output_state_filename)
    testit::assert(!file.exists(beast2_input_filename))
    testit::assert(!file.exists(beast2_output_log_filename))
    testit::assert(!file.exists(beast2_output_trees_filenames))
    testit::assert(!file.exists(beast2_output_state_filename))
  } else {
    if (verbose == TRUE) {
      print(
        paste(
          "Keeping files:", beast2_input_filename, beast2_output_log_filename,
          beast2_output_trees_filenames, beast2_output_state_filename
        )
      )
    }
  }
  new_names <- names(out)
  new_names[seq_along(fasta_filenames)] <- paste0(
    beautier::get_alignment_ids(fasta_filenames), "_trees"
  )
  names(out) <- new_names
  out$output <- output

  # Process the package specific output,
  # for example, add an 'ns' atributed for Nested Sampling
  bbt_process_pkg_output( # nolint internal function
    out = out,
    mcmc = mcmc,
    alignment_ids = beautier::get_alignment_ids(fasta_filenames)
  )
}
