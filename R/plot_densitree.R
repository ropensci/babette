#' Draw multiple trees on top of one another.
#'
#' @param phylos one or more phylogenies, must be of class \code{multiPhylo}
#' @param ... options to be passed to \code{phangorn}'s
#'   \link[phangorn]{densiTree} function
#' @return nothing. Will produce a plot.
#' @author Richèl J.C. Bilderbeek
#' @examples
#' if (beautier::is_on_ci() && is_beast2_installed()) {
#'   beastier::remove_beaustier_folders()
#'   beastier::check_empty_beaustier_folders()
#'
#'   inference_model <- create_test_inference_model()
#'   beast2_options <- create_beast2_options()
#'
#'    out <- bbt_run_from_model(
#'     get_babette_path("anthus_aco.fas"),
#'     inference_model = inference_model,
#'     beast2_options = beast2_options
#'   )
#'   bbt_delete_temp_files(
#'     inference_model = inference_model,
#'     beast2_options = beast2_options
#'   )
#'
#'   plot_densitree(out$anthus_aco_trees)
#'
#'   # Clean up temporary files created by babette
#'   bbt_delete_temp_files(
#'     inference_model = inference_model,
#'     beast2_options = beast2_options
#'   )
#'   beastier::remove_beaustier_folders()
#'   beastier::check_empty_beaustier_folders()
#' }
#' @export
plot_densitree <- function(
  phylos,
  ...
) {
  if (!inherits(phylos, "multiPhylo")) {
    stop("'phylos' must be of class 'multiPhylo'")
  }
  phangorn::densiTree(phylos, ...)
}
