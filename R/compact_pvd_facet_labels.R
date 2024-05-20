#' Create facet labels
#'

compact_pvd_facet_labels <- function(
  figs = list(),
  facet_label = NULL
){

  # extract fig titles
  if(length(figs) == 1){
    # facet names
    tmp <- as.list(figs[[1]]$labels$title)
  }

  if(length(figs) > 1){
    # facet names
    tmp <- lapply(
      1:length(figs),
      function(x) figs[[x]]$labels$title
    )
  }

  # update facet names with provided prefix
  if(!is.null(facet_label)){
    # check that facet label is same length as figs
    if(length(figs) != length(facet_label)){
      stop("`facet_label` must be the same length as `figs`.")
    }
    facet_names <- glue::glue("{facet_label} {tmp}")
  } else{
    facet_names <- tmp
  }

  names(facet_names) <- paste0(1:length(facet_names))

  return(facet_names)
}
