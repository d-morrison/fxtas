picklename  = "sample_data_fold0_subtype0.pickle"
# picklename = "sample_data_subtype0.pickle"
picklenameOLD = paste(picklename, "OLD")
output_folder =
  "output/output.fixed_CV/" |>
  fs::dir_create()
library(reticulate)
results_old =
  fs::path(output_folder, "pickle_files", picklenameOLD) |>
  py_load_object() |>
  force()

results_new_local =
  fs::path(output_folder, "pickle_files", picklename) |>
  py_load_object() |>
  force()

results_new_server =
  fs::path("~/Downloads", picklename) |>
  py_load_object() |>
  force()

all.equal(results_new_local, results_new_server)
all.equal(results_old, results_new_local)

results_old_local$samples_likelihood[1,]
results_new_local$samples_likelihood[1,]

results_old$ml_sequence_EM |> print()
results_new$ml_sequence_EM |> print()

names(results_old)

all.equal(results_old, results_new)

results_old[["samples_sequence"]][,,1] |> print()
results_new[["samples_sequence"]][,,1] |> print()

results_old[["samples_likelihood"]][1,] |> print()
results_new[["samples_likelihood"]][1,] |> print()

results_old[["mean_likelihood_subj_test"]] |> print()
results_new[["mean_likelihood_subj_test"]] |> print()

# the output from python seems to just print the likelihood from the first mcmc iteration:
results_old$samples_likelihood[1,]
