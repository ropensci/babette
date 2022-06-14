#' Create NS testing output
#'
#' Create testing output similar to when running a 'BEAST2' run
#' with nested sampling
#' @author Richèl J.C. Bilderbeek
#' @seealso Use \link{parse_beast2_output_to_ns} to parse
#' this output to a Nested Sampling result.
#' See \link[beautier]{create_ns_mcmc} to see how to do a marginal
#' likelihood estimation using Nested Sampling.
#' @examples
#' beastier::remove_beaustier_folder()
#' beastier::check_empty_beaustier_folders()
#'
#' create_test_ns_output()
#'
#' beastier::remove_beaustier_folder()
#' beastier::check_empty_beaustier_folders()
#' @export
create_test_ns_output <- function() {
  c(
    "[/usr/lib/jvm/java-8-oracle/bin/java, -Djava.library.path=/usr/local/lib:/usr/java/packages/lib/amd64:/usr/lib64:/lib64:/lib:/usr/lib, -cp, ::/home/richel/.beast/2.5/MODEL_SELECTION/lib/MODEL_SELECTION.addon.jar:/home/richel/.beast/2.5/BEASTLabs/lib/BEASTlabs.addon.jar:/home/richel/.beast/2.5/NS/lib/NS.addon.jar:/home/richel/.beast/2.5/BEAST/lib/beast.src.jar:/home/richel/.beast/2.5/BEAST/lib/beast.jar, beast.app.beastapp.BeastMain, nested_sampling.xml]", # nolint output is long
    "",
    "                        BEAST v2.5.0, 2002-2018",
    "             Bayesian Evolutionary Analysis Sampling Trees",
    "                       Designed and developed by",
    " Remco Bouckaert, Alexei J. Drummond, Andrew Rambaut & Marc A. Suchard",
    "                                    ",
    "                     Department of Computer Science",
    "                         University of Auckland",
    "                        remco@cs.auckland.ac.nz",
    "                        alexei@cs.auckland.ac.nz",
    "                                    ",
    "                   Institute of Evolutionary Biology",
    "                        University of Edinburgh",
    "                           a.rambaut@ed.ac.uk",
    "                                    ",
    "                    David Geffen School of Medicine",
    "                 University of California, Los Angeles",
    "                           msuchard@ucla.edu",
    "                                    ",
    "                      Downloads, Help & Resources:",
    "                           http://beast2.org/",
    "                                    ",
    "  Source code distributed under the GNU Lesser General Public License:",
    "                   http://github.com/CompEvol/beast2",
    "                                    ",
    "                           BEAST developers:",
    "   Alex Alekseyenko, Trevor Bedford, Erik Bloomquist, Joseph Heled, ",
    " Sebastian Hoehna, Denise Kuehnert, Philippe Lemey, Wai Lok Sibon Li, ",
    "Gerton Lunter, Sidney Markowitz, Vladimir Minin, Michael Defoin Platel, ",
    "          Oliver Pybus, Tim Vaughan, Chieh-Hsi Wu, Walter Xie",
    "                                    ",
    "                               Thanks to:",
    "          Roald Forsberg, Beth Shapiro and Korbinian Strimmer",
    "",
    "Random number seed: 1539258042094",
    "",
    "File: nested_sampling.xml seed: 1539258042094 threads: 1",
    "61430_aco: 78 4",
    "626029_aco: 78 4",
    "630116_aco: 78 4",
    "630210_aco: 78 4",
    "B25702_aco: 78 4",
    "Alignment(anthus_aco_sub)",
    "  5 taxa",
    "  78 sites",
    "  9 patterns",
    "",
    "Failed to load BEAGLE library: no hmsbeagle-jni in java.library.path",
    "TreeLikelihood(treeLikelihood.anthus_aco_sub0) uses BeerLikelihoodCore4",
    "  Alignment(anthus_aco_sub): [taxa, patterns, sites] = [5, 9, 78]",
    "===============================================================================", # nolint output is long
    "Citations for this model:",
    "",
    "Patricio Maturana, Brendon J. Brewer, Steffen Klaere, Remco Bouckaert. Model selection and parameter inference in phylogenetics using Nested Sampling. Systematic Biology, syy050, 2018", # nolint output is long
    "",
    "===============================================================================", # nolint output is long
    "Counting 19 parameters",
    "replacing logger tracelog with NSLogger",
    "Writing file anthus_aco_sub.trees",
    "         Sample      posterior ESS(posterior)     likelihood          prior", # nolint output is long
    "Writing file anthus_aco_sub.log",
    "Start likelihood 0: -225.2488738545589 ",
    "1 particles initialised",
    "              0      -140.6759              N      -157.4874        16.8115 --", # nolint output is long
    "ML: -158.32601908408833 Information: 0.8385606384288167",
    "              1      -124.4630         2.0         -143.0242        18.5611 --", # nolint output is long
    "ML: -144.86277038390745 Information: 1.8385386453449868",
    "              2      -124.6624         3.0         -141.6496        16.9872 --", # nolint output is long
    "ML: -143.96492404000415 Information: 1.7551898946725117",
    "              3      -124.9536         4.0         -139.0497        14.0961 --", # nolint output is long
    "ML: -142.59510010333074 Information: 2.7422179576086307",
    "             24      -125.0399        14.8         -137.0128        11.9729 --", # nolint output is long
    "ML: -141.98047696172614 Information: 2.8349216678190885",
    "             25      -124.7614        15.4         -137.0127        12.2512 --", # nolint output is long
    "ML: -141.98047696086337 Information: 2.8349216687952605",
    "             26      -124.7070        15.9         -137.0124        12.3054 --", # nolint output is long
    "ML: -141.98047696054587 Information: 2.8349216691561026",
    "             27      -124.6071        16.2         -137.0106        12.4035 --", # nolint output is long
    "ML: -141.98047696042886 Information: 2.8349216692884056",
    "28<=10000&& (28<2.0*2.8349216692884056*1||Math.abs(-141.98047696042886 - -141.98047696054587)/Math.abs(-141.98047696042886) > 1.0E-12", # nolint output is long
    "Finished in 28 steps!",
    "Marginal likelihood: -141.31236790862764 (bootstrap SD=1.4240215445106443)", # nolint output is long
    "Marginal likelihood: -140.98848039195855 (subsample SD=1.8638865000383444)", # nolint output is long
    "Marginal likelihood: -141.1644574217485(1.1601428428211327)",
    "Information: 2.8349216692884056",
    "SD: 1.6837225630395305",
    "",
    "Operator                                                    Tuning    #accept    #reject      Pr(m)  Pr(acc|m)", # nolint output is long
    "ScaleOperator(YuleBirthRateScaler.t:anthus_aco_sub)        0.75000       4797        998    0.04000    0.82778 Try setting scaleFactor to about 0.562", # nolint output is long
    "ScaleOperator(YuleModelTreeScaler.t:anthus_aco_sub)        0.50000       1116       4748    0.04000    0.19031 ", # nolint output is long
    "ScaleOperator(YuleModelTreeRootScaler.t:anthus_aco_sub)    0.50000        887       4915    0.04000    0.15288 ", # nolint output is long
    "Uniform(YuleModelUniformOperator.t:anthus_aco_sub)               -      11869      46191    0.40000    0.20443 ", # nolint output is long
    "SubtreeSlide(YuleModelSubtreeSlide.t:anthus_aco_sub)       1.00000        128      28742    0.20000    0.00443 Try decreasing size to about 0.5", # nolint output is long
    "Exchange(YuleModelNarrow.t:anthus_aco_sub)                       -       3007      26046    0.20000    0.10350 ", # nolint output is long
    "Exchange(YuleModelWide.t:anthus_aco_sub)                         -        180       5641    0.04000    0.03092 ", # nolint output is long
    "WilsonBalding(YuleModelWilsonBalding.t:anthus_aco_sub)           -         92       5643    0.04000    0.01604 ", # nolint output is long
    "",
    "     Tuning: The value of the operator's tuning parameter, or '-' if the operator can't be optimized.", # nolint output is long
    "    #accept: The total number of times a proposal by this operator has been accepted.", # nolint output is long
    "    #reject: The total number of times a proposal by this operator has been rejected.", # nolint output is long
    "      Pr(m): The probability this operator is chosen in a step of the MCMC (i.e. the normalized weight).", # nolint output is long
    "  Pr(acc|m): The acceptance probability (#accept as a fraction of the total proposals for this operator).", # nolint output is long
    "",
    "",
    "Total calculation time: 0.823 seconds",
    "End likelihood: 12.388056869575024",
    "Producing posterior samples",
    "",
    "Marginal likelihood: -141.3000915386624 sqrt(H/N)=(NaN)=?=SD=(1.4593051179523482) Information: -0.19242514244311712", # nolint output is long
    "Max ESS: 5.659472090348357",
    "",
    "",
    "Processing 28 trees from file.",
    "Log file written to anthus_aco_sub.posterior.trees",
    "Done!",
    "",
    "Marginal likelihood: -141.31271098696405 sqrt(H/N)=(NaN)=?=SD=(1.462246661656647) Information: -0.1353639346412825", # nolint output is long
    "Max ESS: 5.4945059635784155",
    "",
    "",
    "Log file written to anthus_aco_sub.posterior.log",
    "Done!"
  )
}
