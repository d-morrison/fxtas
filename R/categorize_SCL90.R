categorize_SCL90 <- function(dataset) {
  to_return <-
    dataset |>
    dplyr::mutate(across(
      contains("SCL", ignore.case = FALSE) &
        !contains("missing"),
      .fn = function(x) {
        if_else(x >= 60, "60+", "<60") |>
          factor() |>
          relevel(ref = "<60")
      },
      .names = "{.col}*"
    ))

  to_return

}
