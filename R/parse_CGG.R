parse_CGG = function(x)
{
  x |>
    strsplit(" *(\\)|-|,| ) *\\(?") |>
    sapply(FUN = function(x) gsub(x = x, fixed = TRUE, "?*", "")) |>
    sapply(FUN = function(x) gsub(x = x, fixed = TRUE, ">", "")) |>
    sapply(FUN = as.numeric) |>
    suppressWarnings() |>
    sapply(FUN = max)
}
