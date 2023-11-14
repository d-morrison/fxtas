# clean education variables
clean_education <- function(data, edu.ref = "High School/GED"){
  # check that edu.ref is a factor level
  edu.fct.levels <- levels(data$`Education Level`)
  if(!(edu.ref %in% edu.fct.levels)){
    stop(paste0("edu.ref must be one of the Education Levels: ",
                paste(edu.fct.levels, collapse = ", ")))
  }

  data |>
    mutate(
      # create new Education Level variable with reference group = edu.ref
      `Education Level*` = relevel(`Education Level`, ref = edu.ref),
      # clean Years of Education to remove missing codes (777/888/999)
      `Years of Education` = clean_numeric(`Years of Education`)
    )
}
