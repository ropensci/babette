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
  file.remove(inference_model$mcmc$tracelog$filename)
  file.remove(inference_model$mcmc$treelog$filename)
  file.remove(inference_model$mcmc$screenlog$filename)
  file.remove(beast2_options$input_filename)
  file.remove(beast2_options$output_state_filename)
}
