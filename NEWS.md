# fxtas (development version)

## Manuscript

* Tons of polishing (#63, #64, #65)
* Added `gtsummary::bold_labels()` to `gtsummary` tables
* Added keywords
* Reduced title to under 100 characters, including spaces
* Removed numbers from headings.
* Incorporated coauthors' feedback up to 2024/11/18 draft
* Added additional line-graph comparison subfigures
for latent subtype clustering analysis
* Added more interpretation of subtype analysis results
* Removed repeated measures analysis


## Analysis

* added info about displayed statistics to rows for `compute_prob_correct()` (#56)

## Graphics

* added `biomarker_order` argument to `compact_pvd_data_prep()` 
(default behavior should be unchanged)
* added `shared_flextable_settings()` function to apply font, font size, and line spacing to all tables

## Data processing

* added tools for finding journals to submit to (#66)
* renamed `FXTAS Stage (0-5)*` to `FXTAS Stage`
* added columns to pre-processed data:
   - `Male`
   - `CGG 100-199`
   - `CGG 55-99`
* substituted ≤ instead of <= in dichotomized CANTAB variable value labels
* renamed SCID composite vars without capitalization (on Dr. Bourgeois's recommendation)
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
