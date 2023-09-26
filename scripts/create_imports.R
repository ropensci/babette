#!/bin/env Rscript
###############################################################################
# beautier
###############################################################################
library(beautier)

pattern <- "^(add|are|beastier_report|calc|check|compare|continue|count|create|extract|fasta|find|get|gives|has|indent|install|is|parse|print|remove|rename|run|save|unindent|uninstall)" # nolint indeed a long line

all_beautier_function_names <- ls("package:beautier")
beautier_function_names <- stringr::str_subset(
  all_beautier_function_names,
  pattern = pattern
)
beautier_text <- paste("#' @importFrom beautier", beautier_function_names)
beautier_text

###############################################################################
# tracerer
###############################################################################
library(tracerer)

all_tracerer_function_names <- ls("package:tracerer")
tracerer_function_names <- stringr::str_subset(
  all_tracerer_function_names,
  pattern = pattern
)
tracerer_text <- paste("#' @importFrom tracerer", tracerer_function_names)
tracerer_text

###############################################################################
# beastier
###############################################################################
library(beastier)
all_beastier_function_names <- ls("package:beastier")
beastier_function_names <- stringr::str_subset(
  all_beastier_function_names,
  pattern = pattern
)
beastier_function_names <- stringr::str_subset(
  beastier_function_names,
  "remove_beautier_folder|create_beautier_tempfolder|is_on_appveyor|is_on_ci|is_on_travis",
  negate = TRUE
)
beastier_text <- paste("#' @importFrom beastier", beastier_function_names)
beastier_text

###############################################################################
# mauricer
###############################################################################
library(mauricer)
all_mauricer_function_names <- ls("package:mauricer")
mauricer_function_names <- stringr::str_subset(
  all_mauricer_function_names,
  pattern = pattern
)
mauricer_text <- paste("#' @importFrom mauricer", mauricer_function_names)
mauricer_text


###############################################################################
# combine
###############################################################################
texts <- c(beautier_text, tracerer_text, beastier_text, mauricer_text)
writeLines(texts, con = "~/import.txt")
