#' replace decade codes with medians of those decades
#'
#' @param x a [character] vector
#'
#' @returns a [numeric] vector corresponding to `x`
#' @export
#'
age_range_medians <- function(x)
{
  case_when(
    # lifelong:
      x == "555" ~
        x |> as.numeric() |>
        suppressWarnings() |>
        c(10) |>
        min(na.rm = TRUE), # lifelong
      # x == "555" ~ 0, # lifelong (old solution)
      x == "444" ~ 5, # childhood
      x == "130" ~ 15, # teens
      x == "200" ~ 25, # 20s
      x == "300" ~ 35, # 30s
      x == "400" ~ 45, # 40s
      x == "500" ~ 55, # 50s
      x == "600" ~ 65, # 60s
      x == "700" ~ 75, # 70s
      x == "800" ~ 85, # 80s
      x == "900" ~ 95, # 90s,
      x %in% c(99, 777, 888, 999) ~ NA_real_,
      # x |> grepl(pattern = "\\d+\\-\\d+") ~
      #   x |> strsplit("-") |> sapply(FUN = function(x) median(as.numeric(x))),
      TRUE ~ x |> as.numeric() |> suppressWarnings()
    )
}
