display_DT <- function(data, filename, group = TRUE){
  if(!is.logical(group)){
    stop('Group must be TRUE/FALSE')
  }

  if(group){
    DT::datatable(
      data, rownames = FALSE,
      extensions = c('Buttons', 'RowGroup'),
      options = list(
        dom = 'Bfrtip',
        buttons = list(
          list(
            extend = 'collection',
            buttons = list(
              list(
                extend = 'csv',
                filename = filename
              ),
              list(
                extend = 'excel',
                filename = filename
              )
            ),
            text = "Download"
          )
        ),
        rowGroup = list(dataSrc = 0)
      )
    )
  } else{
    DT::datatable(
      data, rownames = FALSE,
      extensions = c('Buttons'),
      options = list(
        dom = 'Bfrtip',
        buttons = list(
          list(
            extend = 'collection',
            buttons = list(
              list(
                extend = 'csv',
                filename = filename
              ),
              list(
                extend = 'excel',
                filename = filename
              )
            ),
            text = "Download"
          )
        )
      )
    )
  }

}
