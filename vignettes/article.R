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
  tree_priors = create_bd_tree_prior(),
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

## ------------------------------------------------------------------------
out <- bbt_run(
  "anthus_aco.fas",
  tree_priors = create_yule_tree_prior(
    birth_rate_distr = create_exp_distr()    
  ),
  mcmc = mcmc
)

## ------------------------------------------------------------------------
out <- bbt_run(
  "anthus_aco.fas",
  tree_priors = create_yule_tree_prior(
    birth_rate_distr = create_exp_distr(
      mean = 1.0
    )    
  ),
  mcmc = mcmc
)

## ------------------------------------------------------------------------
out <- bbt_run(
  "anthus_aco.fas",
  posterior_crown_age = 15,
  mcmc = mcmc
)

## ------------------------------------------------------------------------
out <- bbt_run(
  "anthus_aco.fas",
  mrca_priors = create_mrca_prior(
    alignment_id = get_alignment_id("anthus_aco.fas"),
    taxa_names = get_taxa_names("anthus_aco.fas"),
    mrca_distr = create_normal_distr(
      mean = 15.0,
      sigma = 0.01
    )
  ),
  mcmc = mcmc
)

## ------------------------------------------------------------------------
traces <- remove_burn_ins(
  traces = out$estimates, 
  burn_in_fraction = 0.2
)

## ------------------------------------------------------------------------
esses <- calc_esses(
  traces = traces, 
  sample_interval = 1000
)

## ------------------------------------------------------------------------
sum_stats <- calc_summary_stats(
  traces = traces, 
  sample_interval = 1000
)

## ------------------------------------------------------------------------
plot_densitree(phylos = out$anthus_aco_trees)

## ----cleanup, include = FALSE--------------------------------------------
file.remove("test_output_0.fas")
file.remove("my_fasta.fas")
file.remove("my_alignment.fas")
file.remove("anthus_aco.fas")
file.remove("anthus_nd2.fas")

