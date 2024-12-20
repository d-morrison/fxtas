#' Search PubMed for FXTAS-related articles
#'
#' @param query a [character] string
#'
#' @returns a [tibble::tbl_df]
#' @export
#'
#' @examples search_articles("FXTAS")
search_articles <- function(query) {
  # First, get the total number of results
  search_results <- entrez_search(
    db = "pubmed",
    term = query,
    use_history = TRUE, # Use Web History to handle large queries
    retmax = 0
  ) # Retrieve only the count
  total_results <- search_results$count
  web_history <- search_results$web_history
  cli::cli_inform("Total results: {total_results}")
  should_continue = readline("Continue? y/n") %in% c("Y", "y", "yes")
  if (!should_continue) return(NULL)

  # Initialize an empty list to store IDs
  all_ids <- c()

  # Retrieve IDs in batches (PubMed allows a maximum of 100 per request)
  batch_size <- 100
  cli::cli_inform("getting ids")
  for (start in seq(1, total_results, by = batch_size)) {
    cli::cli_inform("running {start}-{start+batch_size} out of {total_results}")
    batch_results <- entrez_search(db = "pubmed",
                                   term = query,
                                   retstart = start - 1,
                                   retmax = batch_size)
    all_ids <- c(all_ids, batch_results$ids)
  }


  # Initialize an empty list to store article summaries
  article_summaries <- list()

  # Fetch summaries for all IDs
  batch_size <- 100
  cli::cli_inform("getting summaries")
  for (start in seq(1, total_results, by = batch_size)) {
    cli::cli_inform("running {start}-{start+batch_size} out of {total_results}")
    batch_summaries <- entrez_summary(
      db = "pubmed",
      web_history = web_history,
      retstart = start - 1,
      retmax = batch_size
    )
    article_summaries <- c(article_summaries, batch_summaries)
  }


  tibble::tibble(
    Journal = sapply(article_summaries, function(x) x$fulljournalname),
    Year = article_summaries |>
      sapply(get_pubdate),
    Title = sapply(article_summaries, function(x) x$title)
  )
}

get_pubdate = function(x) {
  x$pubdate |> substr(1,4) |> as.integer()
}
