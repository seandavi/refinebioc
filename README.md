---
title: The RefineBio Package
output:
    rmarkdown::html_document:
        keep_md: true
        df_print: tibble
---

# RefineBio

This package provides the bridge between Bioconductor and the vast, 
homogeneously-processed transcriptomic
data from [refine.bio](https://www.refine.bio).


Cite the refine.bio project as:

> Casey S. Greene, Dongbo Hu, Richard W. W. Jones, Stephanie Liu, David S. Mejia, Rob Patro, Stephen R. Piccolo, Ariel Rodriguez Romero, Hirak Sarkar, Candace L. Savonen, Jaclyn N. Taroni, William E. Vauclain, Deepashree Venkatesh Prasad, Kurt G. Wheeler. refine.bio: a resource of uniformly processed publicly available gene expression datasets. URL: https://www.refine.bio


## Status

This project is undergoing active development and not meant for general use.

## Installation


```r
install.packages('BiocManager')
BiocManager::install('seandavi/RefineBio')
```

## Usage

### Basic search


```r
library(RefineBio)
search_results = rb_search_list()
search_results$count
```

```
## [1] 62245
```

```r
head(search_results$results)
```

```
## # A tibble: 6 × 21
##      id title      publication_title    description    technology accession_code
##   <int> <chr>      <chr>                <chr>          <chr>      <chr>         
## 1 52090 Shared an… Shared and distinct… Neocortex con… RNA-SEQ    SRP150473     
## 2 51049 Transcrip… Conserved propertie… RNA sequencin… RNA-SEQ    SRP118985     
## 3 47744 In vivo m… Broadly neutralizin… Dengue virus … RNA-SEQ    SRP152576     
## 4 67685 Drug-indu… The NCI Transcripti… To identify p… MICROARRAY GSE116436     
## 5 50699 Single-ce… Classes and continu… We  studied  … RNA-SEQ    SRP109000     
## 6 51542 Single ce… Diversity of Intern… In order to i… RNA-SEQ    SRP124669     
## # … with 15 more variables: alternate_accession_code <chr>,
## #   submitter_institution <chr>, has_publication <lgl>, publication_doi <chr>,
## #   publication_authors <list>, sample_metadata_fields <list>,
## #   platform_names <list>, platform_accession_codes <list>,
## #   organism_names <list>, downloadable_organism_names <list>, pubmed_id <chr>,
## #   num_total_samples <int>, num_processed_samples <int>,
## #   num_downloadable_samples <int>, source_first_published <chr>
```

```r
lapply(search_results$facets,head)
```

```
## $has_publication
##   category  count
## 1    false 721263
## 2     true 251865
## 
## $downloadable_organism_names
##                  category  count
## 1            HOMO_SAPIENS 521539
## 2            MUS_MUSCULUS 292681
## 4       RATTUS_NORVEGICUS  39311
## 7             DANIO_RERIO  28598
## 3    ARABIDOPSIS_THALIANA  23999
## 5 DROSOPHILA_MELANOGASTER  17239
## 
## $platform_accession_codes
##             category  count
## 3        hgu133plus2 146159
## 2  IlluminaHiSeq2500 142474
## 1  IlluminaHiSeq2000 125755
## 4          mouse4302  59093
## 12           hgu133a  50743
## 5         NextSeq500  48894
## 
## $technology
##     category  count
## 1 microarray 609303
## 2    rna-seq 350551
## 3    unknown   1200
```

### Available Organisms


```r
orgs = rb_organisms_list()
head(orgs$results)
```

```
## # A tibble: 6 × 4
##   name                 taxonomy_id has_compendia has_quantfile_compendia
##   <chr>                      <int> <lgl>         <lgl>                  
## 1 CIONA_INTESTINALIS          7719 NA            NA                     
## 2 MUS_PAHARI                 10093 FALSE         TRUE                   
## 3 NOTAMACROPUS_EUGENII        9315 FALSE         TRUE                   
## 4 TAENIOPYGIA_GUTTATA        59729 NA            NA                     
## 5 PETROMYZON_MARINUS          7757 NA            NA                     
## 6 ANAS_PLATYRHYNCHOS          8839 NA            NA
```

### Available Platforms


```r
plats = rb_platforms_list()
head(plats)
```

```
## # A tibble: 6 × 2
##   platform_accession_code  platform_name                                        
##   <chr>                    <chr>                                                
## 1 IonTorrentS5             Ion Torrent S5                                       
## 2 ovigene10st              [OviGene-1_0-st] Ovine Gene 1.1 ST Array             
## 3 GPL4861                  Swegene Human 27K RAP (positions from file)          
## 4 Illumina_MouseRef-8_v2.0 Illumina MouseRef-8 v2.0 expression beadchip (ILMN_S…
## 5 GPL16365                 Candida albicans tiling ChIP array                   
## 6 GPL16275                 Agilent-035430 mouse miRNA array (miRNA_107_Sep09 mi…
```

```r
dim(plats)
```

```
## [1] 504   2
```


## For developers: the low level API 


```r
library(RefineBio)
client = rb_get_client()
ops = rapiclient::get_operations(client)
names(ops)
```

```
##  [1] "compendia_list"                 "compendia_read"                
##  [3] "computational_results_list"     "computational_results_read"    
##  [5] "computed_files_list"            "computed_files_read"           
##  [7] "dataset_create"                 "dataset_read"                  
##  [9] "dataset_update"                 "experiments_list"              
## [11] "experiments_read"               "institutions_list"             
## [13] "jobs_downloader_list"           "jobs_downloader_read"          
## [15] "jobs_processor_list"            "jobs_processor_read"           
## [17] "jobs_survey_list"               "jobs_survey_read"              
## [19] "organisms_list"                 "organisms_read"                
## [21] "original_files_list"            "original_files_read"           
## [23] "platforms_list"                 "processors_list"               
## [25] "processors_read"                "qn_targets_list"               
## [27] "qn_targets_read"                "samples_list"                  
## [29] "samples_read"                   "search_list"                   
## [31] "stats-about_list"               "stats_list"                    
## [33] "stats_failures_downloader_list" "stats_failures_processor_list" 
## [35] "token_create"                   "token_read"                    
## [37] "token_update"                   "transcriptome_indices_list"    
## [39] "transcriptome_indices_read"
```

```r
print(ops$qn_targets_read)
```

```
## qn_targets_read 
##  
## Description:
##   Get a detailed view of the Quantile Normalization file for an
##   organism.
## 
## Parameters:
##   organism_name (string)
##     Eg `DANIO_RERIO`, `MUS_MUSCULUS`
```

# Roadmap

- [x] Basic API endpoints
  - [x] Automated mapping to R objects
  - [ ] s3 classes and methods for R response objects (subclass of list, basically)
- [x] Low-level [rapiclient-based](https://github.com/bergant/rapiclient) client
- [x] R documentation templated from openapi docs
- [x] Response handling for list and data.frame response
- [ ] Token handling to allow downloads
- [ ] File download capability
- [ ] Metadata with file downloads
- [ ] Import of data into R/Biocondutor objects
- [ ] Vignettes
  - [ ] R-based API
  - [ ] rapiclient-based API
  - [ ] common workflows
