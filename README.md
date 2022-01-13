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
search_results = rb_search_list()
search_results$count
head(search_results$results)
lapply(search_results$facets,head)
```

## Available Organisms

```{r}
orgs = rb_organisms_list()
head(orgs$results)
```

## Available Platforms

```{r}
plats = rb_platforms_list()
head(plats$results)
plats$count
```


# For developers: the low level API 

```{r}
library(RefineBio)
client = rb_get_client()
ops = rapiclient::get_operations(client)
names(ops)
print(ops$qn_targets_read)
```

