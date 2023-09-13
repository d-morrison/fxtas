test_that(
  "compute_confus_matrix produces expected results",
  {
    samples_sequence = matrix(
      nrow = 2,
      byrow = TRUE,
      dimnames = list(
        iteration = NULL,
        position = paste("Event #", 1:10)),
      paste(
        "biomarker",
        c(0,2,4,6,8,9,7,5,3,1,
          0,1,2,3,4,5,6,7,8,9))) |>
      structure("biomarker_event_names" = paste("biomarker", 0:9))

    result = compute_confus_matrix(samples_sequence)

    expected = matrix(
      nrow = 10,
      byrow = TRUE,
      dimnames = list(
        "event name" = paste("biomarker", 0:9),
        "position" = paste("Event #", 1:10)),
      c(1. , 0. , 0. , 0. , 0. , 0. , 0. , 0. , 0. , 0.,
        0. , 0.5, 0. , 0. , 0. , 0. , 0. , 0. , 0. , 0.5,
        0. , 0.5, 0.5, 0. , 0. , 0. , 0. , 0. , 0. , 0. ,
        0. , 0. , 0. , 0.5, 0. , 0. , 0. , 0. , 0.5, 0. ,
        0. , 0. , 0.5, 0. , 0.5, 0. , 0. , 0. , 0. , 0. ,
        0. , 0. , 0. , 0. , 0. , 0.5, 0. , 0.5, 0. , 0. ,
        0. , 0. , 0. , 0.5, 0. , 0. , 0.5, 0. , 0. , 0. ,
        0. , 0. , 0. , 0. , 0. , 0. , 0.5, 0.5, 0. , 0. ,
        0. , 0. , 0. , 0. , 0.5, 0. , 0. , 0. , 0.5, 0. ,
        0. , 0. , 0. , 0. , 0. , 0.5, 0. , 0. , 0. , 0.5))
    expect_equal(object = result, expected = expected)
  })
