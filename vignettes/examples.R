## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----create_files, include = FALSE---------------------------------------
file.copy(babette::get_path("anthus_aco.fas"), "test_output_0.fas")
file.copy(babette::get_path("anthus_aco.fas"), "my_fasta.fas")
file.copy(babette::get_path("anthus_aco.fas"), "my_alignment.fas")
file.copy(babette::get_path("anthus_aco.fas"), "anthus_aco.fas")
file.copy(babette::get_path("anthus_nd2.fas"), "anthus_nd2.fas")

## ----load_babette, results='hide', warning=FALSE, error=FALSE, message=FALSE----
library(babette)

