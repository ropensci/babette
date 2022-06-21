
library(beautier)

all_beautier_function_names <- ls("package:beautier")
beautier_function_names <- stringr::str_subset(
  all_beautier_function_names,
  "^(are|check|compare|count|create|extract|fasta|find|get|has|indent|is|remove|rename|unindent)" # nolint indeed a long line
)
beautier_text <- paste("#' @importFrom beautier",beautier_function_names)
beautier_text

library(beastier)
all_beastier_function_names <- ls("package:beastier")
beastier_function_names <- stringr::str_subset(
  all_beastier_function_names,
  "^(add|are|beastier_report|check|continue|create|extract|get|gives|has|install|is|print|remove|rename|run|save|uninstall)" # nolint indeed a long line
)
beastier_function_names <- stringr::str_subset(
  beastier_function_names,
  "remove_beautier_folder|create_beautier_tempfolder",
  negate = TRUE
)
beastier_text <- paste("#' @importFrom beastier", beastier_function_names)
beastier_text

texts <- c(beautier_text, beastier_text)
writeLines(texts, con = "~/import.txt")
