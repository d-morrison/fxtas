devtools::load_all()

query = "FXTAS"
results_fxtas <- search_articles("FXTAS")

results_sustain <- search_articles("pysustain")

counts_fxtas =
  results_fxtas |>
  count_articles() |>
  print()

counts_sustain =
  results_sustain |>
  count_articles() |>
  print()
