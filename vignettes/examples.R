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

## ----load_babette--------------------------------------------------------
library(babette)

## ------------------------------------------------------------------------
mcmc <- create_mcmc(chain_length = 10000, store_every = 1000)

## ----example_1, cache=TRUE-----------------------------------------------
posterior <- run_beast2(
  "test_output_0.fas",
  mcmc = mcmc
)

## ----fig.width=7, fig.height=7-------------------------------------------
ggplot2::ggplot(
  data = posterior$estimates,
  ggplot2::aes(x = Sample)
) + ggplot2::geom_line(ggplot2::aes(y = birthRate))
densitree(posterior$test_output_0_trees, width = 2)

## ----example_2, cache=TRUE-----------------------------------------------
posterior <- run_beast2(
  "my_fasta.fas",
  posterior_crown_age = 15,
  mcmc = mcmc
)

## ----fig.width=7, fig.height=7-------------------------------------------
ggplot2::ggplot(
  data = posterior$estimates,
  ggplot2::aes(x = Sample)
) + ggplot2::geom_line(ggplot2::aes(y = birthRate))
densitree(posterior$my_fasta_trees, width = 2)

## ----example_3, cache=TRUE-----------------------------------------------
posterior <- run_beast2(
  "my_alignment.fas",
  site_models = create_jc69_site_model(),
  mcmc = mcmc
)

## ----fig.width=7, fig.height=7-------------------------------------------
ggplot2::ggplot(
  data = posterior$estimates,
  ggplot2::aes(x = Sample)
) + ggplot2::geom_line(ggplot2::aes(y = birthRate))
densitree(posterior$my_alignment_trees, width = 2)

## ----example_4, cache=TRUE-----------------------------------------------
posterior <- run_beast2(
  "my_alignment.fas",
  clock_models = create_rln_clock_model(),
  mcmc = mcmc
)

## ----fig.width=7, fig.height=7-------------------------------------------
ggplot2::ggplot(
  data = posterior$estimates,
  ggplot2::aes(x = Sample)
) + ggplot2::geom_line(ggplot2::aes(y = birthRate))
densitree(posterior$my_alignment_trees, width = 2)

## ----example_5, cache=TRUE-----------------------------------------------
posterior <- run_beast2(
  "my_alignment.fas",
  tree_priors = create_bd_tree_prior(), 
  mcmc = mcmc
)

## ----fig.width=7, fig.height=7-------------------------------------------
ggplot2::ggplot(
  data = posterior$estimates,
  ggplot2::aes(x = Sample)
) + ggplot2::geom_line(ggplot2::aes(y = BDBirthRate))
densitree(posterior$my_alignment_trees, width = 2)

## ----example_6, cache=TRUE-----------------------------------------------
posterior <- run_beast2(
  "my_alignment.fas",
  tree_priors = create_yule_tree_prior(
    birth_rate_distr = create_normal_distr(
      mean = create_mean_param(value = 1.0),
      sigma = create_sigma_param(value = 0.1)
    )
  ),
  mcmc = mcmc
)

## ----fig.width=7, fig.height=7-------------------------------------------
ggplot2::ggplot(
  data = posterior$estimates,
  ggplot2::aes(x = Sample)
) + ggplot2::geom_line(ggplot2::aes(y = birthRate))
densitree(posterior$my_alignment_trees, width = 2)

## ----example_7, cache=TRUE-----------------------------------------------
posterior <- run_beast2(
  "my_alignment.fas",
  site_models = create_hky_site_model(
    gamma_site_model = create_gamma_site_model(prop_invariant = 0.5)
  ),
  mcmc = mcmc
)

## ----fig.width=7, fig.height=7-------------------------------------------
ggplot2::ggplot(
  data = posterior$estimates,
  ggplot2::aes(x = Sample)
) + ggplot2::geom_line(ggplot2::aes(y = birthRate))
densitree(posterior$my_alignment_trees, width = 2)

## ----example_8, cache=TRUE-----------------------------------------------
posterior <- run_beast2(
  "my_alignment.fas",
  clock_models = create_strict_clock_model(
    clock_rate_param = create_clock_rate_param(value = 0.5)
  ), 
  mcmc = mcmc
)

## ----fig.width=7, fig.height=7-------------------------------------------
ggplot2::ggplot(
  data = posterior$estimates,
  ggplot2::aes(x = Sample)
) + ggplot2::geom_line(ggplot2::aes(y = birthRate))
densitree(posterior$my_alignment_trees, width = 2)

## ----example_9, cache=TRUE-----------------------------------------------
posterior <- run_beast2(
  c("anthus_aco.fas", "anthus_nd2.fas"),
  mcmc = mcmc
)

## ----fig.width=7, fig.height=7-------------------------------------------
ggplot2::ggplot(
  data = posterior$estimates,
  ggplot2::aes(x = Sample)
) + ggplot2::geom_line(ggplot2::aes(y = birthRate.aco), color = "red") +
  ggplot2::geom_line(ggplot2::aes(y = birthRate.nd2), color = "green")
densitree(posterior$anthus_aco_trees, width = 2)
densitree(posterior$anthus_nd2_trees, width = 2)

## ----example_10, cache=TRUE----------------------------------------------
posterior <- run_beast2(
  c("anthus_aco.fas", "anthus_nd2.fas"),
  site_models = list(
    create_hky_site_model(), 
    create_tn93_site_model()
  ),
  mcmc = mcmc
)

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

