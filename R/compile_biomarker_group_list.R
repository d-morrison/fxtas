#' Title
#'
#' @return
#' @export
#'
compile_biomarker_group_list = function()
{
  tremors = c(
    "Head tremor",
    "Intention tremor",
    "Resting tremor",
    "Postural tremor",
    "Intermittent tremor"
    # "Any tremor"
  )

  parkinsons_vars =
    vars = grep("Parkinson", value = TRUE, names(gp34))

  mri_vars = c(
    "Cerebral Atrophy",
    "Cerebellar Atrophy",
    "Cerebral WM Hyperintensity",
    "Cerebellar WM Hyperintensity",
    "MCP-WM Hyperintensity",
    "Pons-WM Hyperintensity",
    "Sub-Insular WM Hyperintensity",
    "Periventricular WM Hyperintensity",
    "Splenium (CC)-WM Hyperintensity",
    "Genu (CC)-WM Hyperintensity",
    "Corpus Callosum-Thickness"
  )

  cancer_vars =  c(
    "Any Cancer"
    # "Thyroid Cancer",
    # "Skin Cancer",
    # "Melanoma",
    # "Prostate Cancer",
    # "Other Cancer"
  )

  ataxia = c(
    "Ataxia",
    "Ataxia: severity*"
    # grep("Parkinson", value = TRUE, names(visit1))
  )

  scid_vars =
    vars = c(
      "Bipolar I Disorder (MD01), Lifetime",
      "Bipolar II Disorder (MD02), Lifetime",
      "Other Bipolar Disorder (MD03), Lifetime",
      "Major Depressive Disorder (MD04), Lifetime",
      "Mood Disorder Due to GMC (MD07), Lifetime",
      # "Substance-Induced Mood Dis. (MD08), Lifetime", # no positives
      "Primary Psychotic Symptoms (PS01), Lifetime"
    )

  cantab_vars = c(
    "SWM Between errors*",
    # "SST Median correct RT on GO trials*",
    "RVP A signal detection*", # all one way
    # "OTS Problems solved on first choice*",
    "PAL Total errors (adjusted)*",
    "RTI Five-choice movement time*")

  scores =
    c(
      "MMSE Total Score*",
      "BDS-2 Total Score*")

  thyroid_vars = c(
    # "Hypothyroid",
    # "Hyperthyroid",
    "Thyroid problems"
    # "Lupus",
    # "Rheumatoid arthritis",
    # "Multiple Sclerosis: Workup",
    # "ANA positive",
    # "Sjogrens Syndrome",
    # "Raynauds Syndrome"
    ## "Pulmonary Fibrosis" # none
    ## "Immunological Notes"


  )

  scl90_vars =
    grep(
      value = TRUE,
      names(gp34),
      pattern = "^SCL90.*\\*$") |>
    sort()

  thyroid_vars = c(
    "Hypothyroid",
    "Hyperthyroid",
    "Thyroid problems",
    "Lupus",
    "Rheumatoid arthritis"
    # "Multiple Sclerosis: Workup",
    # "ANA positive",
    # "Sjogrens Syndrome",
    # "Raynauds Syndrome",
    # "Pulmonary Fibrosis"
    ## "Immunological Notes"


  )
  kinesia_vars = c(
    "Kinesia Left Rest Tremor*",
    "Kinesia Left Postural Tremor*",
    "Kinesia Left Kinetic Tremor*",
    "Kinesia Right Rest Tremor*",
    "Kinesia Right Postural Tremor*",
    "Kinesia Right Kinetic Tremor*"
  )

  biomarker_group_list =
    list(
      tremors = tremors,
      ataxia = ataxia,
      stage = "FXTAS Stage (0-5)*",
      parkinsons = parkinsons_vars,
      cancer = cancer_vars,
      mri = mri_vars,
      scores = scores,
      scid = scid_vars,
      scl90 = scl90_vars,
      cantab = cantab_vars,
      thyroid = thyroid_vars
      # kinesia = kinesia_vars
    )

}
