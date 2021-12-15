# RefineBio

This package bridges the vast, homogeneously-processed transcriptomic
data from [refine.bio](https://www.refine.bio) to Bioconductor.


Cite the refine.bio project as:

```
Casey S. Greene, Dongbo Hu, Richard W. W. Jones, Stephanie Liu, David S. Mejia, Rob Patro, Stephen R. Piccolo, Ariel Rodriguez Romero, Hirak Sarkar, Candace L. Savonen, Jaclyn N. Taroni, William E. Vauclain, Deepashree Venkatesh Prasad, Kurt G. Wheeler. refine.bio: a resource of uniformly processed publicly available gene expression datasets.
URL: https://www.refine.bio
```

# Status

This project is undergoing active development and not meant for general use.

# Installation

```{r}
install.packages('BiocManager')
BiocManager::install('seandavi/RefineBio')
```

# Usage

## Basic search

```{r}
library(RefineBio)
client = RefineBio::RefineBio()
search_results = rb_search(client)
search_results$count
head(search_results$results)
lapply(search_results$facets,head)
```


## For developers: the low level API 

```{r}
library(RefineBio)
client = RefineBio()
ops = rapiclient::get_operations(client)
names(ops)
```
