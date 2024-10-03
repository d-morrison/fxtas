# fxtas (development version)

## Manuscript

* removed repeated measures analysis

## Data processing

* added "Disorder" suffix to SCID composite variables, on Dr. Bourgeois's recommendation.
* fixed `create_any_tremor()` to handle NAs before or after `fix_factors()`.
* renamed "Any Autoimmune" to "any autoimmune disorder" and make it "Yes"/"No"
* decapitalized "MMSE Total Score" to "MMSE total score"
* decapitalized "Parkinsonian features" to "parkinsonian features"
* removed "Parkinsonian features: " prefix from:
  - "Masked faces",
  - "Increased tone",
  - "Pill-rolling tremor",
  - "Stiff gait"
* Renamed "CGG (backfilled)" to CGG
* Renamed "ApoE (backfilled)" to ApoE
* Now using most recent ApoE value

# fxtas 0.0.0.9000

* Added a `NEWS.md` file to track changes to the package.
