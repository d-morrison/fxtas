#' Add labels to biomarkers
#'
#' @param data a [data.frame] containing the relevant columns
#'
#' @returns a modified version of `data` with var labels added
#' @export
#'
#' @examples test_data |> add_labels()
add_labels <- function(data)
{
  data |>
    mutate(`FX3*` = `FX3*` |>
             labelled::set_label_attribute("CGG repeat level"),
           Parkinsons = Parkinsons |>
             labelled::set_label_attribute("Parkinson's disease"),
           `FXTAS Stage` = `FXTAS Stage` |>
             labelled::set_label_attribute("FXTAS Stage"),
           `Ataxia: severity*` = `Ataxia: severity*` |>
             labelled::set_label_attribute("Ataxia severity"),
           `MMSE total score*` = `MMSE total score*` |>
             labelled::set_label_attribute("MMSE total score"),
           `BDS-2 Total Score*` = `BDS-2 Total Score*` |>
             labelled::set_label_attribute("BDS-2 total score"),
           `BDS-2 Total Score` = `BDS-2 Total Score` |>
             labelled::set_label_attribute("BDS-2 total score"),
           `PAL Total errors (adjusted)*` = `PAL Total errors (adjusted)*` |>
             labelled::set_label_attribute("PAL total errors"),
           `SWM Between errors*` = `SWM Between errors*` |>
             labelled::set_label_attribute("SWM Between errors"),
           `RTI Five-choice movement time*` = `RTI Five-choice movement time*` |>
             labelled::set_label_attribute("RTI Five-choice movement time"),
             )
}
