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
                      "Population with<br>Low Access 1 Mile",
                      "Population with<br>Low Access 1/2 Mile",
                      "Population with<br>Low Income",
                      "Homes with<br>no Vehicles"];
    
    statistic_value = [sum_population_2010,
                       sum_population_low_access_1,
                       sum_population_low_access_half,
                       sum_population_low_income,
                       sum_house_unit_no_vehicle];

    // Create the Trace
    var trace1 = {
      x: statistic_name,
      y: statistic_value,
      marker:{
        color: ['rgba(0, 0, 255, 1)', 
                'rgba(0, 0, 255, 1)', 
                'rgba(0, 0, 255, 1)', 
                'rgba(255, 0, 0, 1)', 
                'rgba(255, 0, 0, 1)']
      },
      type: "bar"
    };

    var data = [trace1];

    // Define the plot layout
  var layout = {
    title: "Summary statistics of population <br> impacted by reduced access to healthy food <br> in Multnomah county.",
    xaxis: { tickangle: 45 },
    yaxis: { title: "Population in 1000s" },
      autosize: false,
      width: 600,
      height: 500,
      margin: {
        l: 70,
        r: 70,
        b: 120,
        t: 100,
        pad: 4
      },

  };
// Start of plot 2
    statistic2_name = [ 
                      "Percent of Population<br>at or below poverty level", 
                      "Percent of Population<br>that rents",
                      "Mean risk score<br>for renters",
                      "Percent of Population<br>without a BS Degree",
                      "Mean risk score for<br>age>25 without BS Degree",
                      "Percent of Population<br>that are of color",
                      "Mean risk score for<br>households of color",
                      "Overall mean<br>risk score"
                    ];
    
    statistic2_value = [median_percent_poverty,
                        percent_renters,
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
      marker:{
        color: ['rgba(0, 0, 255, 1)',
                'rgba(0, 0, 255, 1)', 
                'rgba(255, 0, 0, 1)', 
                'rgba(0, 0, 255, 1)', 
                'rgba(255, 0, 0, 1)', 
                'rgba(0, 0, 255, 1)',
                'rgba(255, 0, 0, 1)', 
                'rgba(255, 127, 0, 0.51)']
      },
      type: "bar"
    };

    var data2 = [trace2];

    // Define the plot layout
    var layout2 = {
    title: "Groups vulnerable to changing economic <br> conditions for Multnomah County",
    xaxis: { tickangle: 45  },
    yaxis: { title: "Percent" },
    autosize: false,
      width: 600,
      height: 500,
      margin: {
        l: 70,
        r: 70,
        b: 120,
        t: 100,
        pad: 4
      },
    };

  Plotly.newPlot("plot1", data, layout);
  Plotly.newPlot("plot2", data2, layout2);
});
}

buildplot();