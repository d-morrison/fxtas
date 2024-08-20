parse_CGG = function(x)
{
  x |>
    strsplit(" *(\\)|-|,| ) *\\(?") |>
    sapply(F = function(x) gsub(x = x, fixed = TRUE, "?*", "")) |>
    sapply(F = function(x) gsub(x = x, fixed = TRUE, ">", "")) |>
    sapply(F = as.numeric) |>
    suppressWarnings() |>
    sapply(F = max)
}
