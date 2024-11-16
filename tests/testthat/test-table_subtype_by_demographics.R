test_that("`table_subtype_by_demographics()` produces consistent results",
          {
            patient_data = test_data_v1 |> filter(CGG >= 55, CGG < 200)
            table = test_subtype_and_stage_table
            set.seed(1)
            ft = table_subtype_by_demographics(patient_data, table,
                                               footnotes_as_letters = FALSE)

            html_file <- tempfile(fileext = ".html")
            if(ft |> inherits("gt_tbl"))
            {
            gt::gtsave(ft, filename = html_file)
            } else
            {
              ft = gtsummary::as_flex_table(ft)
              flextable::save_as_html(ft, path = html_file)
            }
            doconv::expect_snapshot_html(
              x = html_file,
              name = "table_subtype_by_demographics",
              engine = "testthat"
            )

          })
