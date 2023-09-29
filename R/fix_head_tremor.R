fix_head_tremor <- function(
    dataset
)
{
  dataset |>
    mutate(
      # for GP4, set head tremor to No if missing and Any Tremor is No
      `Head tremor` = replace(
        x = `Head tremor`,
        list =
          (is.na(`Head tremor`) & Study == "GP4" &
             `Any tremor (excluding Head Tremor)` == "No tremors recorded")
        ,
        values = "No"
      )
    )
}
