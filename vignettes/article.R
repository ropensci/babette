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

