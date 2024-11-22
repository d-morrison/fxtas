#' Apply flextable settings to match Brain journal requirements
#'
#' @param x a [flextable::flextable]
#'
#' @returns a modified [flextable::flextable]
#' @export
#'
shared_flextable_settings = function(x)
{
  x |>
    flextable::padding(padding.top = 0,
                       padding.bottom = 0,
                       part = "all") |>
    flextable::fontsize(size = 8, part = "all") |>
    flextable::font(fontname = "Gill sans MT", part = 'all') |>
    flextable::height_all(height = 0.45, part = "all", unit = "cm") |>
    flextable::bold(part = "header")


}
