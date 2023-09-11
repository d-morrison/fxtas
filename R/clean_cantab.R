clean_cantab = function(
    dataset,
    cutoffs = c(
      `SWM Between errors` = 26,
      # `SST Median correct RT on GO trials	` = NA,
      # `OTS Problems solved on first choice` = NA,
      `RTI Five-choice movement time` = 368.57,
      `PAL Total errors (adjusted)` = 13,
      `RVP A signal detection` = 0.52214


    ))
{

  # cutoffs taken from https://www.sciencedirect.com/science/article/pii/S2211034820302480?via%3Dihub

  dataset |>
    apply_cutoffs(cutoffs = cutoffs)
}
