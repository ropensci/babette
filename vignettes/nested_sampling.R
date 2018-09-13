## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
library(babette)

## ------------------------------------------------------------------------
if (!file.exists(get_default_beast2_path()))
{
  print("Installing BEAST2 to default location")
  install_beast2()
}

## ------------------------------------------------------------------------
if (!mauricer::mrc_is_installed("NS"))
{
  print("Installing BEAST2 package 'NS'")
  mauricer::mrc_install("NS")
}

## ------------------------------------------------------------------------
out <- bbt_run(
  fasta_filenames = get_babette_path("anthus_aco_sub.fas"),
  mcmc = create_mcmc_nested_sampling(
    chain_length = 100000, 
    store_every = -1,
    particle_count = 1,
    sub_chain_length = 500
  ),
  beast2_path = beastier::get_default_beast2_bin_path(),
  beast2_input_filename = "/home/richel/out.xml",
  cleanup = FALSE,
  verbose = TRUE
)

## ------------------------------------------------------------------------
knitr::kable(out$estimates)

## ------------------------------------------------------------------------
print(out$output)

