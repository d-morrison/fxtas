get_biomarkers = function(x)
{
  if("biomarkers" %in% names(attributes(x)))
  {
    return(attr(x, "biomarkers"))
  } else
  {
    return(names(x))
  }
}
