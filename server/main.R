observeEvent(input$venn_file, {
	print("############ IMPORT FILE")
	file <- input$venn_file
	ext <- tools::file_ext(file)
	json_data <- tryCatch({
		if (is.null(file)) custom_stop("invalid", "a file is required")
		inputs <- "venn_file"
		conditions <- any(ext %in% c("ods", "xlsx"))
		msgs <- "The file need to be an ods or xlsx file"
		check_inputs(inputs, conditions, msgs)
		
		data <- if (any(ext == "ods")) readODS::read_ods(file$datapath)
			else openxlsx::read.xlsx(file$datapath)
		nms <- unlist(lapply(1:ncol(data), function(i) 
			combn(colnames(data), i, simplify = FALSE)), recursive = FALSE)
		ll <- unlist(lapply(1:ncol(data), function(i) 
			lapply(combn(as.list(data), i, simplify = FALSE), unlist, recursive = FALSE)), recursive = FALSE)
		out <- lapply(seq(ll), function(i) 
			list(
				sets = nms[[i]], 
				size = length(which(table(ll[[i]]) >= length(nms[[i]]))), 
				vals = names(which(table(ll[[i]]) >= length(nms[[i]])))
			))
		jsonlite::toJSON(out)
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