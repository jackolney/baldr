source("ui/ui-head.R", local = TRUE)

navbarPage(
	theme = shinytheme("paper"),
	title = "modelr",
	source("ui/plot.R",       local = TRUE)$value,
	source("ui/table.R",      local = TRUE)$value,
    source("ui/param-plot.R", local = TRUE)$value,
	source("ui/more.R",       local = TRUE)$value
)
