## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----create_files, include = FALSE---------------------------------------
file.copy(babette::get_babette_path("anthus_aco_sub.fas"), "test_output_0.fas")
file.copy(babette::get_babette_path("anthus_aco_sub.fas"), "my_fasta.fas")
file.copy(babette::get_babette_path("anthus_aco_sub.fas"), "my_alignment.fas")
file.copy(babette::get_babette_path("anthus_aco_sub.fas"), "anthus_aco.fas")
file.copy(babette::get_babette_path("anthus_nd2_sub.fas"), "anthus_nd2.fas")

## ------------------------------------------------------------------------
library(babette)
mcmc <- create_mcmc(chain_length = 2000, store_every = 1000)

## ------------------------------------------------------------------------
out <- bbt_run(
  fasta_filenames = "anthus_aco.fas", 
  mcmc = mcmc
)

## ------------------------------------------------------------------------
out <- bbt_run(
  "anthus_aco.fas",
  site_models = create_hky_site_model(),
  clock_models = create_rln_clock_model(),
  tree_prior = create_bd_tree_prior(),
  mcmc = mcmc
)

## ------------------------------------------------------------------------
# Currently, support for multiple alignments has been deprecated
if (1 == 2) {
  out <- bbt_run(
    c("anthus_aco.fas", "anthus_nd2.fas"),
    site_models = list(
      create_tn93_site_model(), 
      create_gtr_site_model()
    ),
    mcmc = mcmc
  )
}

