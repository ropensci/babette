#' Do a full run: create a BEAST2 config file (like BEAUti 2), run BEAST2,
#'   parse results (like Tracer)
#' @param fasta_filenames one or more FASTA filename, eachwith one alignment
#' @param site_models one or more site models,
#'   see \link[beautier]{create_site_models}
#' @param clock_models one or more clock models,
#'   see \link[beautier]{create_clock_models}
#' @param tree_priors one or more tree priors,
#'   see \link[beautier]{create_tree_priors}
#' @param mrca_priors a list of one or more Most Recent Common Ancestor priors,
#'   as returned by \code{\link{create_mrca_prior}}
#' @param mcmc the MCMC options,
#'   see \link[beautier]{create_mcmc}
#' @param posterior_crown_age the posterior's crown age. Use NA to let
#'   BEAST2 estimate this parameter. Use a positive value to fix the
#'   crown age to that value
#' @param beast2_input_filename name of the BEAST2 configuration file
#' @param rng_seed the random number generator seed
#' @param beast2_output_log_filename name of the log file created by BEAST2,
#'   containing the parameter estimates in time
#' @param beast2_output_trees_filenames name of the one or more trees
#'   files created by BEAST2, one per alignment
#' @param beast2_output_state_filename name of the final state file created
#'   by BEAST2, containing the operator acceptences
#' @param beast2_jar_path path to the BEAST2 jar file
#' @param verbose set to TRUE for more output
#' @param cleanup set to FALSE to keep all temporary files
#' @author Richel J.C. Bilderbeek
#' @examples
#'  # One alignment
#'  out <- run(
#'    fasta_filenames = get_babette_path("anthus_aco.fas"),
#'    mcmc = create_mcmc(chain_length = 10000, store_every = 1000)
#'  )
#'
#'  testit::assert("estimates" %in% names(out))
#'  testit::assert("anthus_aco_trees" %in% names(out))
#'  testit::assert("operators" %in% names(out))
#'  testit::assert(class(out$anthus_aco_trees[[1]]) == "phylo")
#'  testit::assert(length(out$anthus_aco_trees) == 10)
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
#'
#'  # Two alignments
#'  out <- run(
#'    fasta_filenames = get_babette_paths(
#'      c("anthus_aco.fas", "anthus_nd2.fas")
#'    ),
#'    mcmc = create_mcmc(chain_length = 10000, store_every = 1000)
#'  )
#'
#'  testit::assert("estimates" %in% names(out))
#'  testit::assert("anthus_aco_trees" %in% names(out))
#'  testit::assert("anthus_nd2_trees" %in% names(out))
#'  testit::assert("operators" %in% names(out))
#'  testit::assert(class(out$anthus_aco_trees[[1]]) == "phylo")
#'  testit::assert(class(out$anthus_nd2_trees[[1]]) == "phylo")
#'  testit::assert(length(out$anthus_aco_trees) == 10)
#'  testit::assert(length(out$anthus_nd2_trees) == 10)
#'
#'  testit::assert("Sample" %in% names(out$estimates))
#'  testit::assert("posterior" %in% names(out$estimates))
#'  testit::assert("likelihood" %in% names(out$estimates))
#'  testit::assert("prior" %in% names(out$estimates))
#'  testit::assert("treeLikelihood.aco" %in% names(out$estimates))
#'  testit::assert("treeLikelihood.nd2" %in% names(out$estimates))
#'  testit::assert("TreeHeight.aco" %in% names(out$estimates))
#'  testit::assert("TreeHeight.nd2" %in% names(out$estimates))
#'  testit::assert("YuleModel.aco" %in% names(out$estimates))
#'  testit::assert("YuleModel.nd2" %in% names(out$estimates))
#'  testit::assert("birthRate.aco" %in% names(out$estimates))
#'  testit::assert("birthRate.nd2" %in% names(out$estimates))
#' @seealso Use \code{\link[tracerer]{remove_burn_ins}}
#'   to remove the burn-ins from
#'   the posterior's estimates (\code{posterior$estimates})
#' @export
run <- function(
  fasta_filenames,
  site_models = beautier::create_jc69_site_models(
    beautier::get_ids(fasta_filenames)),
  clock_models = beautier::create_strict_clock_models(
    beautier::get_ids(fasta_filenames)),
  tree_priors = beautier::create_yule_tree_priors(
    beautier::get_ids(fasta_filenames)),
  mrca_priors = NA,
  mcmc = beautier::create_mcmc(),
  posterior_crown_age = NA,
  beast2_input_filename = tempfile(pattern = "beast2_", fileext = ".xml"),
  rng_seed = 1,
  beast2_output_log_filename = tempfile(pattern = "beast2_", fileext = "log"),
  beast2_output_trees_filenames = tempfile(
    pattern = paste0("beast2_", beautier::get_ids(fasta_filenames), "_"),
    fileext = ".trees"
  ),
  beast2_output_state_filename = tempfile(
    pattern = "beast2_", fileext = ".xml.state"
  ),
  beast2_jar_path = beastier::get_default_beast2_jar_path(),
  verbose = FALSE,
  cleanup = TRUE
) {
  if (length(fasta_filenames) != length(beast2_output_trees_filenames)) {
    stop("Must have as much FASTA filenames as BEAST2 output trees fileanames")
  }
  beautier::create_beast2_input_file(
    input_filenames = fasta_filenames,
    site_models = site_models,
    clock_models = clock_models,
    tree_priors = tree_priors,
    mrca_priors = mrca_priors,
    mcmc = mcmc,
    posterior_crown_age = posterior_crown_age,
    output_filename = beast2_input_filename
  )
  testit::assert(file.exists(beast2_input_filename))

  beastier::run_beast2(
    input_filename = beast2_input_filename,
    rng_seed = rng_seed,
    output_log_filename = beast2_output_log_filename,
    output_trees_filenames = beast2_output_trees_filenames,
    output_state_filename = beast2_output_state_filename,
    beast2_jar_path = beast2_jar_path,
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
  new_names[1:length(fasta_filenames)] <- paste0(
    beautier::get_ids(fasta_filenames), "_trees"
  )
  names(out) <- new_names
  out
}
