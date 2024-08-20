get_title_i = function(
    samples_f,
    subtype_order,
    n_samples,
    cval,
    i)
{
  # (f={vals[i] |> round(2)}"
  if(nrow(samples_f) == 1)
  {
    title_i = glue::glue("n = {n_samples}")
  } else if(cval)
  {
    title_i = glue::glue("Subtype {i} cross-validated")

  } else
  {
    temp_mean_f = rowMeans(samples_f)

    # Shuffle vals according to subtype_order
    # This defaults to previous method if custom order not given
    vals = temp_mean_f[subtype_order]

    if (is.finite(n_samples))
    {
      title_i = glue::glue(
        "Subtype {i} ",
        "(f={vals[i] |> round(2)}, ",
        "n={round(vals[i] * n_samples)})")
    } else
    {
      title_i = glue::glue(
        "Subtype {i} ",
        "(f={vals[i] |> round(2)})")
    }

  }

  return(title_i)

}
