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

tremor_types = c(
  "Intention tremor",
  "Resting tremor",
  "Postural tremor",
  "Intermittent tremor"
)


scid_vars = c(
  "Bipolar I Disorder (MD01), Lifetime",
  "Bipolar I Disorder (MD01), Current",
  "Bipolar II Disorder (MD02), Lifetime",
  "Bipolar II Disorder (MD02), Current",
  "Other Bipolar Disorder (MD03), Current",
  "Other Bipolar Disorder (MD03), Lifetime",
  "Major Depressive Disorder (MD04), Lifetime",
  "Major Depressive Disorder (MD04), Current",
  "Mood Disorder Due to GMC (MD07), Lifetime",
  "Mood Disorder Due to a GMC (MD07), Current",
  "Substance-Induced Mood Dis. (MD08), Lifetime",
  "Substance-Induced Mood Dis. (MD08), Current",
  "Primary Psychotic Symptoms (PS01), Lifetime",
  "Primary Psychotic Symptoms (PS01), Current"
)

gp34 =
  bind_rows("GP3" = gp3, "GP4" = gp4, .id = "Study") |>
  arrange(`FXS ID`, `Visit Date`, `Event Name`) |>
  filter(
    not(`FXS ID` == "100429-700" & `Event Name` == "GP3 - Visit 1"),
    `FXS ID` != "500011-190" # note from Ellery Santos, 2022-12-19, in word doc
  ) |>
  # duplicate of GP4 visit 1; note from Ellery Santos, 2022-12-19, in word doc
  relocate(`Visit Date`, .after = `Event Name`) |>
  mutate(

    `Head Tremor: Age of onset` =
      `Head Tremor: Age of onset` |> dplyr::recode("68-67" = "67.5"),
    # "68-67" |> strsplit("-") |> sapply(F = function(x) median(as.numeric(x)))

    across(
      .cols = ends_with("Age of onset"),
      list(
        missingness =
          ~missingness_reasons(
            .x,
            extra_codes = c(
              # 555, # lifelong - now handled as min(10, min(numeric_vals))
              99)),
        tmp =
          ~ .x |>
          age_range_medians() |>
          clean_numeric(extra_codes = c(
            # 555, # lifelong - now handled as min(10, min(numeric_vals))
            99))
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

    # `Drugs used` is unstructured text, with typos; unusable
    # across(
    #   c(`Drugs used`),
    #   ~ .x |>
    #     factor(levels = sort(unique(.x))) |>
    #     relabel_factor_missing_codes()
    # ),

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

    `FXTAS Stage (0-5)*` =  `FXTAS Stage (0-5)` |>  numeric_as_factor(),

    `FXTAS Stage (0-5)` = `FXTAS Stage (0-5)` |> clean_numeric(),

    # across(c(`FXTAS Stage (0-5)`), numeric_as_factor),

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
    `ApoE (backfilled)` = ApoE,
    `CGG (backfilled)` = CGG
  ) |>
  relocate(
    `ApoE (backfilled)`, .after = "ApoE"
  ) |>
  relocate(
    `CGG (backfilled)`, .after = "CGG"
  ) |>
  relocate(contains("CGG"), .after = contains("ApoE")) |>

  group_by(`FXS ID`) |>
  tidyr::fill(
    `Primary Race`,
    `Primary Ethnicity`,
    Gender,
    `ApoE (backfilled)`,
    `CGG (backfilled)`,
    .direction = "downup") |>
  mutate(
    `Recruited in study phase` = first(Study),
    `CGG (backfilled)` = `CGG (backfilled)` |> last() # more recent assays may be more accurate
  ) |>
  ungroup() |>
  mutate(
    across(where(is.factor), relabel_factor_missing_codes),
    across(
      where(is.factor),
      ~ . |> forcats::fct_na_value_to_level(level = "Missing (empty in RedCap)"))
  ) |>

  # SCID
  mutate(
    across(
      all_of(scid_vars),
      ~ if_else(
        condition = `Was SCID completed?` %in% "No" &
          . == "Missing (empty in RedCap)",
        true =
          factor(
            "Missing (SCID not completed)",
            levels = c(levels(.), "Missing (SCID not completed)")),
        false = .)
    )
  ) |>

  # alcohol use per day
  mutate(
    `# of drinks per day now` =
      if_else(
        Study == "GP3" &
          is.na(`# of drinks per day now`) &
          `Alcohol use/abuse` %in% c("Past Only", "None"),
        0,
        `# of drinks per day now`
      )
  ) |>

  # cases and controls
  mutate(
    FX = `CGG (backfilled)` >= 55, # TRUE = cases
    `FX*` = if_else(FX, "CGG >= 55", "CGG < 55") |> factor() |> relevel(ref = "CGG < 55")
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
