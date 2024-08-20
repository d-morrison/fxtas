old_trax_vars = vroom::vroom("inst/extdata/2023_11_07_TRAXDataforEzra.csv")

new_gp4_vars = vroom::vroom("inst/extdata/CTSC3704GP4GenotypeP-FXTASEventSequence10_DATA_2024-03-21_1020.csv") |> names()
new_gp3_vars = vroom::vroom("inst/extdata/GPGenotypePhenotypeR-FXTASEventSequence10_DATA_2024-03-20_1146.csv") |> names()

old_gp4_vars = vroom::vroom("inst/extdata/CTSC3704GP4GenotypeP-FXTASEventSequence10_DATA_2023-09-25_1239.csv")|> names()
old_gp3_vars = vroom::vroom("inst/extdata/GPGenotypePhenotypeR-FXTASEventSequence10_DATA_2023-09-25_1240.csv")|> names()

added_gp4_vars = setdiff(new_gp4_vars, old_gp4_vars)
added_gp3_vars = setdiff(new_gp3_vars, old_gp3_vars)
setdiff(added_gp4_vars, added_gp3_vars)
setdiff(added_gp3_vars, added_gp4_vars)
trax_vars_to_add = union(added_gp4_vars, added_gp3_vars)
