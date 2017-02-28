source("server/server-head.R", local = TRUE)
shinyServer(function(input, output, session) source("server/app.R", local = TRUE))
