load_all()
library(Hmisc)
conflict_prefer("label", "Hmisc")
library(tidyr)
# dupes = gp3 |> semi_join(gp4, by = c("subj_id", "redcap_event_name"))
# if(nrow(dupes) != 0) browser(message("why are there duplicate records?"))

shared = intersect(names(gp3), names(gp4))

# checking col classes
temp1 = sapply(X = gp3[,shared], F = class)
temp2 = sapply(X = gp4[,shared], F = class)
temp1[temp1 != temp2]
temp2[temp1 != temp2]

shared[label(gp4[, shared]) != label(gp3[,shared])]


gp34 = bind_rows("GP3" = gp3, "GP4" = gp4, .id = "Study") |>
  arrange(`FXS ID`, `Visit Date`, `Event Name`) |>
  tidyr::fill(`Primary Race`, `Primary Ethnicity`, Gender, .direction = "downup") |>
  relocate(`Visit Date`, .after = `Event Name`)

trans =
  gp34 |> group_by(`FXS ID`) |> filter(n_distinct(Gender |> setdiff(NA)) > 1)

if(nrow(trans) != 0) browser(message('some values of Gender are inconsistent; valid?'))

gp34 |>  filter(if_any(where(is.character), .fn = ~ . == "NA")) # couldn't find any of these; there might be some in factors

decreased_age =
  gp34 |>
  group_by(`FXS ID`) |>
  mutate(
    `diff age` = c(NA, diff(`Age at visit`)),
    `decreased age` = `diff age` < 0) |>
  filter(any(`decreased age`, na.rm = TRUE)) |>
  ungroup() |>
  select(`FXS ID`, `Event Name`, `Visit Date`, `Age at visit`, `diff age`, `decreased age`)

readr::write_csv(decreased_age, "inst/extdata/decreased_age.csv")

decreased_age2 =
  gp34 |>
  arrange(`FXS ID`, `Visit Date`) |>
  group_by(`FXS ID`) |>
  mutate(
    `diff age` = c(NA, diff(`Age at visit`)),
    `decreased age` = `diff age` < 0) |>
  filter(any(`decreased age`, na.rm = TRUE)) |>
  ungroup() |>
  select(`FXS ID`, `Event Name`, `Visit Date`, `Age at visit`, `diff age`, `decreased age`)


readr::write_csv(decreased_age2, "inst/extdata/decreased_age2.csv")

usethis::use_data(gp34, overwrite = TRUE)
