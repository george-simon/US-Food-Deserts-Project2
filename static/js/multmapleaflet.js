// Create map object
var myMap = L.map("map", {
    center: [45.535, -122.655],
    zoom: 11
  });

// Add street layer to the map
var satelitemap = L.tileLayer("https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}", {
  attribution: "© <a href='https://www.mapbox.com/about/maps/'>Mapbox</a> © <a href='http://www.openstreetmap.org/copyright'>OpenStreetMap</a> <strong><a href='https://www.mapbox.com/map-feedback/' target='_blank'>Improve this map</a></strong>",
  tileSize: 512,
  maxZoom: 18,
  zoomOffset: -1,
  id: "mapbox/satellite-streets-v11",
  accessToken: API_KEY
}).addTo(myMap);

// Add light layer to the map
var streetmap = L.tileLayer("https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}", {
  attribution: "Map data &copy; <a href=\"https://www.openstreetmap.org/\">OpenStreetMap</a> contributors, <a href=\"https://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>, Imagery © <a href=\"https://www.mapbox.com/\">Mapbox</a>",
  maxZoom: 18,
  id: "mapbox/streets-v11",
  accessToken: API_KEY
});

// Add dark layer to the map
var darkmap = L.tileLayer("https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}", {
  attribution: "Map data &copy; <a href=\"https://www.openstreetmap.org/\">OpenStreetMap</a> contributors, <a href=\"https://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>, Imagery © <a href=\"https://www.mapbox.com/\">Mapbox</a>",
  maxZoom: 18,
  id: "mapbox/dark-v10",
  accessToken: API_KEY
});

// Create a baseMaps object
var baseMaps = {
  "Satelite Map": satelitemap,
  "Street Map": streetmap,
  "Dark Map": darkmap
};

// File path to Multnomah census tract geoJson
let mult_geoJson = "../static/js/outline_mult.geojson";

// Grab postGres data with d3 and flask
d3.json("/api/v1.0/multdata").then(multdata => {

  // Grab Multnomah geoJson with d3
  d3.json(mult_geoJson).then(mult_geoJson => {
    
    // Define features from mult_geoJson
    let features = mult_geoJson.features;

    // Define population in 2010 from mult_geoJson
    let population_2010 = []

    for (let i = 0; i < features.length; i++) {
      let pop_2010 = multdata[i].population_2010
      population_2010.push(pop_2010)
    };

    // Define median family income from mult_geoJson
    let family_income = []

    for (let i = 0; i < features.length; i++) {
      let fam_income = multdata[i].med_fam_income
      family_income.push(fam_income)
    };

    // Define percent low acess to food at half mile from multdata
    let percent_la_half = [];

    for (let i = 0; i < multdata.length; i++) {
        let perc_la_half = multdata[i].percent_low_access_half
        percent_la_half.push(perc_la_half)
    };

    // Define percent low acess to food at one mile from multdata
    let percent_la_1 = [];

    for (let i = 0; i < multdata.length; i++) {
        let perc_la_1 = multdata[i].percent_low_access_1
        percent_la_1.push(perc_la_1)
    };

    // Define median family income from mult_geoJson
    let percent_poverty = []

    for (let i = 0; i < features.length; i++) {
      let perc_poverty = multdata[i].percent_poverty
      percent_poverty.push(perc_poverty)
    };

    // Create function for color scale
    function getColor(d) {
      return d >= 90 ? '#543005' :
             d >= 80 ? '#8c510a' :
             d >= 70 ? '#bf812d' :
             d >= 60 ? '#dfc27d' :
             d >= 50 ? '#f6e8c3' :
             d >= 40 ? '#c7eae5' :
             d >= 30 ? '#80cdc1' :
             d >= 20 ? '#35978f' :
             d >= 10 ? '#01665e' :
             d >=  0 ? '#003c30' :
                       '#1a1a1a' ;
    };

    // Create function for style of geoJson features
    function style(feature) {
      return {
          fillColor: getColor(percent_la_half[feature.properties.OBJECTID - 1]),
          fillOpacity: 0.5,
          weight: 1.5,
          opacity: 1,
          color: 'white'          
      };
    };
  
    // Create geoJson layer for map
    L.geoJson(mult_geoJson, {

      // Call the style function from above
      style: style,

      // Called on each feature
      onEachFeature: function(feature, layer) {

        // Set mouse events to change map styling
        layer.on({

          // When a user's mouse touches a map feature, that feature's opacity changes
          mouseover: function(event) {
            layer = event.target;
            layer.setStyle({
              fillOpacity: 0.6
            });
          },

          // When the cursor no longer hovers over a map feature, the feature's opacity reverts back
          mouseout: function(event) {
            layer = event.target;
            layer.setStyle({
              fillOpacity: 0.5
            });
          },

          // When a feature (census tract) is clicked, it is enlarged to fit the screen
          click: function(event) {
            myMap.fitBounds(event.target.getBounds());
          }
        });

        // Giving each feature a pop-up with information pertinent to it
        layer.bindPopup("<h5>2010 Census Data</h5>" +
                        "<p>Population: " + population_2010[feature.properties.OBJECTID - 1] + 
                        "</p><p>Median Family Income: " + family_income[feature.properties.OBJECTID - 1] + 
                        "</p><p>Pop. > Half Mile from Supermarket: " + percent_la_half[feature.properties.OBJECTID - 1] + 
                        "%</p><p>Pop. > One Mile from Supermarket: " + percent_la_1[feature.properties.OBJECTID - 1] +
                        "%</p><p>Poverty Rate: " + percent_poverty[feature.properties.OBJECTID - 1] + "%</p>");

      }

    }).addTo(myMap);

    L.control.layers(baseMaps).addTo(myMap);

    // Add a legend
    var legend = L.control({position: 'bottomright'});

    legend.onAdd = function (myMap) {

      var div = L.DomUtil.create('div', 'info legend'),
        grades = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90];

      for (var i = 0; i < grades.length; i++) {
        div.innerHTML +=
          '<i style="background:' + getColor(grades[i] + 1) + '"></i> ' +
          (grades[i]) + (grades[i + 1] ? '&ndash;' + grades[i + 1] + '%<br>' : '-100%');
      }

      return div
        
    };

    legend.addTo(myMap);

  });    

});
