load_all()
library(Hmisc)
library(forcats)
library(lubridate)
library(dplyr)
conflict_prefer("label", "Hmisc")
conflict_prefer("not", "magrittr")
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
  remove_unneeded_records() |>
  relocate(`Visit Date`, .after = `Event Name`) |>
  clean_head_tremor() |>
  fix_onset_age_vars() |>
  create_any_tremor() |>
  make_vars_numeric(regex = "score", ignore.case = TRUE) |>
  make_vars_numeric(regex = "SCL90") |>

  # make_vars_numeric(regex = "BDS-2 Total Score") |>
  # make_vars_numeric(regex = "MMSE Total Score") |>

    # `Drugs used` is unstructured text, with typos; unusable
  # fix_drugs_used() |>

  fix_ApoE() |>

  fix_CGG() |>

  relocate(contains("CGG"), .after = contains("ApoE")) |>

  fix_FXTAS_stage() |>

  # not sure why disabled:
  # fix_tremors() |>

  fix_demographics() |>
  mutate(
    across(where(is.factor), relabel_factor_missing_codes),
    across(
      where(is.factor),
      ~ . |> forcats::fct_na_value_to_level(level = "Missing (empty in RedCap)"))
  ) |>

  # SCID
  clean_SCID() |>

  fix_drinks_per_day() |>

  # cases and controls
  mutate(
    FX = `CGG (backfilled)` >= 55, # TRUE = cases
    `FX*` =
      if_else(FX, "CGG >= 55", "CGG < 55") |>
      factor() |>
      relevel(ref = "CGG < 55"),

    `FX**` = `FX*` |> forcats::fct_explicit_na()
  ) |>
  # Ataxia
  clean_ataxia() |>

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

# out of order:

gp34 |>
  select(`FXS ID`, `Visit Date`, `Event Name`) |>
  group_by(`FXS ID`) |>
  filter(is.unsorted(`Event Name`)) |>
  # filter(any(`decreased age`, na.rm = TRUE)) |>
  # ungroup() |>
  group_split()

# split(f = ~`FXS ID`, drop = TRUE)

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

visit1 =
  gp34 |>
  arrange(`FXS ID`, `Visit Date`, `Event Name`) |>
  group_by(`FXS ID`) |>
  slice_head(n = 1) |>
  ungroup() |>
  rename(
    `Age at first visit` = `Age at visit`
  ) |>
  left_join(
    gp34 |> count(`FXS ID`, name = "# visits"),
    by = "FXS ID"
  ) |>
  mutate(`# visits` = factor(`# visits`, levels = 1:6)) |>
  droplevels()

usethis::use_data(visit1, overwrite = TRUE)
