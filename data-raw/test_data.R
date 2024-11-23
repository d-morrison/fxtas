load_all()
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

# every time we run this, test_data will change,
# because we didn't set the RNG seed:

# test =
#   waldo::compare(y = test_data,
#                  x = fxtas::test_data,
#                  ignore_attr = "problems") |>
#   print()
#
# if (length(test) > 0) {
#   browser("are you sure you want to overwrite?")
# }

usethis::use_data(test_data, overwrite = TRUE)

devtools::load_all()

test_data_v1 = test_data |>
  get_visit1()

test_data_v1 |> usethis::use_data(overwrite = TRUE)
