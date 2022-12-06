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

tremor_types = c(
  "Intention tremor",
  "Resting tremor",
  "Postural tremor",
  "Intermittent tremor"
)


gp34 =
  bind_rows("GP3" = gp3, "GP4" = gp4, .id = "Study") |>
  arrange(`FXS ID`, `Visit Date`, `Event Name`) |>
  group_by(`FXS ID`) |>
  mutate(`Recruited in study phase` = Study[1]) |>
  ungroup() |>
  tidyr::fill(`Primary Race`, `Primary Ethnicity`, Gender, .direction = "downup") |>
  relocate(`Visit Date`, .after = `Event Name`) |>
  mutate(

    # `Ataxia: Age of onset missingness` =
    #   missingness_reasons(`Ataxia: Age of onset`),
    # `Ataxia: Age of onset` =
    #   clean_numeric(`Ataxia: Age of onset`),

    `Head Tremor: Age of onset` =
      `Head Tremor: Age of onset` |> dplyr::recode("68-67" = "67.5"),
    # "68-67" |> strsplit("-") |> sapply(F = function(x) median(as.numeric(x)))

    across(
      .cols = ends_with("Age of onset"),
      list(
        missingness = ~missingness_reasons(.x, extra_codes = c(99, 555)),
        tmp = ~ .x |> age_range_medians() |> clean_numeric(extra_codes = c(99, 555))
      ),
      .names = "{.col}{if_else(.fn != 'tmp', paste0(': ', .fn), '')}"
    ),

    "Any tremor" = dplyr::if_any(
      .cols = all_of(tremor_types),
      .fns = ~ . %in% "Yes") |>
      if_else("Some Tremors Recorded", "No Tremors Recorded"),


    across(
      contains("score", ignore.case = TRUE),
      # c(
      #   `BDS-2 Total Score`,
      #   `MMSE Total Score`),
      list(
        missingness = missingness_reasons,
        tmp = clean_numeric),
      .names = "{.col}{if_else(.fn != 'tmp', paste0(': ', .fn), '')}"
    ),

    across(
      c(`Ataxia: severity`, `Drugs used`),
      ~ .x |>
        factor(levels = sort(unique(.x))) |>
        relabel_factor_missing_codes()
    ),

    ApoE =
      ApoE |>
      strsplit(", ") |>
      sapply(sort) |>
      sapply(paste, collapse = ", ") |>
      na_if(""),

    ApoE = factor(ApoE, levels = sort(unique(ApoE))),

    CGG =
      `Floras Non-Sortable Allele Size (CGG) Results` |>
      strsplit(" *(-|,) *") |>
      sapply(F = function(x) gsub(x = x, fixed = TRUE, "?*", "")) |>
      sapply(F = as.numeric) |>
      suppressWarnings() |>
      sapply(F = max),

    `CGG: missingness` =
      missingness_reasons(
        x = `Floras Non-Sortable Allele Size (CGG) Results`,
        x.clean = CGG
      ),

    across(c(`FXTAS Stage (0-5)`), numeric_as_factor),

    # `Tremor: Age of onset: missingness` =
    #   missingness_reasons(`Tremor: Age of onset`),
    #
    # `Tremor: Age of onset` =
    #   clean_numeric(`Tremor: Age of onset`),

    # `Head Tremor: Age of onset: missingness` =
    #   `Head Tremor: Age of onset` |> missingness_reasons,

    `# of drinks per day now: missingness` =
      missingness_reasons(`# of drinks per day now`),

    `# of drinks per day now` =
      if_else(
        `# of drinks per day now` == -2,
        0,
        `# of drinks per day now`) |>
      clean_numeric(),

    # `Head Tremor: Age of onset` =
    #   `Head Tremor: Age of onset` |>
    #   factor(levels =
    #            `Head Tremor: Age of onset` |>
    #            unique() |>
    #            sort()) |>
    #   relabel_factor_missing_codes(),

    `Birth Date` = date(`Visit Date` - days(round(`Age at visit` * 365.25))), # causes problems for eg 	100399-100
    across(where(is.factor), relabel_factor_missing_codes),

    across(where(is.factor), ~ . |> forcats::fct_explicit_na(na_level = "Missing (empty in RedCap)"))
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

# out of order:

gp34 |>
  select(`FXS ID`, `Visit Date`, `Event Name`) |>
  group_by(`FXS ID`) |>
  filter(is.unsorted(`Event Name`)) |>
  # filter(any(`decreased age`, na.rm = TRUE)) |>
  # ungroup() |>
  group_split() |>
  pander()

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
