set_units_percent = function(x)
{
  x |> units::set_units(1) |> units::set_units("%")
}
