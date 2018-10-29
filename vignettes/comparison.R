## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----create_files, include = FALSE---------------------------------------
file.copy(babette::get_babette_path("anthus_aco.fas"), "anthus_aco.fas")

## ------------------------------------------------------------------------
library(babette)

## ------------------------------------------------------------------------
mcmc <- create_mcmc(chain_length = 10000, store_every = 1000)

## ------------------------------------------------------------------------
crown_age <- 15
fasta_filename <- "anthus_aco.fas"

## ----cache=FALSE---------------------------------------------------------
out_fca <- bbt_run(
  fasta_filename,
  posterior_crown_age = crown_age,
  mcmc = mcmc
)

## ----cache=FALSE---------------------------------------------------------
out_cn <- bbt_run(
  fasta_filename,
  mrca_priors = create_mrca_prior(
    alignment_id = get_alignment_id(fasta_filename),
    taxa_names = get_taxa_names(fasta_filename),
    mrca_distr = create_normal_distr(
      mean = crown_age,
      sigma = crown_age / 1000.0
    )
  ),
  mcmc = mcmc
)

## ------------------------------------------------------------------------
traces_fca <- remove_burn_ins(
  traces = out_fca$estimates, 
  burn_in_fraction = 0.2
)
traces_cn <- remove_burn_ins(
  traces = out_cn$estimates, 
  burn_in_fraction = 0.2
)

## ------------------------------------------------------------------------
esses_fca <- calc_esses(
  traces = traces_fca, 
  sample_interval = 1000
)
esses_cn <- calc_esses(
  traces = traces_cn, 
  sample_interval = 1000
)
knitr::kable(t(esses_fca))
knitr::kable(t(esses_cn))

## ------------------------------------------------------------------------
sum_stats_fca <- calc_summary_stats(
  traces = traces_fca, 
  sample_interval = 1000
)
sum_stats_cn <- calc_summary_stats(
  traces = traces_cn, 
  sample_interval = 1000
)
knitr::kable(t(sum_stats_fca))
knitr::kable(t(sum_stats_cn))

## ----cache=FALSE, fig.width=7, fig.height=7------------------------------
plot_densitree(phylos = out_fca$anthus_aco_trees, alpha = 1, width = 1)
plot_densitree(phylos = out_cn$anthus_aco_trees, alpha = 1, width = 1)

## ------------------------------------------------------------------------
if ("bug" == "fixed") {
  nLTT::nltts_plot(out_fca$anthus_aco_trees, plot_nltts = TRUE, main = "Fixed crown age")
  nLTT::nltts_plot(out_cn$anthus_aco_trees, plot_nltts = TRUE, main = "Calibration node")
}

## ----cleanup, include = FALSE--------------------------------------------
file.remove("anthus_aco.fas")

