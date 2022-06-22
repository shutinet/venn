observeEvent(input$venn_file, {
	print("############ IMPORT FILE")
	file <- input$venn_file
	ext <- tools::file_ext(file)
	json_data <- tryCatch({
		if (is.null(file)) custom_stop("invalid", "a file is required")
		inputs <- "venn_file"
		conditions <- any(ext %in% c("ods", "xlsx", "csv"))
		msgs <- "The file need to be an ods or xlsx file"
		check_inputs(inputs, conditions, msgs)

		data <- if (any(ext == "ods")) readODS::read_ods(file$datapath)
			else if (any(ext == "xlsx")) openxlsx::read.xlsx(file$datapath)
			else read.csv(file$datapath)
		jsonlite::toJSON(unlist(lapply(1:ncol(data), function(i)
		    lapply(combn(seq(ncol(data)), i, simplify = FALSE), function(j) {
		        vals <- if (i == 1) data[, j] else Reduce(intersect, as.list(data[, j]))
		        vals <- vals[vals != ""]
		        list(
		            sets = colnames(data)[j],
		            size = length(vals),
		            vals = vals
	            )
		    })
		), recursive = FALSE))
	}, invalid = function(i) NULL
	, error = function(e) {
		print("ERR import file")
		print(e)
		sweet_alert_error(e$message)
		NULL
	})
	print(json_data)
	session$sendCustomMessage("venn_data", json_data)
	print("############ END IMPORT FILE")
})
