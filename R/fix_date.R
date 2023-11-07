# fix Visit Date for Trax data
fix_date <- function(dataset){
  dataset |>
    mutate(
      `Visit Date` = as.Date(`Visit Date`, format = "%m/%d/%Y")
    )
}
