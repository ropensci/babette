#' Draw multiple trees on top of one another.
#'
#' @param phylos one or more phylogenies, must be of class \code{multiPhylo}
#' @param ... options to be passed to \code{phangorn}'s
#'   \link[phangorn]{densiTree} function
#' @return nothing. Will produce a plot.
#' @author Richèl J.C. Bilderbeek
#' @examples
#' if (is_beast2_installed()) {
#'    out <- bbt_run(
#'     get_babette_path("anthus_aco.fas"),
#'     mcmc = create_test_mcmc(chain_length = 10000)
#'   )
#'   plot_densitree(out$anthus_aco_trees)
#' }
#' @export
plot_densitree <- function(
  phylos,
  ...
) {
  if (class(phylos) != "multiPhylo") {
    stop("'phylos' must be of class 'multiPhylo'")
  }
  phangorn::densiTree(phylos, ...)
}
