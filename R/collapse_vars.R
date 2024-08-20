collapse_vars = function(x)
{
  x |> formulaic::add.backtick() |> paste(collapse = " + ")
}
