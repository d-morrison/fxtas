load_all()
output_folder = "output/output.fixed_CV/"
permuted_test_stats = collect_permutation_test_stats(output_folder)
observed_test_stat = get_observed_permutation_test_stat(output_folder)

plot_permutation_results(
  observed_test_stat = observed_test_stat,
  permuted_test_stats = permuted_test_stats) |>
  print()

compute_permutation_pvalue(
  observed_test_stat = observed_test_stat,
  permuted_test_stats = permuted_test_stats
) |> print()
