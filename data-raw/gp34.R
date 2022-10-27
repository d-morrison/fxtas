load_all()

# dupes = gp3 |> semi_join(gp4, by = c("subj_id", "redcap_event_name"))
# if(nrow(dupes) != 0) browser(message("why are there duplicate records?"))

shared = intersect(names(gp3), names(gp4))

# checking col classes
temp1 = sapply(X = gp3[,shared], F = class)[2,]
temp2 = sapply(X = gp4[,shared], F = class)[2,]
temp1[temp1 != temp2]
temp2[temp1 != temp2]

shared[label(gp4[, shared]) != label(gp3[,shared])]


gp34 = bind_rows(gp3, gp4, .id = "study")

usethis::use_data(gp34, overwrite = TRUE)
