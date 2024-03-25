#### collapse MRI variables into two groups ####
# Cerebellum + Pons
# Cerebral + everything else
create_mri_domains <- function(
    dataset,
    mri_variables = c(
      "Cerebral Atrophy", "Cerebellar Atrophy",
      "Cerebral WM Hyperintensity", "Cerebellar WM Hyperintensity",
      "MCP-WM Hyperintensity", "Pons-WM Hyperintensity",
      "Sub-Insular WM Hyperintensity", "Periventricular WM Hyperintensity",
      "Splenium (CC)-WM Hyperintensity", "Genu (CC)-WM Hyperintensity",
      "Corpus Callosum-Thickness"
    )
){
  # cerebellum variables
  cerebellum_vars <- c(
    "Cerebellar Atrophy", "Cerebellar WM Hyperintensity",
    "MCP-WM Hyperintensity"
  )
  # cereberal variables
  cerebral_vars <- c(
    "Cerebral Atrophy", "Cerebral WM Hyperintensity", "Pons-WM Hyperintensity",
    "Sub-Insular WM Hyperintensity", "Periventricular WM Hyperintensity",
    # "Splenium (CC)-WM Hyperintensity",
    # don't include Genu and Corpus as they are on different scales
    # "Genu (CC)-WM Hyperintensity",
    # "Corpus Callosum-Thickness"
  )

  dataset |>
    # convert to ordered factors
    mutate(
      across(
        .cols = c(all_of(cerebellum_vars), all_of(cerebral_vars)),
        ~ factor(.x, levels = c("None", "Mild", "Moderate", "Severe"),
                 ordered = TRUE)
      )
    ) |>
    # create Cerebral and Cerebellum domains
    mutate(
      `MRI: Cerebral` = pmax(!!!rlang::syms(cerebral_vars), na.rm = TRUE),
      `MRI: Cerebellum` = pmax(!!!rlang::syms(cerebellum_vars), na.rm = TRUE),
    )
}
