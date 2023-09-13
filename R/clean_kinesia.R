clean_kinesia = function(
    data,
    kinesia_vars = c(
      "Kinesia Left Rest Tremor",
      "Kinesia Left Postural Tremor",
      "Kinesia Left Kinetic Tremor",
      "Kinesia Right Rest Tremor",
      "Kinesia Right Postural Tremor",
      "Kinesia Right Kinetic Tremor"
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
              labels = c("0-1", "1-2", "2-3", "3-4")
              ),
      .names = "{.col}*"
    )
  )
}
