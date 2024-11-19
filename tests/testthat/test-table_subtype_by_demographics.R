test_that("`table_subtype_by_demographics()` produces consistent results",
          {
            library(dplyr)
            patient_data = sim_data |> filter(Category == "Patient")
            table = sim_subtype_and_stage_table
            set.seed(1)
            ft = table_subtype_by_demographics(patient_data,
                                               table,
                                               demographic_vars = "Sex",
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
