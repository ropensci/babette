## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----create_files, include = FALSE---------------------------------------
file.copy(babette::get_babette_path("anthus_aco.fas"), "test_output_0.fas")
file.copy(babette::get_babette_path("anthus_aco.fas"), "my_fasta.fas")
file.copy(babette::get_babette_path("anthus_aco.fas"), "my_alignment.fas")
file.copy(babette::get_babette_path("anthus_aco.fas"), "anthus_aco.fas")
file.copy(babette::get_babette_path("anthus_nd2.fas"), "anthus_nd2.fas")

## ----load_babette, results='hide', warning=FALSE, error=FALSE, message=FALSE----
library(babette)

## ------------------------------------------------------------------------
mcmc <- create_mcmc(chain_length = 10000, store_every = 1000)

## ----fig.width=7, fig.height=7-------------------------------------------
ggplot2::ggplot(
  data = posterior$estimates,
  ggplot2::aes(x = Sample)
) + ggplot2::geom_line(ggplot2::aes(y = birthRate))
plot_densitree(posterior$test_output_0_trees, width = 2)

## ----example_2_mrca, cache=FALSE-----------------------------------------
posterior <- bbt_run(
  "my_fasta.fas",
  mcmc = mcmc,
  mrca_prior = create_mrca_prior(
    taxa_names = sample(get_taxa_names("my_fasta.fas"), size = 3),
    alignment_id = get_alignment_id("my_fasta.fas"),
    is_monophyletic = TRUE,
    mrca_distr = create_normal_distr(
      mean = 15.0,
      sigma = 0.025
    )
  )
)

## ----fig.width=7, fig.height=7-------------------------------------------
ggplot2::ggplot(
  data = posterior$estimates,
  ggplot2::aes(x = Sample)
) + ggplot2::geom_line(ggplot2::aes(y = birthRate))
plot_densitree(posterior$my_fasta_trees, width = 2)

## ----fig.width=7, fig.height=7-------------------------------------------
ggplot2::ggplot(
  data = posterior$estimates,
  ggplot2::aes(x = Sample)
) + ggplot2::geom_line(ggplot2::aes(y = birthRate))
plot_densitree(posterior$my_alignment_trees, width = 2)

## ----fig.width=7, fig.height=7-------------------------------------------
ggplot2::ggplot(
  data = posterior$estimates,
  ggplot2::aes(x = Sample)
) + ggplot2::geom_line(ggplot2::aes(y = birthRate))
plot_densitree(posterior$my_alignment_trees, width = 2)

## ----example_5, cache=TRUE-----------------------------------------------
posterior <- bbt_run(
  "my_alignment.fas",
  tree_prior = create_bd_tree_prior(), 
  mcmc = mcmc
)

## ----fig.width=7, fig.height=7-------------------------------------------
ggplot2::ggplot(
  data = posterior$estimates,
  ggplot2::aes(x = Sample)
) + ggplot2::geom_line(ggplot2::aes(y = BDBirthRate))
plot_densitree(posterior$my_alignment_trees, width = 2)

## ----example_6, cache=TRUE-----------------------------------------------
posterior <- bbt_run(
  "my_alignment.fas",
  tree_prior = create_yule_tree_prior(
    birth_rate_distr = create_normal_distr(
      mean = 1.0,
      sigma = 0.1
    )
  ),
  mcmc = mcmc
)

## ----fig.width=7, fig.height=7-------------------------------------------
ggplot2::ggplot(
  data = posterior$estimates,
  ggplot2::aes(x = Sample)
) + ggplot2::geom_line(ggplot2::aes(y = birthRate))
plot_densitree(posterior$my_alignment_trees, width = 2)

## ----fig.width=7, fig.height=7-------------------------------------------
ggplot2::ggplot(
  data = posterior$estimates,
  ggplot2::aes(x = Sample)
) + ggplot2::geom_line(ggplot2::aes(y = birthRate))
plot_densitree(posterior$my_alignment_trees, width = 2)

## ----fig.width=7, fig.height=7-------------------------------------------
ggplot2::ggplot(
  data = posterior$estimates,
  ggplot2::aes(x = Sample)
) + ggplot2::geom_line(ggplot2::aes(y = birthRate))
plot_densitree(posterior$my_alignment_trees, width = 2)

## ----cleanup, include = FALSE--------------------------------------------
file.remove("test_output_0.fas")
file.remove("my_fasta.fas")
file.remove("my_alignment.fas")
file.remove("anthus_aco.fas")
file.remove("anthus_nd2.fas")

