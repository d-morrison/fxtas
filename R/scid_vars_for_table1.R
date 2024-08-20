#' List SCID variables to display in data summary tables
#'
#' @returns a [character()] vector
#' @export
#'
#' @examples
#' scid_vars_for_table1()
scid_vars_for_table1 = function()
{
  c(
    # "Was SCID completed?",
    "SCID: Mood Disorders",
    # "Bipolar I Disorder (MD01), Lifetime",
    # "Bipolar I Disorder (MD01), Current",
    # "Bipolar II Disorder (MD02), Lifetime",
    # "Bipolar II Disorder (MD02), Current",
    # "Other Bipolar Disorder (MD03), Lifetime",
    # "Other Bipolar Disorder (MD03), Current",
    # "Major Depressive Disorder (MD04), Lifetime",
    # "Major Depressive Disorder (MD04), Current",
    # "Mood Disorder Due to GMC (MD07), Lifetime",
    # "Mood Disorder Due to GMC (MD07), Current",
    # "Substance-Induced Mood Dis. (MD08), Lifetime",
    # "Substance-Induced Mood Dis. (MD08), Current",
    "SCID: Substance Use",
    # "Alcohol (SUD17), Lifetime",
    #   "Alcohol (SUD17) Current",
    #   "Sedative-Hypnotic-Anxiolytic (SUD18), Lifetime",
    #   "Sedative-Hypnotic-Anxiolytic (SUD18), Current",
    #   "Cannabis (SUD19), Lifetime",
    #   "Cannabis (SUD19),Current",
    #   "Stimulants (SUD20), Lifetime",
    #   "Stimulants (SUD20) Current",
    #   "Opiod (SUD21), Lifetime",
    #   "Cocaine (SUD22), Lifetime",
    #   "Opiod (SUD21), Current",
    #   "Hallucinogenics/ PCP (SUD23), Lifetime",
    #   "Cocaine (SUD22) Current",
    #   "Hallucinogenics/ PCP (SUD23), Current",
    #   "Poly Drug (SUD24), Lifetime",
    #   "Poly Drug (SUD24), Current",
    #   "Other (SUD25), Lifetime",
    #   "Other (SUD25), Current",
    "SCID: Anxiety",
    "SCID: Somatization",
    "SCID: Psychotic"
    # "Primary Psychotic Symptoms (PS01), Lifetime",
    # "Primary Psychotic Symptoms (PS01), Current"
  )
}
