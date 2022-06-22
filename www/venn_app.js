$(document).on("shiny:connected", function(e) {
	$("body").addClass("sidebar-mini");
	$('.dropdown-menu').css('width', window.innerWidth/4.8);
});

Shiny.addCustomMessageHandler("venn_data", function(data) {
	var chart = venn.VennDiagram()
                 .width(600)
                 .height(500),
		div = d3.select("#venn_diag").datum(data),
		layout = chart(div),
		textCentres = layout.textCentres,
		tooltip = d3.select(".venntooltip");

    layout.enter
        .append("text")
        .attr("class", "sublabel")
        .text(function(d) { return "size " + d.size; })
        .style("fill", "#666")
        .style("font-size", "0px")
        .attr("text-anchor", "middle")
        .attr("dy", "0")
        .attr("x", chart.width() /2)
        .attr("y", chart.height() /2);
    layout.update
        .selectAll(".sublabel")
        .filter(function (d) { return d.sets in textCentres; })
        .text(function(d) { return "size " + d.size; })
        .style("font-size", "10px")
        .attr("dy", "18")
        .attr("x", function(d) { return Math.floor(textCentres[d.sets].x);})
        .attr("y", function(d) { return Math.floor(textCentres[d.sets].y);});
    /*
	div.call(chart);
	div.selectAll("path")
		.style("stroke-opacity", 0)
		.style("stroke", "#fff")
		.style("stroke-width", 3);
	*/
	div.selectAll("g")
		.on("mouseover", function(d, i) {
			// sort all the areas relative to the current item
			venn.sortAreas(div, d);

			// Display a tooltip with the current size
			tooltip.transition().duration(400).style("opacity", .9);
			tooltip.text(d.vals.join(" \n "));

			// highlight the current path
			var selection = d3.select(this).transition("tooltip").duration(400);
			selection.select("path")
				.style("stroke-width", 3)
				.style("fill-opacity", d.sets.length == 1 ? .4 : .1)
				.style("stroke-opacity", 1);
		})

		.on("mousemove", function() {
			tooltip.style("left", (d3.event.pageX) + "px")
				   // .style("top", (d3.event.pageY - 28) + "px");
				   .style("top", (d3.event.pageY) + "px");
		})

		.on("mouseout", function(d, i) {
			tooltip.transition().duration(400).style("opacity", 0);
			var selection = d3.select(this).transition("tooltip").duration(400);
			selection.select("path")
				.style("stroke-width", 0)
				.style("fill-opacity", d.sets.length == 1 ? .25 : .0)
				.style("stroke-opacity", 0);
		});

})
