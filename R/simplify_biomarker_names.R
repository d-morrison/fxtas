simplify_biomarker_names = function(dataset, cols = "event name")
{
  dataset |>
    mutate(across(
      .cols = all_of(cols),
      .fns = ~ .x |>
        simplify_pf_names() |>
        update_any_autoimmune_name()
    ))
}

simplify_pf_names = function(names)
{
  names |>
    stringr::str_replace(
      pattern = stringr::fixed("Parkinsonian features: "),
      replacement = ""
  )
}

update_any_autoimmune_name = function(names)
{
  names |>
    stringr::str_replace(pattern = "Any Autoimmune", replacement = "Any autoimmune disorder") |>
    stringr::str_replace(pattern = ": Some autoimmune recorded", replacement = "")
}

