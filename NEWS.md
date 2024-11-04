# fxtas (development version)

## Manuscript

* Incorporated coauthors' feedback from 2024/09/03 draft
* Added additional line-graph comparison subfigures
for latent subtype clustering analysis
* Added more interpretation of subtype analysis results
* removed repeated measures analysis

## Analysis

* added info about displayed statistics to rows for `compute_prob_correct()` (#56)

## Graphics

* added `biomarker_order` argument to `compact_pvd_data_prep()` 
(default behavior should be unchanged)

## Data processing

* added "label" attribute to `FX3*`
* added "Disorder" suffix to SCID composite variables, 
on Dr. Bourgeois's recommendation.
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

## Package setup

* updated `WORDLIST`

# fxtas 0.0.0.9000

* Added a `NEWS.md` file to track changes to the package.
