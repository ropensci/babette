#' Delete all the temporary files created by \link{bbt_run_from_model}
#' @inheritParams default_params_doc
#' @examples
#' if (is_beast2_installed()) {
#'   # Do a minimal run
#'   inference_model <- create_test_inference_model()
#'   beast2_options <- create_beast2_options()
#'   bbt_run_from_model(
#'     fasta_filename = get_fasta_filename(),
#'     inference_model = inference_model,
#'     beast2_options = beast2_options
#'   )
#'
#'   # Cleanup
#'   bbt_delete_temp_files(
#'     inference_model = inference_model,
#'     beast2_options = beast2_options
#'   )
#' }
#' @author Richèl J.C. Bilderbeek
#' @export
bbt_delete_temp_files <- function(
  inference_model,
  beast2_options
) {
  tracelog_filename <- inference_model$mcmc$tracelog$filename
  treelog_filename <- NA
  if (file.exists(beast2_options$input_filename)) {
    treelog_filename <- beastier::extract_treelog_filename_from_beast2_input_file( # nolint indeed long
      input_filename = beast2_options$input_filename
    )
  }
  # beast2_options
  # treelog_filename <- stringr::str_replace(
  #   string = treelog_filename,
  #   pattern = "\\$\\(tree\\)",
  #   replacement = tree_id
  # )

  screenlog_filename <- inference_model$mcmc$screenlog$filename
  screenlog_ns_filename <- stringr::str_replace(
    screenlog_filename,
    "csv$",
    "posterior.csv"
  )
  treelog_ns_filename <- stringr::str_replace(
    treelog_filename,
    "trees$",
    "posterior.trees"
  )

  if (file.exists(screenlog_filename)) file.remove(screenlog_filename)
  if (file.exists(screenlog_ns_filename)) file.remove(screenlog_ns_filename)
  if (!beautier::is_one_na(tracelog_filename) &&
    file.exists(tracelog_filename)
  ) {
    file.remove(tracelog_filename)
  }
  if (!beautier::is_one_na(treelog_filename) &&
    file.exists(treelog_filename)
  ) {
    file.remove(treelog_filename)
  }
  if (file.exists(treelog_ns_filename)) file.remove(treelog_ns_filename)
  if (file.exists(beast2_options$input_filename)) {
    file.remove(beast2_options$input_filename)
  }
  if (file.exists(beast2_options$output_state_filename)) {
    file.remove(beast2_options$output_state_filename)
  }
}
