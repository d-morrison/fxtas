check_biomarker_colours = function(
    biomarker_colours, biomarker_labels)
{
  if(!is.null(names(biomarker_colours)))
  {
    # Check each label exists
    if(!all(names(biomarker_colours) %in% biomarker_labels))
      stop("A label doesn't match!")

    # Check each colour exists
    if(!all(biomarker_colours %in% colors()))
      stop("A proper colour wasn't given!")

    # Add in any colours that aren't defined, allowing for partial colouration
    for (label in biomarker_labels)
    {
      if (!is.element(label, biomarker_colours))
        biomarker_colours[label] = "black"
    }
  } else if(is.vector(biomarker_colours))
  {
    # Check each colour exists
    if(!all(biomarker_colours %in% colors()))
      stop("A proper colour wasn't given!")
    # Check right number of colours given
    if(length(biomarker_colours) != length(biomarker_labels))
      stop("The number of colours and labels do not match!")
    # Turn list of colours into a label:colour mapping
    names(biomarker_colours) = biomarker_labels
  } else
  {
    stop("A dictionary mapping label:colour or list/tuple of colours must be given!")
  }
  return(biomarker_colours)
}
