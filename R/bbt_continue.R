#' Continue a BEAST2 run
#'
#' Do a full run: create a 'BEAST2' configuration file (like 'BEAUti 2'),
#' run 'BEAST2', parse results (like 'Tracer')
#' @inheritParams default_params_doc
#' @return a list with the following elements:\cr
#' \itemize{
#'   \item{
#'     \code{estimates}: a data frame with 'BEAST2'
#'     parameter estimates
#'   }
#'   \item{
#'     \code{[alignment_id]_trees}: a \code{multiPhylo}
#'     containing the phylogenies
#'     in the 'BEAST2' posterior. \code{[alignment_id]}
#'     is the ID of the alignment. For example,
#'     when running \code{bbt_run_from_model} with
#'     \code{anthus_aco.fas}, this element will have
#'     name \code{anthus_aco_trees}
#'   }
#'   \item{
#'     \code{operators}: a data frame with the
#'     'BEAST2' MCMC operator acceptances
#'   }
#'   \item{
#'     \code{output}: a numeric vector with the output
#'     sent to standard output and error streams
#'   }
#'   \item{
#'     \code{ns}: (optional) the results of a marginal likelihood estimation,
#'     will exist only when \code{create_ns_mcmc} was
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
#' if (beastier::is_on_ci() && is_beast2_installed()) {
#'   beastier::remove_beaustier_folders()
#'   beastier::check_empty_beaustier_folders()
#'
#'   # A simple FASTA file
#'   fasta_filename <- beautier::get_beautier_path("test_output_0.fas")
#'
#'   # Simple short inference
#'   inference_model <- create_test_inference_model()
#'
#'   # Default BEAST2 options
#'   beast2_options <- create_beast2_options()
#'
#'   bbt_run_from_model(
#'     fasta_filename = fasta_filename,
#'     inference_model = inference_model,
#'     beast2_options = beast2_options
#'   )
#'
#'   bbt_continue(
#'     fasta_filename = fasta_filename,
#'     inference_model = inference_model,
#'     beast2_options = beast2_options
#'   )
#'
#'   # Cleanup
#'   bbt_delete_temp_files(
#'     inference_model = inference_model,
#'     beast2_options = beast2_options
#'   )
#'   beastier::remove_beaustier_folders()
#'   beastier::check_empty_beaustier_folders()
#' }
#' @seealso Use \code{\link[tracerer]{remove_burn_ins}}
#'   to remove the burn-ins from
#'   the posterior's estimates (\code{posterior$estimates})
#' @export
bbt_continue <- function(
  fasta_filename,
  inference_model,
  beast2_options
) {
  tryCatch(
    beautier::check_inference_model(inference_model),
    error = function(e) {
      stop(
        "'inference_model' must be a valid inference model\n",
        "Error: ", e$message, "\n",
        "Value: ", inference_model
      )
    }
  )
  tryCatch(
    beastier::check_beast2_options(beast2_options),
    error = function(e) {
      stop(
        "'beast2_options' must be a valid 'BEAST2' options object\n",
        "Error: ", e$message, "\n",
        "Value: ", beast2_options
      )
    }
  )
  beastier::check_beast2_path(beast2_options$beast2_path)
  babette::check_beast2_pkgs(
    mcmc = inference_model$mcmc,
    beast2_path = beast2_options$beast2_path
  )
  beautier::check_file_exists(
    beast2_options$input_filename,
    "beast2_options$input_filename"
  )
  testthat::expect_true(
    beastier::is_beast2_input_file(beast2_options$input_filename)
  )
  beautier::check_file_exists(
    beast2_options$output_state_filename,
    "beast2_options$output_state_filename"
  )

  # This is the only new line
  output <- beastier::continue_beast2(beast2_options)

  # By default, mcmc$tracelog$filename is initialized with NA.
  # Overwrite it with the 'BEAST2' default filename
  if (is.na(inference_model$mcmc$tracelog$filename)) {
    inference_model$mcmc$tracelog$filename <- paste0(
      beautier::get_alignment_id(fasta_filename), ".log"
    )
  }
  testthat::expect_true(!is.na(inference_model$mcmc$tracelog$filename))
  if (!file.exists(normalizePath(inference_model$mcmc$tracelog$filename))) {
    stop(
      "'mcmc$tracelog$filename' not found. \n",
      "inference_model$mcmc$tracelog$filename: ",
        inference_model$mcmc$tracelog$filename, " \n",
      "normalizePath(inference_model$mcmc$tracelog$filename): ",
        normalizePath(inference_model$mcmc$tracelog$filename), " \n",
      "This can be caused by:\n",
      " * (Linux) the home folder is encrypted\n",
      " * (MacOS) if `babette` is run in a folder monitored by DropBox\n"
    )
  }
  # By default, mcmc$tracelog$filename is initialized with NA.
  # Overwrite it with the 'BEAST2' default filename
  inference_model$mcmc$treelog$filename <- gsub(
    x = inference_model$mcmc$treelog$filename,
    pattern = "\\$\\(tree\\)",
    replacement = beautier::get_alignment_id(fasta_filename)
  )
  testthat::expect_true(file.exists(inference_model$mcmc$treelog$filename) &&
    length(
      paste0(
        "'mcmc$treelog$filename' not found. \n",
        "This can be caused by:\n",
        " * (Linux) the home folder is encrypted\n",
        " * (MacOS) if `babette` is run in a folder monitored by DropBox\n"
      )
    )
  )
  testthat::expect_true(file.exists(beast2_options$output_state_filename) &&
    length(
      paste0(
        "beast2_output_state_filename not found. \n",
        "This can be caused by:\n",
        " * (Linux) the home folder is encrypted\n",
        " * (MacOS) if `babette` is run in a folder monitored by DropBox\n"
      )
    )
  )

  out <- tracerer::parse_beast_output_files(
    trees_filenames = inference_model$mcmc$treelog$filename,
    log_filename = inference_model$mcmc$tracelog$filename,
    state_filename = beast2_options$output_state_filename
  )

  new_names <- names(out)
  new_names[1] <- paste0(beautier::get_alignment_id(fasta_filename), "_trees")
  names(out) <- new_names
  out$output <- output

  # Check that there are as much trees in the output,
  # as there were in the file
  n_trees_in_file <- tracerer::count_trees_in_file(
    inference_model$mcmc$treelog$filename
  )
  testthat::expect_true(inherits(out[[1]], "multiPhylo"))
  n_trees_in_output <- length(out[[1]])
  testthat::expect_equal(n_trees_in_file, n_trees_in_output)

  # Process the package specific output,
  # for example, add an 'ns' atributed for Nested Sampling
  babette::parse_beast2_output(
    out = out,
    inference_model = inference_model
  )

}
