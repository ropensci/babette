#' Do a minimal run to verify babette works correctly
#' @author Richel J.C. Bilderbeek
#' @export
bbt_minimal_run <- function() {
  bbt_run_from_model( # nolint babette function
    fasta_filename = beautier::get_fasta_filename(),
    inference_model = beautier::create_inference_model(
       mcmc = beautier::create_mcmc(chain_length = 2000, store_every = 1000)
    )
  )
}
