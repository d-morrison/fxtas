clean_kinesia = function(
    data,
    kinesia_vars = c(
      "Left: Rest Tremor",
      "Left: Postural Tremor",
      "Left: Kinetic Tremor",
      "Right: Rest Tremor",
      "Right: Postural Tremor",
      "Right: Kinetic Tremor"
    ))
{
  data |>
    mutate(
    across(
      all_of(kinesia_vars),
      .fns =
        ~ cut(.x,
              breaks = c(0,1,2,3,4),
              include.lowest = TRUE,
              right = TRUE,
              labels = c("<=1", ">1", ">2", ">3")
              ),
      .names = "{.col}*"
    )
  )
}
