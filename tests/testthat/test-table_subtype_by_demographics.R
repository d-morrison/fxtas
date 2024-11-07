test_that("`table_subtype_by_demographics()` produces consistent results",
          {
            patient_data = test_data_v1 |> filter(CGG >= 55, CGG < 200)
            table = test_subtype_and_stage_table
            set.seed(1)
            table_subtype_by_demographics(patient_data, table) |>
              print(print_engine = "gt") |>
              expect_snapshot()

          })
