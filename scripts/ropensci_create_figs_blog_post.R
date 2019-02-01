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


# babette::plot_densitree(posterior_trees[501:1001], library = "phangorn", width = 1, alpha = 0.01)

if (1 == 2) {
  phangorn::densiTree(posterior_trees)
  babette::plot_densitree(posterior_trees[901:1001])
  plot <- ggtree::ggtree(posterior_trees[901:1001], layout = "slanted", alpha = 1.0) +
    ggtree::geom_tiplab() +
    ggtree::geom_treescale()
  plot
  plot + ggtree::ggsave("phylogenies.png")
}

if (1 == 2) {
  library(ape)
  devtools::install_github("richelbilderbeek/phangorn")
  tree_1 <- ape::read.tree(text = "((A:2,B:2):1, C:3);")
  tree_2 <- ape::read.tree(text = "((A:1,C:1):2, B:3);")
  trees <- c(tree_1, tree_2)
  phangorn::densiTree(trees)
}

if (1 == 2) {
  library(ape)
  devtools::install_github("KlausVigo/phangorn", branch = "devel")
  tree_1 <- ape::read.tree(text = "((A:2,B:2):1, C:3);")
  tree_2 <- ape::read.tree(text = "((A:1,C:1):2, B:3);")
  trees <- c(tree_1, tree_2)
  phangorn::densiTree(trees, consensus = LETTERS[1:3])
  phangorn::densiTree(trees)
}

# Suggestion from Brad Jones
if (1 == 2) {
  devtools::install_github("brj1/ggtree")
  tree_1 <- ape::read.tree(text = "((A:2,B:2):1, C:3);")
  tree_2 <- ape::read.tree(text = "((A:1,C:1):2, B:3);")
  plot(tree_1)
  plot(tree_2)
  trees <- c(tree_1, tree_2)
  library(ggtree)
  p <- ggdensitree(tree, layout="slanted", branch.length='none', color="lightblue", alpha=.3,) + geom_tiplab(cex=1)
}



ggtree::ggtree(trees, layout = "slanted", alpha = 1.0) +
  ggtree::geom_tiplab() +
  ggtree::geom_treescale()


# Other
sort_tips <- function(x) {
    x <- reorder(x)
    nTip <- as.integer(length(x$tip.label))
    e2 <- x$edge[, 2]
    x$tip.label <- x$tip.label[e2[e2 <= nTip]]
    x$edge[e2 <= nTip, 2] <- as.integer(1L:nTip)
    x
}
tree_1 <- ape::read.tree(text = "((A:2,B:2):1, C:3);")
tree_2 <- ape::read.tree(text = "((A:2,C:2):1, B:3);")
tree_1 <- sort_tips(tree_1)
tree_2 <- sort_tips(tree_2)
ape::plot.phylo(tree_1)
ape::plot.phylo(tree_2)
trees <- c(tree_1, tree_2)
ggtree::ggtree(trees, layout = "slanted", alpha = 1.0) +
  ggtree::geom_tiplab() +
  ggtree::geom_treescale()



# Create posterior
posterior <- babette::bbt_run(
  fasta_filename = fasta_filename,
  mcmc = create_mcmc(chain_length = 1000000),
  mrca_prior = create_mrca_prior(
    alignment_id = get_alignment_id(fasta_filename = fasta_filename),
    taxa_names = get_taxa_names(filename = fasta_filename),
    mrca_distr = create_normal_distr(mean = 10.0, sigma = 0.01)
  )
)

ggtree::ggtree(posterior[[1]][900:1001], layout = "slanted", alpha = 0.1) +
  ggtree::geom_tiplab() +
  ggtree::geom_treescale() + ggtree::ggsave("phylogenies.png")
