#' Do a self test to verify \link{babette} that works correctly.
#' @inheritParams default_params_doc
#' @return Nothing. Will raise an exception if something is wrong.
#' @author Richèl J.C. Bilderbeek
#' @export
#' @examples
#' if (beautier::is_on_ci() && is_beast2_installed()) {
#'   beastier::remove_beaustier_folders()
#'   beastier::check_empty_beaustier_folders()
#'
#'   bbt_self_test()
#'
#'   beastier::remove_beaustier_folders()
#'   beastier::check_empty_beaustier_folders()
#' }
bbt_self_test <- function(
  beast2_options = beastier::create_beast2_options()
) {

  if (!beastier::is_beast2_installed()) {
    stop("Beast2 must be installed for bbt_self_test.")
  }
  inference_model <- beautier::create_test_inference_model()
  babette::bbt_run_from_model(
    fasta_filename = beautier::get_fasta_filename(),
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  babette::bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )
}
