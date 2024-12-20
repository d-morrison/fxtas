count_articles = function(x)
{
  x |>
    count(Journal) |>
    arrange(desc(n))
}
