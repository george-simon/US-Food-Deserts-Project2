// @TODO: YOUR CODE HERE!

// Set dimensions and margins of the graph
var svgWidth = 1000;
var svgHeight = 700;

var margin = {
    top: 90,
    right: 90,
    bottom: 90,
    left: 90
};

// Defining the dimensions of the chart area
var chartWidth = svgWidth - margin.left - margin.right;
var chartHeight = svgHeight - margin.top - margin.bottom;

// Select "scatter" id, append SVG area to it, and set its dimensions
var svg = d3.select("#scatter")
    .append("svg")
    .attr("width", svgWidth)
    .attr("height", svgHeight);

// Append a group area within the SVG area and set its margins
var chartGroup = svg.append("g")
    .attr("transform", `translate(${margin.left}, ${margin.top})`);

// Load data from /api/v1.0/natstatdata
d3.json("/api/v1.0/natstatdata").then(fdData => {

    // Print the data
    console.log(fdData);

    // Cast the percent_food_desert and median_income values to numbers
    // fdData.forEach(data => {
    //     data.percent_food_desert = +data.percent_food_desert;
    //     data.median_income = +data.median_income;
    // });
    
    // Configure a linear scale with a range between the chartHeight and 0

    var xLinearScale = d3.scaleLinear()
    .domain([d3.min(fdData, d => d.percent_food_desert), d3.max(fdData, d => d.percent_food_desert)])
    .range([0, chartWidth]).nice();

    var yLinearScale = d3.scaleLinear()
    .domain([d3.min(fdData, d => d.median_income), d3.max(fdData, d => d.median_income)])
    .range([chartHeight, 0]).nice();

    // Create two new functions passing the scales in as arguments
    // These will be used to create the chart's axes
    var bottomAxis = d3.axisBottom(xLinearScale);
    var leftAxis = d3.axisLeft(yLinearScale);

    // Append the "g" elements to the chartGroup, creating axes
    chartGroup.append("g")
        .attr("transform", `translate(0, ${chartHeight})`)
        .call(bottomAxis);
    
    chartGroup.append("g")
        .call(leftAxis);

    // Append scatter plot circles to the chart
    var circlesGroup = chartGroup.append("g")
        .selectAll("circle")
        .data(fdData)
        .join("circle")
        .attr("cx", d => xLinearScale(d.percent_food_desert))
        .attr("cy", d => yLinearScale(d.median_income))
        .attr("r", 10)
        .attr("fill", "teal");

    // Add labels to the circle locations
    var circleLabels = chartGroup.append("g")
        .selectAll("text")
        .data(fdData)
        .join("text")
            .attr("id", "stateCode")
            .attr("x", d => xLinearScale(d.percent_food_desert)-6)
            .attr("y", d => yLinearScale(d.median_income)+4)
            .style("fill", "white")
            .style("font-size", 12)
            .text(d => d.statecode);

    // Create axes labels
    chartGroup.append("text")
        .attr("transform", "rotate(-90)")
        .attr("y", 0 - margin.left)
        .attr("x", 0 - (chartHeight / 2))
        .attr("dy", "1em")
        .attr("class", "axisText")
        .text("State Median Income");
    
    chartGroup.append("text")
        .attr("transform", `translate(${chartWidth / 2}, ${chartHeight + margin.top / 2})`)
        .attr("class", "axisText")
        .text("Living in Food Desert (%)");
});