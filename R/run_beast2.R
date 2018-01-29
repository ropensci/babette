#' @param fasta_filename
#' @param site_models = site_models,
#' @param clock_models = clock_models,
#' @param tree_priors = tree_priors,
#' @param mcmc = mcmc,
#' @param posterior_crown_age = posterior_crown_age,
#' @param beast2_input_file
#' @export
run_beast2 <- function(
  fasta_filename,
  site_models = beautier::create_site_models(),
  clock_models = beautier::create_clock_models(),
  tree_priors = beautier::create_tree_priors(),
  mcmc = beautier::create_mcmc(),
  posterior_crown_age = NA,
  beast2_input_file = "beast2.xml",
  beast2_output_log_filename = "beast2.log",
  beast2_output_trees_filenames = "beast2.trees",
  beast2_output_state_filename = "beast2.xml.state",
  beast_jar_path = "~/Programs/beast/lib/beast.jar",
  verbose = FALSE
) {

  beautier::create_beast2_input_file(
    input_filenames = fasta_filename,
    site_models = site_models,
    clock_models = clock_models,
    tree_priors = tree_priors,
    mcmc = mcmc,
    posterior_crown_age = posterior_crown_age,
    output_filename = beast2_input_file
  )

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
}
