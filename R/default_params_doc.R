#' This function does nothing. It is intended to inherit is parameters'
#' documentation.
#' @param beast2_input_filename path of the 'BEAST2'  configuration file.
#'   By default, this file is put in a temporary folder with a random
#'   filename, as the user needs not read it: it is used as input of 'BEAST2'.
#'   Specifying a \code{beast2_input_filename} allows to store that file
#'   in a more permanently stored location.
#' @param beast2_options 'BEAST2'  options,
#'   as can be created by \link[beastier]{create_beast2_options}
#' @param beast2_output_log_filename name of the log file created by 'BEAST2',
#'   containing the parameter estimates in time. By default, this
#'   file is put a temporary folder with a random
#'   filename, as the user needs not read it: its content
#'   is parsed and returned by this function.
#'   Specifying a \code{beast2_output_log_filename} allows to store that file
#'   in a more permanently stored location.
#' @param beast2_output_state_filename name of the final state file created
#'   by 'BEAST2', containing the operator acceptances. By default, this
#'   file is put a temporary folder with a random
#'   filename, as the user needs not read it: its content
#'   is parsed and returned by this function.
#'   Specifying a \code{beast2_output_state_filename} allows to store that file
#'   in a more permanently stored location.
#' @param beast2_output_trees_filenames name of the one or more trees
#'   files created by 'BEAST2', one per alignment. By default, these
#'   files are put a temporary folder with a random
#'   filename, as the user needs not read it: their content
#'   is parsed and returned by this function.
#'   Specifying \code{beast2_output_trees_filenames} allows to store these
#'   one or more files in a more permanently stored location.
#' @param beast2_path name of either a 'BEAST2'  binary file
#'   (usually simply \code{beast})
#'   or a 'BEAST2'  jar file
#'   (usually has a \code{.jar} extension).
#'   Use \code{get_default_beast2_bin_path} to get
#'   the default BEAST binary file's path
#'   Use \code{get_default_beast2_jar_path} to get
#'   the default BEAST jar file's path
#' @param beast2_working_dir the folder 'BEAST2'  will work in. This is
#'   an (empty) temporary folder by default. This allows to call
#'   'BEAST2'  in multiple parallel processes, as each process can have
#'   its own working directory
#' @param cleanup set to FALSE to keep all temporary files
#' @param clock_model one clock model,
#'   see \link[beautier]{create_clock_model}
#' @param clock_models one or more clock models,
#'   see \link[beautier]{create_clock_models}
#' @param fasta_filename a FASTA filename
#' @param fasta_filenames one or more FASTA filename, each with one alignment
#' @param inference_model a Bayesian phylogenetic inference model,
#'   as returned by \link[beautier]{create_inference_model}
#' @param mcmc the MCMC options,
#'   see \link[beautier]{create_mcmc}
#' @param mrca_prior one Most Recent Common Ancestor prior,
#'   as returned by \code{\link{create_mrca_prior}}
#' @param mrca_priors a list of one or more Most Recent Common Ancestor priors,
#'   as returned by \code{\link{create_mrca_prior}}
#' @param overwrite will 'BEAST2'  overwrite files? Like 'BEAST2',
#'  this is set to \link{TRUE} by default.
#'  If \link{TRUE}, 'BEAST2'  will overwrite the
#'  \code{beast2_options$output_state_filename} if its present.
#'  If \link{FALSE}, 'BEAST2'  will not overwrite the
#'  \code{beast2_options$output_state_filename} if its present
#'  and \link{babette} will give an error message.
#'  Note that if \code{overwrite} is set to \link{FALSE} when
#'  a \code{tracelog} (see \link{create_tracelog}),
#'  \code{screenlog} (see \link{create_screenlog})
#'  or \code{treelog} (see \link{create_treelog})
#'  file already exists,
#'  'BEAST2'  (and thus \link{babette}) will freeze.
#' @param rng_seed the random number generator seed. Must be either
#'   \code{NA} or a positive non-zero value. An RNG seed of \code{NA}
#'   results in 'BEAST2'  picking a random seed.
#' @param site_model one site model,
#'   see \link[beautier]{create_site_models}
#' @param site_models one or more site models,
#'   see \link[beautier]{create_site_models}
#' @param tipdates_filename name of the file containing tip dates
#' @param tree_prior one tree priors,
#'   as created by \link[beautier]{create_tree_prior}
#' @param tree_priors one or more tree priors,
#'   see \link[beautier]{create_tree_priors}
#' @param verbose set to TRUE for more output
#' @author Richèl J.C. Bilderbeek
#' @note This is an internal function, so it should be marked with
#'   \code{@noRd}. This is not done, as this will disallow all
#'   functions to find the documentation parameters
default_params_doc <- function(
  beast2_input_filename,
  beast2_options,
  beast2_output_log_filename,
  beast2_output_state_filename,
  beast2_output_trees_filenames,
  beast2_path,
  beast2_working_dir,
  cleanup,
  clock_model,
  clock_models,
  fasta_filename, fasta_filenames,
  inference_model,
  mcmc,
  mrca_prior,
  mrca_priors,
  overwrite,
  posterior_crown_age,
  rng_seed,
  site_model,
  site_models,
  tipdates_filename,
  tree_prior,
  tree_priors,
  verbose
) {
  # Nothing
}
