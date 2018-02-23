## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----create_files, include = FALSE---------------------------------------
file.copy(rbeast2::get_path("anthus_aco.fas"), "test_output_0.fas")
file.copy(rbeast2::get_path("anthus_aco.fas"), "my_fasta.fas")
file.copy(rbeast2::get_path("anthus_aco.fas"), "my_alignment.fas")
file.copy(rbeast2::get_path("anthus_aco.fas"), "anthus_aco.fas")
file.copy(rbeast2::get_path("anthus_nd2.fas"), "anthus_nd2.fas")

## ------------------------------------------------------------------------
library(rbeast2)
mcmc <- create_mcmc(chain_length = 2000, store_every = 1000)

## ----cache=TRUE----------------------------------------------------------
out <- run_beast2("anthus_aco.fas", mcmc = mcmc)

## ----cache=TRUE----------------------------------------------------------
out <- run_beast2(
  "anthus_aco.fas",
  site_models = create_hky_site_model(),
  clock_models = create_rln_clock_model(),
  tree_priors = create_bd_tree_prior(),
  mcmc = mcmc
)

## ----cache=TRUE----------------------------------------------------------
out <- run_beast2(
  c("anthus_aco.fas", "anthus_nd2.fas"),
  site_models = list(
    create_tn93_site_model(), 
    create_gtr_site_model()
  ),
  mcmc = mcmc
)

## ----cache=TRUE----------------------------------------------------------
out <- run_beast2(
  "anthus_aco.fas",
  tree_priors = create_yule_tree_prior(
    birth_rate_distr = create_exp_distr()    
  ),
  mcmc = mcmc
)

## ----cache=TRUE----------------------------------------------------------
out <- run_beast2(
  "anthus_aco.fas",
  tree_priors = create_yule_tree_prior(
    birth_rate_distr = create_exp_distr(
      mean = create_mean_param(value = 1.0)
    )    
  ),
  mcmc = mcmc
)

## ----cache=TRUE----------------------------------------------------------
out <- run_beast2(
  "anthus_aco.fas",
  posterior_crown_age = 15,
  mcmc = mcmc
)

## ------------------------------------------------------------------------
traces <- remove_burn_ins(out$estimates)

## ------------------------------------------------------------------------
esses <- calc_esses(
  traces, 
  sample_interval = 1000
)

## ------------------------------------------------------------------------
sum_stats <- calc_summary_stats(
  traces, 
  sample_interval = 1000
)

## ----cache=TRUE----------------------------------------------------------
plot_densitree(out$anthus_aco_trees)

## ----cleanup, include = FALSE--------------------------------------------
file.remove("test_output_0.fas")
file.remove("my_fasta.fas")
file.remove("my_alignment.fas")
file.remove("anthus_aco.fas")
file.remove("anthus_nd2.fas")

