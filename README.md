
# Part 1: Molecular evolution (2 points)

 This following function computes the Jukes-Cantor distance, given the observed proportion of differences between two sequences: 

```R
#' @param D Proportion of sites that differ 
#' between two sequences. Computed as the Levenshtein 
#' distance divided by the length of the sequence, 
#' @returns d Jukes-Cantor distance between the sequences
jcdist = function(D) { -3/4 * log(1-(4/3)*D) }
```

You can see how the jukes-cantor distance is related to the number of observed differences by plotting a curve like this:

```R
D = seq(0, 0.75, by=0.01)
plot(D, jcdist(D), type="l", xlab="Observed proportion of differences", ylab="Jukes-Cantor d")
```

Your job is to explore the K2P model. Write a function to compute sequence divergence using the K2P model of sequence evolution, as a function of the transition (S) and transversion (V) proportions.

```R
k2pdist = function(S, V) { ... your code here ... }
```

Now, for a fixed D (say, `D=0.25`, or choose your own), plot a line to show how the the k2p distance varies with the transition:transversions ratio (`S/V`). (Remember, `S+V=D` by definition.)


---

# Part 2: Basic phylogenetics (6 points)

The `primate_mtdna.fasta` file contains the complete mitochondrial genome sequence for 6 primate species. Our goal in this task is to use these sequences to build three trees: first, a UPGMA tree, using a function you will implement yourself; second, a NJ tree using the `ape` package; and finally, a maximum likelihood tree using the `iqtree` package.

2.1 Prepare the data (1 point)
- The FASTA file sequences are not aligned. The first thing we have to do is align the sequences, so we have a statement of homologous nucleotides; then we can compute sequence divergence. Download MAFFT and use it to align the sequences with default settings. Use the unix `time` command to measure how long your alignment takes to run. How long did the alignment take?

- Load the aligned sequences into R using the `Biostrings` package. How many columns are there in the multiple alignment?

2.2. Build and compare distance-based trees (3 points)
- Use the following code to use the `Biostrings` package to compute pairwise levenshtein distances. Then, build 2 trees: First, a UPGMA tree, built using the `BuildUPGMATree` function that you should implement. Next, a NJ tree, built using the `ape::nj` function (see below code).

```R
msa = Biostrings::readDNAMultipleAlignment("primate_mtdna_aligned.fasta", "fasta")
D = Biostrings::stringDist(as(msa, "DNAStringSet"))

# Builds a UPGMA tree, given a distance matrix
# Ignore branch lengths.
# D = levenshtein distance matrix
BuildUPGMATree = function (D) {

	newick = ...
	return(newick)  # Return the tree in newick format
}
```

Build the two trees and plot them:

```R
upgmaTree = BuildUPGMATree(D)
njTree = ape::nj(D)
plot(read.tree(text=upgmaTree))
plot(njTree)
```

2.3. Use your alignment to build a maximum likelihood tree using `iqtree`. Load the resulting tree into R and plot the ML tree as above. (1 point)

2.4 Compare the trees. How are they similar and different, in terms of topologies, branch lengths, and rootedness? Do your mtDNA trees support the modern view that chimpanzees are more similar to humans than to other apes, or the older view that the apes form a monophyletic clade separate from humans? (1 point) 

---

# Part 3: Phylogenetics on an HPC (2 points)

In this section, we'll ramp up to a much larger phylogeny that will require running on the HPC. Use the '16s.fasta' dataset.

3.1 Write a SLURM script to 1. align these sequences with mafft, then 2. use iqtree to find the most likely tree. Use 4 cores and 16 GB of memory, using the 'cobi' partition. Submit this job to rivanna. When you job completes, visualize your completed tree using the approach described above. (1 point)

3.2 Why might it make sense to use mtDNA for a phylogeny of primates, but 16S for a phylogeny of bacteria and archaea?
