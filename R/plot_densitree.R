#' Draw multiple trees on top of one another.
#'
#'
#' @param library the library to use:
#'   \itemize{
#'     \item \code{ggtree}: use \code{ggtree}'s
#'       \link[ggtree]{ggtree} function
#'     \item \code{phangorn}: use \code{phangorn}'s
#'       \link[phangorn]{densiTree} function
#'   }
#' @param phylos one or more phylogenies, must be of class \code{multiPhylo}
#' @param ... options to be passed to \code{phangorn}'s
#'   \link[phangorn]{densiTree} function
#' @return nothing. Will produce a plot.
#' @author Richel J.C. Bilderbeek
#' @examples
#'   out <- bbt_run(
#'    get_babette_path("anthus_aco.fas"),
#'    mcmc = create_mcmc(chain_length = 10000, store_every = 1000)
#'  )
#'  plot_densitree(out$anthus_aco_trees)
#' @export
plot_densitree <- function(
  phylos,
  library = "ggtree",
  ...
) {
  if (class(phylos) != "multiPhylo") {
    stop("'phylos' must be of class 'multiPhylo'")
  }
  if (library == "phangorn") {
    phangorn::densiTree(phylos, ...)
  } else {
    testit::assert(library == "ggtree")
    ggtree::ggtree(phylos, layout = "slanted", alpha =  1.0 / length(phylos)) +
      ggtree::geom_tiplab() +
      ggtree::geom_treescale()
  }
}
