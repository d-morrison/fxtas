get_title_i = function(
    subtype_titles,
    samples_f,
    subtype_order,
    n_samples,
    cval)
{
  if (!is.null(subtype_titles))
  {
    title_i = subtype_titles[i]
  } else
  {
    # Add axis title
    if (!cval)
    {
      temp_mean_f = rowMeans(samples_f)

      # Shuffle vals according to subtype_order
      # This defaults to previous method if custom order not given
      vals = temp_mean_f[subtype_order]

      if (!is.infinite(n_samples))
      {
        title_i = glue::glue("Subtype {i} (f={vals[i] |> round(2)}, n={round(vals[i] * n_samples)})")
      } else
      {
        title_i = glue::glue("Subtype {i} (f={vals[i] |> round(2)})")
      }

    } else
    {
      title_i = glue::glue("Subtype {i} cross-validated")
    }

  }
  return(title_i)

}
