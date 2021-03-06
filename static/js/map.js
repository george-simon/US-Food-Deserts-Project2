    /** Test Instructions for highchart from template
     * Data parsed from http://www.bls.gov/lau/#tables
     *
     * 1. Go to http://www.bls.gov/lau/laucntycur14.txt (or similar, updated
     *  datasets)
     * 2. In the Chrome Developer tools console, run this code:
     *  copy(JSON.stringify(document.body.innerHTML.split('\n').filter(function (s) { return s.indexOf('<PUT DATE HERE IN FORMAT e.g. Feb-14>') !== -1; }).map(function (row) { row = row.split('|'); return { code: 'us-' + row[3].trim().slice(-2).toLowerCase() + '-' + row[2].trim(), name: row[3].trim(), value: parseFloat(row[8]) }; })))
     * 3. The data is now on your clipboard, paste it below
     * 4. Verify that the length of the data is reasonable, about 3300
     *  counties.
     */

    var data = [{"code":"us-al-001","name":"Autauga County, AL","value":3.9},{"code":"us-al-003","name":"Baldwin County, AL","value":4.3},{"code":"us-al-005","name":"Barbour County, AL","value":5.6},{"code":"us-al-007","name":"Bibb County, AL","value":4.2},{"code":"us-al-009","name":"Blount County, AL","value":3.8},{"code":"us-al-011","name":"Bullock County, AL","value":5.5},{"code":"us-al-013","name":"Butler County, AL","value":5.6}]
d3.json("/api/v1.0/natmapjsondata").then(data => {
  console.log(data);

  var countiesMap = Highcharts.geojson(
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
  Highcharts.each(countiesMap, function (mapPoint) {
  mapPoint.state = mapPoint.state + ', ' +
    mapPoint.properties['hc-key'].substr(3, 2);
  });

  document.getElementById('container').innerHTML = 'Rendering map...';

  // Create the map
  setTimeout(function () { // Otherwise innerHTML doesn't update
  Highcharts.mapChart('container', {
    chart: {
      borderWidth: 1,
      marginRight: 20 // for the legend
    },

    title: {
      text: 'US Counties Food Desert Percent, 2010'
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
      stops: [[0, '#80cdc1'], [0.65, '#dfc27d'], [1, '#543005']],
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
      mapData: countiesMap,
      data: data,
      joinBy: ['hc-key', 'code'],
      name: 'Food Deserts',
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
);