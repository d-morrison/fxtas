# import updated ApoE data
apoe <- readxl::read_xlsx(
  "inst/extdata/GP3 & GP4 -ApoE_ GP_Missing Data Table- 10-02-2023-mdp.xlsx"
)

apoe <- apoe |>
  # order of ApoE doesn't matter (e.g. E3/E4 is same as E4/E3). make consistent
  mutate(
    `ApoE (backfilled)` =
      `ApoE (backfilled)` |>
      strsplit(", ") |>
      sapply(sort) |>
      sapply(paste, collapse = ", ") |>
      na_if(""),

    `ApoE (backfilled)` = factor(`ApoE (backfilled)`,
                                 levels = sort(unique(`ApoE (backfilled)`)))
  )

apoe = tibble(apoe)
usethis::use_data(apoe, overwrite = TRUE)
