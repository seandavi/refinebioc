#   This set of functions will build a list of Summarized Experiments when given
#   a main path folder from the RefineBio download.


#   download_loader: main function to build SE list
download_loader <- function(filepath){

    x = list.dirs(filepath)
    ses = lapply(x[2:length(x)], loader)

    #   Adjust experiment names
    names(ses) = lapply(seq_along(ses), function(i)
        {ses[[i]]$experiment_accession[1]})

    #   Load in metadata
    y = metadata_loader(x[1])
    for (i in 1:length(ses)) {
        metadata(ses[[i]]) = metadata_trimmer(i, y)
    }

    return(ses)

}

#   loader: Load in raw data from tsv files
loader <- function(filepath){

    fnames = list.files(filepath)

    #   Checking for identity of the two tsv files
    if (isTRUE(grepl("metadata", fnames)[2])) {
        x = read_tsv( file.path(filepath, fnames[1]))
        y = read_tsv( file.path(filepath, fnames[2]))
    } else {
        y = read_tsv( file.path(filepath, fnames[1]))
        x = read_tsv( file.path(filepath, fnames[2]))
    }

    if (identical(colnames(x[,2:ncol(x)]), y$refinebio_accession_code)) {
        counts = x[,2:ncol(x)]
        rowData = x$Gene
        colData = y

        return(SummarizedExperiment( assays = list(counts), rowData = rowData,
                                     colData = colData))
    } else {
        print("Sample names do not match")
    }

}

#   metadata_loader: Read aggregated metadata json file
metadata_loader <- function(filepath){

    return(jsonlite::read_json(file.path(filepath, "aggregated_metadata.json")))

}

#   metadata_trimmer: Remove experiments from the metadata that are not
#   associated with a particular SE
metadata_trimmer <- function(index, metadat){

    x = lapply(seq_along(metadat$experiments), function(i){if(i == index)
        {metadat$experiments[[i]]}})
    x = x[-which(sapply(x, is.null))]
    names(x) = names(metadat$experiments[index])

    metadat$experiments = NULL
    y = append(metadat, list(experiments = x))

    return(y)
}

