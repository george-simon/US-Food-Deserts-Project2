// d3.json('<data_source>').then(function(result) {
d3.csv("../resources/data/data_food_deserts.csv", function(results) {
    console.log(results);
  
      var data = Highcharts.geojson(
          Highcharts.maps['countries/us/us-all-all']
        ),
        // Extract the line paths from the GeoJSON
        lines = Highcharts.geojson(
          Highcharts.maps['countries/us/us-all-all'], 'mapline'
        ),
        // Filter out the state borders and separator lines, we want these
        // in separate series
        borderLines = Highcharts.grep(lines, function (l) {
          return l.properties['hc-group'] === '__border_lines__';
        }),
        separatorLines = Highcharts.grep(lines, function (l) {
          return l.properties['hc-group'] === '__separator_lines__';
        });
  
      // Add state acronym for tooltip
      Highcharts.each(data, function (mapPoint) {
        mapPoint.name = mapPoint.name + ', ' +
          mapPoint.properties['hc-key'].substr(3, 2);
      });
  
      document.getElementById('ushighchart').innerHTML = 'Rendering map...';
  
      // Create the map
      setTimeout(function () { // Otherwise innerHTML doesn't update
        Highcharts.mapChart('ushighchart', {
          chart: {
            borderWidth: 1,
            marginRight: 20 // for the legend
          },
  
          title: {
            text: 'US Counties unemployment rates, January 2018'
          },
  
          legend: {
            layout: 'vertical',
            align: 'right',
            floating: true,
            backgroundColor: ( // theme
              Highcharts.defaultOptions &&
              Highcharts.defaultOptions.legend &&
              Highcharts.defaultOptions.legend.backgroundColor
            ) || 'rgba(255, 255, 255, 0.85)'
          },
  
          mapNavigation: {
            enabled: true
          },
  
          colorAxis: {
            min: 0,
            max: 25,
            tickInterval: 5,
            stops: [[0, '#F1EEF6'], [0.65, '#900037'], [1, '#500007']],
            labels: {
              format: '{value}%'
            }
          },
  
          plotOptions: {
            mapline: {
              showInLegend: false,
              enableMouseTracking: false
            }
          },
  
          series: [{
            mapData: data,
            data: data,
            joinBy: ['hc-key', 'code'],
            name: 'Unemployment rate',
            tooltip: {
              valueSuffix: '%'
            },
            borderWidth: 0.5,
            states: {
              hover: {
                color: '#a4edba'
              }
            },
            shadow: false
          }, {
            type: 'mapline',
            name: 'State borders',
            data: borderLines,
            color: 'white',
            shadow: false
          }, {
            type: 'mapline',
            name: 'Separator',
            data: separatorLines,
            color: 'gray',
            shadow: false
          }]
        });
      }, 0);
    }
  ).catch(err => console.log(err))
  