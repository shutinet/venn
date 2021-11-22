shiny::tags$div(
	shinydashboard::box(width = 3, 
		shiny::tags$h3("Titles"), 
		shiny::tags$div(id = "labels", 
			shiny::textInput("title_A", "A", "A", placeholder = "A", width = "50%"), 
			shiny::textInput("title_B", "B", "B", placeholder = "B", width = "50%"), 
			shiny::textInput("title_C", "C", "C", placeholder = "C", width = "50%")
		), 
		shiny::tags$hr(), 
		shiny::tags$h3("Data"), 
		shiny::tags$table(
			shiny::tags$tr(
				shiny::tags$td(
					shiny::numericInput("A", "A", 16, min = 0)
				), 
				shiny::tags$td(
					shiny::numericInput("A,B", "A \\(\\cap\\) B", 4, min = 0)
				)
			),
			shiny::tags$tr(
				shiny::tags$td(
					shiny::numericInput("B", "B", 16, min = 0)
				), 
				shiny::tags$td(
					shiny::numericInput("A,C", "A \\(\\cap\\) C", 4, min = 0)
				)
			),
			shiny::tags$tr(
				shiny::tags$td(
					shiny::numericInput("C", "C", 12, min = 0)
				), 
				shiny::tags$td(
					shiny::numericInput("B,C", "B \\(\\cap\\) C", 3, min = 0)
				)
			), 
			shiny::tags$tr(
				shiny::tags$td(), 
				shiny::tags$td(
					shiny::numericInput("A,B,C", "A \\(\\cap\\) B \\(\\cap\\) C", 2, min = 0)
				)
			)
		)
	), 
	
	shinydashboard::box(width = 9, 
		shiny::tags$div(id = "venn_diag")
	), 
	shiny::tags$div(class = "venntooltip")
)