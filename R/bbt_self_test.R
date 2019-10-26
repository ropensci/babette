#' Do a self test to verify babette works correctly
#' @author Richèl J.C. Bilderbeek
#' @export
bbt_self_test <- function() {
  bbt_run_from_model( # nolint babette function
    fasta_filename = beautier::get_fasta_filename(),
    inference_model = beautier::create_inference_model(
       mcmc = beautier::create_test_mcmc()
    )
  )
}
