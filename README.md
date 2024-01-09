
# RefineBio

This package provides the bridge between Bioconductor and the vast,
homogeneously-processed transcriptomic data from
[refine.bio](https://www.refine.bio).

Cite the refine.bio project as:

> Casey S. Greene, Dongbo Hu, Richard W. W. Jones, Stephanie Liu, David
> S. Mejia, Rob Patro, Stephen R. Piccolo, Ariel Rodriguez Romero, Hirak
> Sarkar, Candace L. Savonen, Jaclyn N. Taroni, William E. Vauclain,
> Deepashree Venkatesh Prasad, Kurt G. Wheeler. refine.bio: a resource
> of uniformly processed publicly available gene expression datasets.
> URL: <https://www.refine.bio>

## Status

This project is undergoing active development and not meant for general
use.

## Installation

``` r
install.packages("BiocManager")
BiocManager::install("seandavi/RefineBio")
```

## Usage

### Basic search

``` r
library(RefineBio)
search_results <- rb_search_list()
search_results$count
head(search_results$results)
lapply(search_results$facets, head)
```

### Available Organisms

``` r
orgs <- rb_organisms_list()
head(orgs$results)
```

### Available Platforms

``` r
plats <- rb_platforms_list()
head(plats)
dim(plats)
```

## Developer checklist

- [ ] Add tests
- [ ] Run `devtools::test()`
- [ ] Run `devtools::check()`
- [ ] Run `devtools::document()`
- [ ] Run `devtools::build()`
- [ ] Update `READMERmd`
- [ ] Run `devtools::build_readme()`
- [ ] Update `NEWS.md`
- [ ] Update `DESCRIPTION`

### Notes

- We use [`roxygen2`](https://roxygen2.r-lib.org/) for documentation,
  including for [R6
  classes](https://github.com/mlr-org/mlr3/wiki/Roxygen-R6-Guide)
- We use [`testthat`](https://testthat.r-lib.org/) for testing
- We use the [tidyverse style for the NEWS.md
  file](https://style.tidyverse.org/news.html)
