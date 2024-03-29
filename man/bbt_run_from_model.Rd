% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bbt_run_from_model.R
\name{bbt_run_from_model}
\alias{bbt_run_from_model}
\title{Run BEAST2}
\usage{
bbt_run_from_model(
  fasta_filename,
  inference_model = beautier::create_inference_model(),
  beast2_options = beastier::create_beast2_options()
)
}
\arguments{
\item{fasta_filename}{a FASTA filename}

\item{inference_model}{a Bayesian phylogenetic inference model,
as returned by \link[beautier]{create_inference_model}}

\item{beast2_options}{'BEAST2'  options,
as can be created by \link[beastier]{create_beast2_options}}
}
\value{
a list with the following elements:\cr
\itemize{
  \item{
    \code{estimates}: a data frame with 'BEAST2'
    parameter estimates
  }
  \item{
    \code{[alignment_id]_trees}: a \code{multiPhylo}
    containing the phylogenies
    in the 'BEAST2' posterior. \code{[alignment_id]}
    is the ID of the alignment. For example,
    when running \code{bbt_run_from_model} with
    \code{anthus_aco.fas}, this element will have
    name \code{anthus_aco_trees}
  }
  \item{
    \code{operators}: a data frame with the
    'BEAST2' MCMC operator acceptances
  }
  \item{
    \code{output}: a numeric vector with the output
    sent to standard output and error streams
  }
  \item{
    \code{ns}: (optional) the results of a marginal likelihood estimation,
    will exist only when \code{create_ns_mcmc} was
    used for \code{mcmc}.
    This structure will contain the following elements:
    \itemize{
      \item \code{marg_log_lik} the marginal log likelihood estimate
      \item \code{marg_log_lik_sd} the standard deviation around the estimate
      \item \code{estimates} the parameter estimates
        created during the marginal likelihood estimation
      \item \code{trees} the trees
        created during the marginal likelihood estimation
    }
  }
}
}
\description{
Do a full run: create a 'BEAST2' configuration file (like 'BEAUti 2'),
run 'BEAST2', parse results (like 'Tracer')
}
\examples{
if (beautier::is_on_ci() && is_beast2_installed()) {
  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()

  # Simple short inference
  inference_model <- create_test_inference_model()

  # Default BEAST2 options
  beast2_options <- create_beast2_options()

  bbt_run_from_model(
    fasta_filename = get_babette_path("anthus_aco.fas"),
    inference_model = inference_model,
    beast2_options = beast2_options
  )

  # Cleanup
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
}
}
\seealso{
Use \code{\link[tracerer]{remove_burn_ins}}
  to remove the burn-ins from
  the posterior's estimates (\code{posterior$estimates})
}
\author{
Richèl J.C. Bilderbeek
}
