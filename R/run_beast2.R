#' Do a full BEAST2 run
#' @param fasta_filenames one or more FASTA filename, eachwith one alignment
#' @param site_models one or more site models,
#'   see \link[beautier]{create_site_models}
#' @param clock_models one or more clock models,
#'   see \link[beautier]{create_clock_models}
#' @param tree_priors one or more tree priors,
#'   see \link[beautier]{create_tree_priors}
#' @param mcmc the MCMC options,
#'   see \link[beautier]{create_mcmc}
#' @param posterior_crown_age the posterior's crown age. Use NA to let
#'   BEAST2 estimate this parameter. Use a positive value to fix the
#'   crown age to that value
#' @param beast_jar_path path to the BEAST2 jar file
#' @param verbose set to TRUE for more output
#' @author Richel J.C. Bilderbeek
#' @examples
#'    out <- run_beast2(
#'      fasta_filenames = get_path("anthus_aco.fas"),
#'      mcmc = beautier::create_mcmc(chain_length = 10000, store_every = 1000)
#'    )
#'
#'  testit::assert("log" %in% names(out))
#'  testit::assert("trees" %in% names(out))
#'  testit::assert("operators" %in% names(out))
#'  testit::assert(class(out$trees[[1]]) == "phylo")
#'  testit::assert(length(out$trees) == 10)
#'
#'  testit::assert("Sample" %in% names(out$log))
#'  testit::assert("posterior" %in% names(out$log))
#'  testit::assert("likelihood" %in% names(out$log))
#'  testit::assert("prior" %in% names(out$log))
#'  testit::assert("treeLikelihood" %in% names(out$log))
#'  testit::assert("TreeHeight" %in% names(out$log))
#'  testit::assert("YuleModel" %in% names(out$log))
#'  testit::assert("birthRate" %in% names(out$log))
#'
#'  testit::assert("operator" %in% names(out$operators))
#'  testit::assert("p" %in% names(out$operators))
#'  testit::assert("accept" %in% names(out$operators))
#'  testit::assert("reject" %in% names(out$operators))
#'  testit::assert("acceptFC" %in% names(out$operators))
#'  testit::assert("rejectFC" %in% names(out$operators))
#'  testit::assert("rejectIv" %in% names(out$operators))
#'  testit::assert("rejectOp" %in% names(out$operators))
#' @export
run_beast2 <- function(
  fasta_filenames,
  site_models = beautier::create_jc69_site_models(
    beautier::get_ids(fasta_filenames)),
  clock_models = beautier::create_strict_clock_models(
    beautier::get_ids(fasta_filenames)),
  tree_priors = beautier::create_yule_tree_priors(
    beautier::get_ids(fasta_filenames)),
  mcmc = beautier::create_mcmc(),
  posterior_crown_age = NA,
  beast_jar_path = "~/Programs/beast/lib/beast.jar",
  verbose = FALSE
) {
  beast2_input_file <- "beast2.xml"

  beautier::create_beast2_input_file(
    input_filenames = fasta_filenames,
    site_models = site_models,
    clock_models = clock_models,
    tree_priors = tree_priors,
    mcmc = mcmc,
    posterior_crown_age = posterior_crown_age,
    output_filename = beast2_input_file
  )

  beast2_output_log_filename <- "beast2.log"
  beast2_output_trees_filenames <- "beast2.trees"
  beast2_output_state_filename <- "beast2.xml.state"

  beastier::run_beast2(
    input_filename = beast2_input_file,
    output_log_filename = beast2_output_log_filename,
    output_trees_filenames = beast2_output_trees_filenames,
    output_state_filename = beast2_output_state_filename,
    beast_jar_path = beast_jar_path,
    verbose = verbose
  )

  out <- list(
    log = tracerer::parse_beast_log(beast2_output_log_filename),
    trees = tracerer::parse_beast_trees(beast2_output_trees_filenames),
    operators = tracerer::parse_beast_state_operators(
      beast2_output_state_filename
    )
  )
  out
}
