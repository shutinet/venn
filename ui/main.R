shiny::tags$div(
	shinydashboard::box(width = 3, 
		shiny::fileInput("venn_file", "data file", accept = c(".ods", ".xlsx")), 
	), 
	
	shinydashboard::box(width = 9, 
		shiny::tags$div(id = "venn_diag")
	), 
	shiny::tags$div(class = "venntooltip")
)