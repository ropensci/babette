## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
library(babette)

## ------------------------------------------------------------------------
chain_length <- 10000
sample_interval <- 1000

## ----cache=TRUE----------------------------------------------------------
out <- run_beast2(
  get_path("anthus_aco.fas"),
  mcmc = beautier::create_mcmc(
    chain_length = chain_length, 
    store_every = sample_interval
  ),
  cleanup = FALSE,
  verbose = TRUE
)

## ------------------------------------------------------------------------
p <- ggplot2::ggplot(
  data = out$estimates,
  ggplot2::aes(x = Sample)
) 
p + ggplot2::geom_line(ggplot2::aes(y = TreeHeight), color = "green")
p + ggplot2::geom_line(ggplot2::aes(y = YuleModel), color = "red")
p + ggplot2::geom_line(ggplot2::aes(y = birthRate), color = "blue")


## ------------------------------------------------------------------------
traces <- tracerer::remove_burn_ins(traces = out$estimates, burn_in_fraction = 0.2)
esses <- t(tracerer::calc_esses(traces, sample_interval = sample_interval))
colnames(esses) <- "ESS"
knitr::kable(esses)

## ------------------------------------------------------------------------
#trees <- out$anthus_aco_trees
#class(trees) <- "multiPhylo"
#phangorn::densiTree(trees)

## ------------------------------------------------------------------------
p <- ggplot2::ggplot(
  data = out$estimates,
  ggplot2::aes(x = Sample)
) 
p + ggplot2::geom_line(ggplot2::aes(y = TreeHeight.aco), color = "green") +
   ggplot2::geom_line(ggplot2::aes(y = TreeHeight.nd2), color = "lightgreen")
p + ggplot2::geom_line(ggplot2::aes(y = YuleModel.aco), color = "red") +
  ggplot2::geom_line(ggplot2::aes(y = YuleModel.nd2), color = "pink")
p + ggplot2::geom_line(ggplot2::aes(y = birthRate.aco), color = "blue") + 
  ggplot2::geom_line(ggplot2::aes(y = birthRate.nd2), color = "cyan")


## ------------------------------------------------------------------------
traces <- tracerer::remove_burn_ins(traces = out$estimates, burn_in_fraction = 0.2)
esses <- t(tracerer::calc_esses(traces, sample_interval = sample_interval))
colnames(esses) <- "ESS"
knitr::kable(esses)

## ------------------------------------------------------------------------
p <- ggplot2::ggplot(
  data = out$estimates,
  ggplot2::aes(x = Sample)
) 
p + ggplot2::geom_line(ggplot2::aes(y = TreeHeight.aco), color = "green") +
   ggplot2::geom_line(ggplot2::aes(y = TreeHeight.nd2), color = "lightgreen")
p + ggplot2::geom_line(ggplot2::aes(y = YuleModel.aco), color = "red") +
  ggplot2::geom_line(ggplot2::aes(y = YuleModel.nd2), color = "pink")
p + ggplot2::geom_line(ggplot2::aes(y = birthRate.aco), color = "blue") + 
  ggplot2::geom_line(ggplot2::aes(y = birthRate.nd2), color = "cyan")


## ------------------------------------------------------------------------
traces <- tracerer::remove_burn_ins(traces = out$estimates, burn_in_fraction = 0.2)
esses <- t(tracerer::calc_esses(traces, sample_interval = sample_interval))
colnames(esses) <- "ESS"
knitr::kable(esses)

