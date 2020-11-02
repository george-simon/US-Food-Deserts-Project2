var url = 'http://127.0.0.1:5000//api/v1.0/multsummarydata'

function buildplot() {
  d3.json(url).then(function(data) {
  
    console.log(data);

    let county = data[0].county;
    let median_family_income = data[0].median_family_income;
    let median_percent_poverty = data[0].median_percent_poverty;
    let sum_house_unit_no_vehicle = data[0].sum_house_unit_no_vehicle;
    let sum_population_2010 = data[0].sum_population_2010;
    let sum_population_low_access_1 = data[0].sum_population_low_access_1;
    let sum_population_low_access_half = data[0].sum_population_low_access_half;
    let sum_population_low_income = data[0].sum_population_low_income;

    let mean_risk_factor = data[0].mean_risk_factor;
    let mean_risk_households_of_color = data[0].mean_risk_households_of_color;
    let mean_risk_over_25_wo_bachlrs = data[0].mean_risk_over_25_wo_bachlrs;
    let mean_risk_renters = data[0].mean_risk_renters;
    let mean_risk_with_lessthan_80pcnt_of_mfi_score = data[0].mean_risk_with_lessthan_80pcnt_of_mfi_score;
    let percent_households_lessthan_80pcnt_of_mfi_score = data[0].percent_households_lessthan_80pcnt_of_mfi_score;
    let percent_households_of_color = data[0].percent_households_of_color;
    let percent_no_bachlrs = data[0].percent_no_bachlrs;
    let percent_renters = data[0].percent_renters;

    statistic_name = ["Total Population",
                      "Total Population with Low Access 1 Mile",
                      "Total Population with Low Access Half Mile",
                      "Total Population with Low Income",
                      "Homes with no Vehicles"];
    
    statistic_value = [sum_population_2010,
                       sum_population_low_access_1,
                       sum_population_low_access_half,
                       sum_population_low_income,
                       sum_house_unit_no_vehicle];

    // Create the Trace
    var trace1 = {
      x: statistic_name,
      y: statistic_value,
      type: "bar"
    };

    var data = [trace1];

    // Define the plot layout
  var layout = {
    title: "Summary Statistics for Multnomah County",
    xaxis: { title: "Population Statistics" },
    yaxis: { title: "Population in 1000s" }
  };
// Start of plot 2
    statistic2_name = ["Percent of Population that rent",
                      "Mean risk score for renters ",
                      "Percent of Population without a Bachelor's Degree",
                      "Mean risk score for age > 25 without Bachelor's Degree",
                      "Percent of Population that are of color",
                      "Mean risk score for households of color",
                      "Overall mean risk score"
                    ];
    
    statistic2_value = [percent_renters,
                        mean_risk_renters,
                        percent_no_bachlrs,
                        mean_risk_over_25_wo_bachlrs,
                        percent_households_of_color,
                        mean_risk_households_of_color,
                        mean_risk_factor
                      ];
    // Create the Trace
    var trace2 = {
      x: statistic2_name,
      y: statistic2_value,
      type: "bar"
    };

    var data2 = [trace2];

    // Define the plot layout
    var layout2 = {
    title: "Vulnerability to changing economic" + "/n" +"conditions for Multnomah County",
    xaxis: { title: "Risk Factors and Risk Scores" },
    yaxis: { title: "Percent" }
    };

  Plotly.newPlot("plot1", data, layout);
  Plotly.newPlot("plot2", data2, layout2);
});
}

buildplot();