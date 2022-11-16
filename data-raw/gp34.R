load_all()
library(Hmisc)
library(forcats)
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


gp34 =
  bind_rows("GP3" = gp3, "GP4" = gp4, .id = "Study") |>
  arrange(`FXS ID`, `Visit Date`, `Event Name`) |>
  tidyr::fill(`Primary Race`, `Primary Ethnicity`, Gender, .direction = "downup") |>
  relocate(`Visit Date`, .after = `Event Name`) |>
  mutate(
    `Ataxia: Age of onset missingness` =
      missingness_reasons(`Ataxia: Age of onset`),
    `Ataxia: Age of onset` =
      clean_numeric(`Ataxia: Age of onset`),
    `Ataxia: severity` =
      `Ataxia: severity` |>
      factor(levels = sort(unique(`Ataxia: severity`))) |>
      relabel_factor_missing_codes(),
    `# of drinks per day now` =
      `# of drinks per day now` |>
      factor(levels = sort(unique(`# of drinks per day now`))) |>
      relabel_factor_missing_codes() |>
      dplyr::recode_factor("-2" = "<1/day"),
    # `Head tremor age of onset` =
    #   `Head tremor age of onset` |>
    #   factor(levels =
    #            `Head tremor age of onset` |>
    #            unique() |>
    #            sort()) |>
    #   relabel_factor_missing_codes(),

    `Birth Date` = date(`Visit Date` - days(round(`Age at visit` * 365.25))), # causes problems for eg 	100399-100
    across(where(is.factor), relabel_factor_missing_codes)
  ) |>
  droplevels()

# levels(gp34$`# of drinks per day now`) =



trans =
  gp34 |> group_by(`FXS ID`) |> filter(n_distinct(Gender |> setdiff(NA)) > 1)

if(nrow(trans) != 0) browser(message('some values of Gender are inconsistent; valid?'))

gp34 |>  filter(if_any(where(is.character), .fn = ~ . == "NA (888)")) # couldn't find any of these; there might be some in factors

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
