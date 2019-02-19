# Creates the figures for the rOpenSci blog post
# E.g. https://github.com/ropensci/roweb2/pull/415

setwd("/home/richel/GitHubs/roweb2/themes/ropensci/static/img/blog-images/2019-01-06-babette")

library(babette)

phylogeny <- ape::read.tree(text = "(((1:1,2:1):1, 3:2):1, 4:3);")

png(filename = "phylogeny.png", width = 400, height = 300)
ape::plot.phylo(phylogeny, cex = 2.0, edge.width = 2.0)
dev.off()

fasta_filename <- "alignment.fasta"

# Simulate an alignment
pirouette::sim_alignment_file(
  phylogeny = phylogeny,
  alignment_params = pirouette::create_alignment_params(
    root_sequence = pirouette::create_blocked_dna(length = 40),
    mutation_rate = 0.5 * 1.0 / 3.0
  ),
  fasta_filename = fasta_filename
)

png(filename = "alignment.png", width = 800, height = 300)
ape::image.DNAbin(ape::read.FASTA(
  file = fasta_filename),
  grid = TRUE,
  show.bases = FALSE,
  legend = FALSE,
  cex.lab = 2.0,
  cex.axis = 2.0
)
dev.off()

output <- babette::bbt_run(fasta_filename = fasta_filename, overwrite = TRUE)

png(filename = "densitree.png", width = 1000, height = 800)
babette::plot_densitree(
  output$alignment_trees, library = "phangorn",
  alpha = 0.01,
  consensus = as.character(c(1:4)),
  cex = 2.0,
  scaleX = TRUE,
  scale.bar = FALSE
)
dev.off()

babette::plot_densitree(posterior_trees[501:1001], width = 1, alpha = 0.01)
