# import updated ApoE data
apoe <- readxl::read_xlsx(
  "inst/extdata/GP3 & GP4 -ApoE_ GP_Missing Data Table- 10-02-2023-mdp.xlsx"
)


apoe = tibble(apoe)
usethis::use_data(apoe, overwrite = TRUE)
