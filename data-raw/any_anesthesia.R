anesthesia_vars =
  grep("anesthesia", names(gp34), value = TRUE, ignore.case = TRUE)

visit1 |> select(all_of(anesthesia_vars)) |> table()
