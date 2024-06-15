#!/bin/env Rscript
#
# Find function that are not completely documented
#
# Usage:
#
#   ./find_functions_with_missing_rd_tags
#   ./find_functions_with_missing_rd_tags [package_name]
#
# Examples:
#
#   ./find_functions_with_missing_rd_tags
#   ./find_functions_with_missing_rd_tags babette
#
# From https://stat.ethz.ch/pipermail/r-package-devel/2021q2/007106.html

library(tools)

pkg_of_interest <- "babette"

args <- commandArgs(trailingOnly = TRUE)
if (length(args) == 1) pkg_of_interest <- args[1]
print(paste("Find functions in package", pkg_of_interest))

db <- Rd_db(pkg_of_interest)

name <- lapply(db, tools:::.Rd_get_metadata, "name")
alias <- lapply(db, tools:::.Rd_get_metadata, "alias")
value <- lapply(db, tools:::.Rd_get_metadata, "value")

n_aliases <- lengths(alias)
df <- data.frame(
    file_name = rep(names(db), n_aliases),
    name = rep(unlist(name, use.names = FALSE), n_aliases),
    alias = unlist(alias, use.names = FALSE),
    has_value = rep(lengths(value) > 0, n_aliases)
)

# Create subsets of the database, and find the aliases that have no values. 
# This is trying to allow for the possibility that an alias occurs in more than 
# one help file (is this allowed?)

alias_with_value <- subset(df, has_value)
alias_without_value <- subset(df, !has_value)    
no_value <- subset(alias_without_value, !alias %in% alias_with_value$alias)

# Find all the exports in the package, and subset the help pages to just those.

exports <- getNamespaceExports(pkg_of_interest)
subset(no_value, alias %in% exports)
