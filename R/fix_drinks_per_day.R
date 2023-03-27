fix_drinks_per_day = function(dataset)
{

  dataset |>
    mutate(
      `# of drinks per day now: missingness` =
        missingness_reasons(`# of drinks per day now`),

      `# of drinks per day now` =
        if_else(
          `# of drinks per day now` == -2,
          0,
          `# of drinks per day now`) |>
        clean_numeric(),

      `# of drinks per day now` =
        if_else(
          Study == "GP3" &
            is.na(`# of drinks per day now`) &
            `Alcohol use/abuse` %in% c("Past Only", "None"),
          0,
          `# of drinks per day now`
        )
    )
}
