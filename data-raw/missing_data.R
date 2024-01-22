library("fxtas")

variables =
  c(
    "ApoE*",
    "CGG (backfilled)",

    "Drug use",
    "Marijuana use",
    "Alcohol use/abuse",
    "# of drinks per day now",

    "Thyroid Cancer",
    "Skin Cancer",
    "Melanoma",
    "Prostate Cancer",
    "Other Cancer",

    "Surgery",
    "Anesthesia (medic_surg_anes)",
    "Anesthesia (new_mds_med_anes1)",

    "Intention tremor",
    "Resting tremor",
    "Postural tremor",
    "Intermittent tremor",
    "Any tremor",
    "Tremor: Age of onset",

    "Head tremor",
    "Head Tremor: Age of onset",

    "Ataxia",
    "Ataxia: severity",
    "Ataxia: Age of onset",


    grep("Parkinson", value = TRUE, names(gp34)),

    "FXTAS Stage (0-5)",

    "BDS-2 Total Score",

    "MMSE Total Score"

  )
