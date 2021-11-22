output$input_table <- DT::renderDataTable(data.frame(matrix(, nrow = 0, ncol = 2, 
	dimnames = list(c(), c("m/z", "y"))), 
	check.names = FALSE), 
selection = 'none', rownames = FALSE, server = FALSE, 
extensions = c("Buttons"), options = list(dom = 'Bfrtip', fixedColumns = TRUE, 
columnDefs = list(list(className = "dt-head-center dt-center", targets = "_all")), 
info = FALSE, searching = FALSE, buttons = list(
	list(
		extend = "collection", 
		text = 'New', 
		action = htmlwidgets::JS("function(e, dt, node, config){
				dt.row.add([
					'<input type=\"number\" step=\"any\" value = 0></input>',
					'<input type=\"number\" step=\"any\" value = 0></input>'
				]).draw(false);
			}"
	)), list(
		extend = "collection", 
		text = 'Delete', 
		action = htmlwidgets::JS("function(e, dt, node, config){
				var n_rows = dt.rows().count() - 1;
				if (n_rows >= 0) dt.row(n_rows).remove().draw(false);
			}"
))), language = list(emptyTable = "No m/z")))

output$mass_spec <- plotly::renderPlotly({
	input$input_table_draw
	data <- if (is.null(input$input_table_vals)) data.frame()
		else data.frame(matrix(as.numeric(input$input_table_vals), ncol = 2, byrow = TRUE))
	ymin <- if (is.null(input$ymin)) 0
		else if (is.na(input$ymin)) 0
		else input$ymin
	ymax <- if (is.null(input$ymax)) 100
		else if (is.na(input$ymax)) 100
		else input$ymax
	plot_MS(data, yrange = c(ymin, ymax))
})