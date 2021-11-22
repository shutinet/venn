appname <- "venn app"

header <- shiny::tags$header(
	class = "main-header", 
	shiny::tags$span(class = "logo", ""), 
	shiny::withMathJax(), 
	shinyjs::useShinyjs(), 
	shinyjs::extendShinyjs(
		text = "shinyjs.collapse = function(boxId) {
			$('#' + boxId).closest('.box').find('[data-widget=collapse]').click();
		}", functions = "collapse"),
	shinyFeedback::useShinyFeedback(),
	shinyWidgets::useSweetAlert(),
	bsplus::use_bs_tooltip(),
	rintrojs::introjsUI(),
	shiny::includeScript("www/d3.v4.min.js"), 
	shiny::includeScript("www/venn.js"), 
	shiny::includeCSS("www/venn_app.css"),
	shiny::includeScript("www/venn_app.js"),
	
	shiny::tags$nav(class = "navbar navbar-static-top", role = "navigation", 
		shiny::tags$form(class = "form-inline", 
			shiny::tags$div(class = "form-group", style = "float:left", 
				shiny::tags$span(id = "titleApp", class = "logo", appname)
			), 
			shiny::tags$div(class = "form-group", style = "float:right;",
				shiny::tags$a(`data-toggle` = "tooltip", 
					`data-placement` = "left", 
					title = 'Information on the different areas of the active window', 
					shiny::actionButton('introjs', '', icon = icon('question'))
				)
			)
		)
	)
)

sidebar <- shinydashboard::dashboardSidebar(disable = TRUE)

body <- shinydashboard::dashboardBody(
	shiny::fluidPage(
		tags$div(id = "loader", class = "lds-dual-ring"), 
		shinyjs::hidden(
			shiny::div(id = 'app-content',
				source(file.path('ui', 'main.R'), local = TRUE)$value
			)
		)
	)
)

shiny::shinyUI(
	shinydashboard::dashboardPage(
		title = appname, 
		header,
		sidebar,
		body
	)
)