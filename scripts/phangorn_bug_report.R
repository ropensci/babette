phylogeny_1 <- ape::read.tree(text = "((A:2, B:2):1, C:3);")
phylogeny_2 <- ape::read.tree(text = "((A:1, B:1):2, C:3);")
ape::plot.phylo(phylogeny_1)
ape::plot.phylo(phylogeny_2)
trees <- c(phylogeny_1, phylogeny_2)

# Fails, with error 'Error in temp[[j + 1]] : subscript out of bounds'
phangorn::densiTree(trees)

# Works fine
library(ggtree)
ggtree(trees, alpha = 0.5) + geom_tiplab() +
  geom_treescale()

trees <- c(ape::rcoal(n = 10))
for (i in seq(1, 100)) {
  trees <- c(trees, ape::rcoal(n = 10))
}
ggtree(trees, alpha = 0.01) + geom_tiplab() +
  geom_treescale()
