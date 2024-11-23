format_age_range_codes <- function(dataset)
{

  dataset |>
    forcats::fct_relevel(
      "555",
      "444",
      "130",
      "200",
      "300",
      "400",
      "500",
      "600",
      "700",
      "800",
      "900",
      after = Inf) |>
    forcats::fct_recode(
      "lifelong (555)" = "555",
      "childhood (444)" = "444",
      "teens (130)" = "130",
      "20s" = "200",
      "30s" = "300",
      "40s" = "400",
      "50s" = "500",
      "60s" = "600",
      "70s" = "700",
      "80s" = "800",
      "90s" = "900",
    )

}
