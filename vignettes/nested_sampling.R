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
beast2_input_file <- tempfile(fileext = ".xml")
beautier::create_beast2_input_file(
  input_filenames = get_babette_path("anthus_aco_sub.fas"),
  output_filename = beast2_input_file,
  mcmc = create_mcmc_nested_sampling(chain_length = 10000)
)

## ------------------------------------------------------------------------
out <- bbt_run(
  fasta_filenames = get_babette_path("anthus_aco_sub.fas"),
  mcmc = create_mcmc_nested_sampling(chain_length = 20000, store_every = 1000),
  beast2_input_filename = beast2_input_file,
  beast2_path = beastier::get_default_beast2_bin_path()
)

## ------------------------------------------------------------------------
knitr::kable(out$estimates)

