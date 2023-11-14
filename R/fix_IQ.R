fix_iq <- function(dataset){
  dataset |>
    # combine WAIS-3/WAIS-4/WASI-2 IQ scores.
    # should a record have WAIS and WASI score, use WAIS
    # order of score preference: WAIS-4 > WAIS-3 > WASI-2
    mutate(
      # Full scale IQ
      `Full Scale IQ` = case_when(
        !is.na(`WAIS IV Full Scale Composite Score (FSIQ)`) ~
          `WAIS IV Full Scale Composite Score (FSIQ)`,
        !is.na(`Full Scale: IQ Score`) ~ `Full Scale: IQ Score`,
        !is.na(`Composite Score: FSIQ-4`) ~ `Composite Score: FSIQ-4`,
        .default = NA
      ),
      # Perceptual Reasoning
      `Perceptual Reasoning Composite Score` = case_when(
        !is.na(`WAIS IV Perceptual Reasoning Composite Score (PRI)`) ~
          `WAIS IV Perceptual Reasoning Composite Score (PRI)`,
        !is.na(`Composite Score: PRI`) ~ `Composite Score: PRI`,
        .default = NA
      ),
      # Verbal Comp
      `Verbal Comprehension Composite Score` = case_when(
        !is.na(`WAIS IV Verbal Comprehension Composite Score (VCI)`) ~
          `WAIS IV Verbal Comprehension Composite Score (VCI)`,
        !is.na(`Verbal: IQ Score`) ~ `Verbal: IQ Score`,
        !is.na(`Composite Score: VCI`) ~ `Composite Score: VCI`,
        .default = NA
      )
    )
}
