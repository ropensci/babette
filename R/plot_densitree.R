#' Calls \code{phangorn}'s \link[phangorn]{densiTree} function
#' @param phylos one or more phylogenies, must be of class \code{multiPhylo}
#' @param ... options to be passed to \code{phangorn}'s
#'   \link[phangorn]{densiTree} function
#' @author Richel J.C. Bilderbeek
#' @examples
#'   out <- run(
#'    get_babette_path("anthus_aco.fas"),
#'    mcmc = create_mcmc(chain_length = 10000, store_every = 1000)
#'  )
#'  plot_densitree(out$anthus_aco_trees)
#' @export
plot_densitree <- function(phylos, ...) {
  if (class(phylos) != "multiPhylo") {
    stop("'phylos' must be of class 'multiPhylo'")
  }
  phangorn::densiTree(phylos, ...)
}
