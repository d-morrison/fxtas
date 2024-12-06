devtools::load_all()
library(Hmisc)
library(forcats)
library(lubridate)
library(dplyr)
conflicted::conflict_prefer("label", "Hmisc")
conflicted::conflict_prefer("not", "magrittr")
conflicted::conflicts_prefer(dplyr::filter)
conflicted::conflicts_prefer(dplyr::last)
library(tidyr)
# dupes = gp3 |> semi_join(gp4, by = c("subj_id", "redcap_event_name"))
# if(nrow(dupes) != 0) browser(message("why are there duplicate records?"))

shared = intersect(names(gp3), names(gp4))

# checking col classes
temp1 = sapply(X = gp3[, shared], F = class)
temp2 = sapply(X = gp4[, shared], F = class)
temp1[temp1 != temp2]
temp2[temp1 != temp2]

shared[label(gp4[, shared]) != label(gp3[, shared])]

setdiff(names(gp3), names(gp4))
setdiff(names(gp4), names(gp3))

gp34 =
  bind_rows("GP3" = gp3, "GP4" = gp4, .id = "Study") |>
  clean_data()


trans =
  gp34 |> group_by(`FXS ID`) |> dplyr::filter(n_distinct(Gender |> setdiff(NA)) > 1)

if (nrow(trans) != 0)
  browser(message('some values of Gender are inconsistent; valid?'))

gp34 |>  dplyr::filter(if_any(where(is.character),
                              .fn = ~ . == "NA (888)"))
# couldn't find any of these; there might be some in factors

decreased_age =
  gp34 |>
  get_decreased_age()

readr::write_csv(decreased_age, "inst/extdata/decreased_age.csv")

# out of order:

gp34 |> get_out_of_order()

# split(f = ~`FXS ID`, drop = TRUE)

decreased_age2 = gp34 |> get_decreased_age2()

readr::write_csv(decreased_age2, "inst/extdata/decreased_age2.csv")

test =
  waldo::compare(y = gp34,
                 x = fxtas::gp34,
                 ignore_attr = "problems") |>
  print()

if (length(test) > 0) {
  browser("are you sure you want to overwrite?")
}

usethis::use_data(gp34, overwrite = TRUE)

gp34_v1 =
  gp34 |>
  get_visit1()

usethis::use_data(gp34_v1, overwrite = TRUE)

gp34_multivisit_only =
  gp34 |>
  dplyr::filter(!is.na(`FXS ID`)) |>
  dplyr::filter(.by = `FXS ID`, n() > 1)

usethis::use_data(gp34_multivisit_only, overwrite = TRUE)
