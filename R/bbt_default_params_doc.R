#' This function does nothing. It is intended to inherit is parameters'
#' documentation.
#' @param beast2_input_filename path of the BEAST2 configuration file.
#'   By default, this file is put in a temporary folder with a random
#'   filename, as the user needs not read it: it is used as input of BEAST2.
#'   Specifying a \code{beast2_input_filename} allows to store that file
#'   in a more permanently stored location.
#' @param beast2_output_log_filename name of the log file created by BEAST2,
#'   containing the parameter estimates in time. By default, this
#'   file is put a temporary folder with a random
#'   filename, as the user needs not read it: its content
#'   is parsed and returned by this function.
#'   Specifying a \code{beast2_output_log_filename} allows to store that file
#'   in a more permanently stored location.
#' @param beast2_output_state_filename name of the final state file created
#'   by BEAST2, containing the operator acceptances. By default, this
#'   file is put a temporary folder with a random
#'   filename, as the user needs not read it: its content
#'   is parsed and returned by this function.
#'   Specifying a \code{beast2_output_state_filename} allows to store that file
#'   in a more permanently stored location.
#' @param beast2_output_trees_filenames name of the one or more trees
#'   files created by BEAST2, one per alignment. By default, these
#'   files are put a temporary folder with a random
#'   filename, as the user needs not read it: their content
#'   is parsed and returned by this function.
#'   Specifying \code{beast2_output_trees_filenames} allows to store these
#'   one or more files in a more permanently stored location.
#' @param beast2_path name of either a BEAST2 binary file
#'   (usually simply \code{beast})
#'   or a BEAST2 jar file
#'   (usually has a \code{.jar} extension).
#'   Use \code{get_default_beast2_bin_path} to get
#'   the default BEAST binary file's path
#'   Use \code{get_default_beast2_jar_path} to get
#'   the default BEAST jar file's path
#' @param cleanup set to FALSE to keep all temporary files
#' @param clock_models one or more clock models,
#'   see \link[beautier]{create_clock_models}
#' @param fasta_filenames one or more FASTA filename, each with one alignment
#' @param mcmc the MCMC options,
#'   see \link[beautier]{create_mcmc}
#' @param mrca_priors a list of one or more Most Recent Common Ancestor priors,
#'   as returned by \code{\link{create_mrca_prior}}
#' @param overwrite if TRUE: overwrite the \code{.log}
#'   and \code{.trees} files if one of these exists.
#'   If FALSE, BEAST2 will not be started if
#'   \itemize{
#'     \item{the \code{.log} file exists}
#'     \item{the \code{.trees} files exist}
#'     \item{the \code{.log} file created by BEAST2 exists}
#'     \item{the \code{.trees} files created by BEAST2 exist}
#'  }
#' @param posterior_crown_age the posterior's crown age. Use NA to let
#'   BEAST2 estimate this parameter. Use a positive value to fix the
#'   crown age to that value
#' @param rng_seed the random number generator seed. Must be either
#'   \code{NA} or a positive non-zero value. An RNG seed of \code{NA}
#'   results in BEAST2 picking a random seed.
#' @param site_models one or more site models,
#'   see \link[beautier]{create_site_models}
#' @param tree_priors one or more tree priors,
#'   see \link[beautier]{create_tree_priors}
#' @param verbose set to TRUE for more output
#' @author Richel J.C. Bilderbeek
#' @note This is an internal function, so it should be marked with
#'   \code{@noRd}. This is not done, as this will disallow all
#'   functions to find the documentation parameters
bbt_default_params_doc <- function(
  beast2_input_filename,
  beast2_output_log_filename,
  beast2_output_state_filename,
  beast2_output_trees_filenames,
  beast2_path,
  cleanup,
  clock_models,
  fasta_filenames,
  mcmc,
  mrca_priors,
  overwrite,
  posterior_crown_age,
  rng_seed,
  site_models,
  tree_priors,
  verbose
) {
  # Nothing
}
