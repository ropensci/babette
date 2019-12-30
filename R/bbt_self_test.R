#' Do a self test to verify \link{babette} that works correctly.
#' @author Richèl J.C. Bilderbeek
#' @export
#' @examples
#' library(testthat)
#'
#' if (is_beast2_installed()) {
#'   expect_silent(bbt_self_test())
#' } else {
#'   expect_error(bbt_self_test())
#' }
bbt_self_test <- function() {
  testit::assert(beastier::is_beast2_installed())
  babette::bbt_run_from_model(
    fasta_filename = beautier::get_fasta_filename(),
    inference_model = beautier::create_test_inference_model()
  )
}
