#' Get an example output of \code{\link{bbt_run}}
#' or \code{\link{bbt_run_from_model}}.
#'
#' This output is used in testing.
#' @return the same results as \code{\link{bbt_run}}
#'   or \code{\link{bbt_run_from_model}}
#' @author Richèl J.C. Bilderbeek
#' @examples
#' create_test_bbt_run_output()
#' @export
create_test_bbt_run_output <- function() {

  anthus_aco_trees <- c(
    ape::read.tree(text = "((A:2, B:2):1, C:3);"),
    ape::read.tree(text = "((A:1, B:1):2, C:3);")
  )

  estimates <- data.frame(
    Sample = c(0, 1000),
    posterior = c(-1.1, -2.2),
    likelihood = c(-3.3, -4.4),
    prior = c(-5.5, -6.6),
    treeLikelihood = c(-7.7, -8.8),
    TreeHeight = c(2.5, 2.8),
    YuleModel = c(0.5, 0.6),
    birthRate = c(0.1, 0.2)
  )

  operators <- data.frame(
    operator = c(
      "treeScaler.t:test-alignment_to_beast_posterior",
      "treeRootScaler.t:test-alignment_to_beast_posterior"
    ),
    p = c(0.4, 0.6),
    accept = c(1, 2),
    reject = c(3, 4),
    acceptFC = c(5, 6),
    rejectFC = c(7, 8),
    rejectIv = c(9, 10),
    rejectOp = c(11, 12)
  )

  output <- babette::create_test_ns_output()

  list(
    estimates = estimates,
    anthus_aco_trees = anthus_aco_trees,
    operators = operators,
    output = output
  )
}
