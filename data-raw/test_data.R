test_data =
  trax_gp34_all |>
  select(-`Study ID Number`) |>
  mutate(
    `FXS ID` =
      `FXS ID` |>
      as.factor() |>
      as.numeric() |>
      as.character()
  )

# could have used https://github.com/EvgenyPetrovsky/scrambler here instead:
for (i in colnames(test_data))
{
  sample_rows = sample.int(nrow(test_data), replace = FALSE)
  test_data[i] = test_data[sample_rows, i]
}

usethis::use_data(test_data, overwrite = TRUE)

devtools::load_all()

test_data_v1 = test_data |>
  get_visit1()

test_data_v1 |> usethis::use_data(overwrite = TRUE)
