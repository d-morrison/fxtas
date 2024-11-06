message('starting package .Rprofile')
Sys.setlocale(category = "LC_COLLATE", locale = "en_US.UTF-8")

if (interactive()) {
  message("installing dev requirements")
  has_pak = "pak" %in% utils::installed.packages()[,"Package"]
  if(!has_pak) utils::install.packages("pak", repos = "https://cran.rstudio.com/")

  pak::pak(c("devtools", "pryr", "conflicted", "reprex"))

  message("loading dev requirements:")
  (require(devtools)) # loads usethis
  # (require(rsconnect)) # loads rsconnect
  # suppressMessages(require(dplyr))
  require("pryr")
  # suppressMessages(require(lubridate))
  # suppressMessages(require(magrittr))
  (require(conflicted))
  (require(reprex))

  # credentials::set_github_pat() # key to be able to install_github() private repos
  conflicted::conflict_prefer("filter", "dplyr")
  conflicted::conflict_prefer("lag", "dplyr")
  conflicted::conflict_prefer("summarise", "dplyr")
  conflicted::conflict_prefer("summarize", "dplyr")
  conflicted::conflict_prefer("select", "dplyr")
  conflicted::conflict_prefer("is_in", "magrittr")
  conflicted::conflicts_prefer(devtools::lint)
  qs <- function() q(save="no")
}

message('ending package .Rprofile')
