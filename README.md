
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

### Available Experiments

``` r
library(RefineBio)
experiments <- experiment_listing(.pages = 2)
head(experiments)
```

    ## # A tibble: 6 × 21
    ##      id title            publication_title description technology accession_code
    ##   <int> <chr>            <chr>             <chr>       <chr>      <chr>         
    ## 1 52090 Shared and dist… Shared and disti… Neocortex … RNA-SEQ    SRP150473     
    ## 2 51049 Transcriptome a… Conserved proper… RNA sequen… RNA-SEQ    SRP118985     
    ## 3 47744 In vivo molecul… Broadly neutrali… Dengue vir… RNA-SEQ    SRP152576     
    ## 4 67685 Drug-induced ch… The NCI Transcri… To identif… MICROARRAY GSE116436     
    ## 5 50699 Single-cell tra… Classes and cont… We  studie… RNA-SEQ    SRP109000     
    ## 6 51542 Single cell RNA… Diversity of Int… In order t… RNA-SEQ    SRP124669     
    ## # ℹ 15 more variables: alternate_accession_code <chr>,
    ## #   submitter_institution <chr>, has_publication <lgl>, publication_doi <chr>,
    ## #   publication_authors <list>, sample_metadata_fields <list>,
    ## #   platform_names <list>, platform_accession_codes <list>,
    ## #   organism_names <list>, downloadable_organism_names <list>, pubmed_id <chr>,
    ## #   num_total_samples <int>, num_processed_samples <int>,
    ## #   num_downloadable_samples <int>, source_first_published <date>

### Get an Experiment

``` r
dset <- rb_dataset_request("GSE1133")
rb_dataset_ensure_started(dset)
rb_wait_for_dataset(dset)
rb_dataset_download(dset)
rb_dataset_extract(dset)
gselist <- rb_dataset_load(dset)
```

And the dataset:

``` r
gselist
```

    $GSE1133
    class: SummarizedExperiment 
    dim: 11868 158 
    metadata(13): accession_code description ... technology title
    assays(1): exprs
    rownames: NULL
    rowData names(1): Gene
    colnames(158): GSM18865 GSM18866 ... GSM19021 GSM19022
    colData names(57): refinebio_accession_code experiment_accession ... title type

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
