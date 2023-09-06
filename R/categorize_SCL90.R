categorize_SCL90 = function(
    dataset)
{

  dataset |>
    mutate(
      across(
        contains("SCL", ignore.case = FALSE) &
          !contains("missing"),
        .fn = function(x)
          if_else(
            x >= 60,
            "60+",
            "<60"),
        .names = "{.col}*")
    )

}
