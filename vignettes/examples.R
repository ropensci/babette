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

## ----load_rbeast2, results='hide', warning=FALSE, error=FALSE, message=FALSE----
library(rbeast2)

## ------------------------------------------------------------------------
mcmc <- create_mcmc(chain_length = 10000, store_every = 1000)

## ----fig.width=7, fig.height=7-------------------------------------------
ggplot2::ggplot(
  data = posterior$estimates,
  ggplot2::aes(x = Sample)
) + ggplot2::geom_line(ggplot2::aes(y = birthRate))
densitree(posterior$test_output_0_trees, width = 2)

## ----fig.width=7, fig.height=7-------------------------------------------
ggplot2::ggplot(
  data = posterior$estimates,
  ggplot2::aes(x = Sample)
) + ggplot2::geom_line(ggplot2::aes(y = birthRate))
densitree(posterior$my_fasta_trees, width = 2)

## ----fig.width=7, fig.height=7-------------------------------------------
ggplot2::ggplot(
  data = posterior$estimates,
  ggplot2::aes(x = Sample)
) + ggplot2::geom_line(ggplot2::aes(y = birthRate))
densitree(posterior$my_alignment_trees, width = 2)

## ----fig.width=7, fig.height=7-------------------------------------------
ggplot2::ggplot(
  data = posterior$estimates,
  ggplot2::aes(x = Sample)
) + ggplot2::geom_line(ggplot2::aes(y = birthRate))
densitree(posterior$my_alignment_trees, width = 2)

## ----fig.width=7, fig.height=7-------------------------------------------
ggplot2::ggplot(
  data = posterior$estimates,
  ggplot2::aes(x = Sample)
) + ggplot2::geom_line(ggplot2::aes(y = BDBirthRate))
densitree(posterior$my_alignment_trees, width = 2)

## ----fig.width=7, fig.height=7-------------------------------------------
ggplot2::ggplot(
  data = posterior$estimates,
  ggplot2::aes(x = Sample)
) + ggplot2::geom_line(ggplot2::aes(y = birthRate))
densitree(posterior$my_alignment_trees, width = 2)

## ----fig.width=7, fig.height=7-------------------------------------------
ggplot2::ggplot(
  data = posterior$estimates,
  ggplot2::aes(x = Sample)
) + ggplot2::geom_line(ggplot2::aes(y = birthRate))
densitree(posterior$my_alignment_trees, width = 2)

## ----fig.width=7, fig.height=7-------------------------------------------
ggplot2::ggplot(
  data = posterior$estimates,
  ggplot2::aes(x = Sample)
) + ggplot2::geom_line(ggplot2::aes(y = birthRate))
densitree(posterior$my_alignment_trees, width = 2)

## ----fig.width=7, fig.height=7-------------------------------------------
ggplot2::ggplot(
  data = posterior$estimates,
  ggplot2::aes(x = Sample)
) + ggplot2::geom_line(ggplot2::aes(y = birthRate.aco), color = "red") +
  ggplot2::geom_line(ggplot2::aes(y = birthRate.nd2), color = "green")
densitree(posterior$anthus_aco_trees, width = 2)
densitree(posterior$anthus_nd2_trees, width = 2)

## ----fig.width=7, fig.height=7-------------------------------------------
ggplot2::ggplot(
  data = posterior$estimates,
  ggplot2::aes(x = Sample)
) + ggplot2::geom_line(ggplot2::aes(y = birthRate.aco), color = "red") +
  ggplot2::geom_line(ggplot2::aes(y = birthRate.nd2), color = "green")
densitree(posterior$anthus_aco_trees, width = 2)
densitree(posterior$anthus_nd2_trees, width = 2)

## ----cleanup, include = FALSE--------------------------------------------
file.remove("test_output_0.fas")
file.remove("my_fasta.fas")
file.remove("my_alignment.fas")
file.remove("anthus_aco.fas")
file.remove("anthus_nd2.fas")

