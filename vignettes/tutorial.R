## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
library(babette)

## ------------------------------------------------------------------------
fasta_filename <- get_babette_path("anthus_aco.fas")
testit::assert(file.exists(fasta_filename))

## ------------------------------------------------------------------------
mcmc <- create_mcmc(chain_length = 2000, store_every = 1000)

## ------------------------------------------------------------------------
site_model <- create_site_model_jc69()
site_model <- create_jc69_site_model()

## ------------------------------------------------------------------------
clock_model <- create_clock_model_strict()
clock_model <- create_strict_clock_model()

## ----cache=TRUE----------------------------------------------------------
out <- bbt_run(
  fasta_filenames = fasta_filename,
  clock_model = clock_model,
  mcmc = mcmc
)

## ------------------------------------------------------------------------
tree_prior <- create_tree_prior_yule()
tree_prior <- create_yule_tree_prior()

## ------------------------------------------------------------------------
mrca_prior <- create_mrca_prior(
  alignment_id = get_alignment_id(fasta_filename = fasta_filename), 
  taxa_names = get_taxa_names(filename = fasta_filename)[1:2],
  is_monophyletic = TRUE
)

## ------------------------------------------------------------------------
mrca_distr <- create_normal_distr(
  mean = 15.0, 
  sigma = 1.0
)

## ------------------------------------------------------------------------
mrca_prior <- create_mrca_prior(
  alignment_id = get_alignment_id(fasta_filename = fasta_filename), 
  taxa_names = get_taxa_names(filename = fasta_filename),
  mrca_distr = mrca_distr
)

## ------------------------------------------------------------------------
if (1 == 2) {
  beast2_input_filename <- "beast_input.xml"
  beast2_output_log_filename <- "beast_ouput.log"
  beast2_output_trees_filenames <- "beast_output.trees"
  beast2_output_state_filename <- "beast_state.xml.state"
  all_files <- c(
    beast2_input_filename,
    beast2_output_log_filename,
    beast2_output_trees_filenames,
    beast2_output_state_filename
  )
    
  out <- bbt_run(
    fasta_filenames = fasta_filename,
    mcmc = mcmc,
    beast2_input_filename = beast2_input_filename,
    beast2_output_log_filename = beast2_output_log_filename,
    beast2_output_trees_filenames = beast2_output_trees_filenames,
    beast2_output_state_filename = beast2_output_state_filename
  )
  testit::assert(all(file.exists(all_files)))
  file.remove(all_files)
}

## ------------------------------------------------------------------------
beast2_path <- beastier::get_default_beast2_path()
print(beast2_path)

## ------------------------------------------------------------------------
if (file.exists(beast2_path)) {
  out <- bbt_run(
    fasta_filenames = fasta_filename,
    mcmc = mcmc,
    beast2_path = beast2_path
  )
}

