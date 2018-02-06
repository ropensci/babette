#' Calls \code{phangorn}'s \link[phangorn]{densiTree} function
#' @author Richel J.C. Bilderbeek
#' @examples
#'   out <- run_beast2(
#'    get_path("anthus_aco.fas"),
#'    mcmc = create_mcmc(chain_length = 10000, store_every = 1000)
#'  )
#'  densitree(out$anthus_aco_trees)
#' @export
densitree <- function(phylos, ...) {
  if (class(phylos) != "multiPhylo") {
    stop("'phylos' must be of class 'multiPhylo'")
  }
  phangorn::densiTree(phylos, ...)
}
