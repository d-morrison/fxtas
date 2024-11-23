# from https://stackoverflow.com/questions/64931905/how-to-swap-the-names-and-values-of-a-named-vector-in-r

swap_names_and_values = function(x) {
  setNames(names(x), x)
}
