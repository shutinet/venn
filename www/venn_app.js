function getSetIntersections() {
    areas = d3.selectAll("table input").nodes().map(
        function (element) {
            return { sets: element.id.split(","),
                     size: parseFloat(element.value)};} );
    return areas;
}

// draw the initial set
function draw(chart, div, tooltip) {
	var datas = getSetIntersections(), 
		labels = $("#labels input").toArray().map(x => $(x).val());
	datas[0].sets = [labels[0]];
	datas[1].sets = [labels[0], labels[1]];
	datas[2].sets = [labels[1]];
	datas[3].sets = [labels[0], labels[2]];
	datas[4].sets = [labels[2]];
	datas[5].sets = [labels[1], labels[2]];
	datas[6].sets = [labels[0], labels[1], labels[2]];
	
    div.datum(datas).call(chart);
	div.selectAll("path")
		.style("stroke-opacity", 0)
		.style("stroke", "#fff")
		.style("stroke-width", 3)
	div.selectAll("g")
		.on("mouseover", function(d, i) {
			// sort all the areas relative to the current item
			venn.sortAreas(div, d);

			// Display a tooltip with the current size
			tooltip.transition().duration(400).style("opacity", .9);
			tooltip.text(d.size);

			// highlight the current path
			var selection = d3.select(this).transition("tooltip").duration(400);
			selection.select("path")
				.style("fill-opacity", d.sets.length == 1 ? .4 : .1)
				.style("stroke-opacity", 1);
		})

		.on("mousemove", function() {
			tooltip.style("left", (d3.event.pageX) + "px")
				   .style("top", (d3.event.pageY - 28) + "px");
		})

		.on("mouseout", function(d, i) {
			tooltip.transition().duration(400).style("opacity", 0);
			var selection = d3.select(this).transition("tooltip").duration(400);
			selection.select("path")
				.style("fill-opacity", d.sets.length == 1 ? .25 : .0)
				.style("stroke-opacity", 0);
		});
}

$(document).on("shiny:connected", function(e) {
	$("body").addClass("sidebar-mini");
	$('.dropdown-menu').css('width', window.innerWidth/4.8);
	
	var chart = venn.VennDiagram()
                 .width(600)
                 .height(500),
		div = d3.select("#venn_diag"),
		tooltip = d3.select(".venntooltip");
	draw(chart, div, tooltip);
	// redraw the sets on any change in input
	d3.selectAll("input").on("change", () => draw(chart, div, tooltip));
});