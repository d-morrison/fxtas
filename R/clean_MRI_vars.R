clean_MRI_vars <- function(dataset,
                           MRI_vars = c(
                             "Cerebral Atrophy",
                             "Cerebellar Atrophy",
                             "Cerebral WM Hyperintensity",
                             "Cerebellar WM Hyperintensity",
                             "MCP-WM Hyperintensity",
                             "Pons-WM Hyperintensity",
                             "Sub-Insular WM Hyperintensity",
                             "Periventricular WM Hyperintensity",
                             "Splenium (CC)-WM Hyperintensity",
                             "Genu (CC)-WM Hyperintensity",
                             "Corpus Callosum-Thickness"
                           ),
                           missing_codes = c("Missing/Refused (999)",
                                             "999",
                                             "Missing/Refused")) {
  dataset |>
    dplyr::mutate(across(
      .cols = all_of(MRI_vars),
      .fns = function(x) {
        if_else(x %in% missing_codes, NA, x) |>
          droplevels()
      }
    ))
}
