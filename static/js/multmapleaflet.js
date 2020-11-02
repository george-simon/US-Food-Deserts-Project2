// Create map object
var myMap = L.map("map", {
    center: [45.5245, -122.6550],
    zoom: 11.5
  });

// Add tile layer to the map
var streetmap = L.tileLayer("https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}", {
  attribution: "© <a href='https://www.mapbox.com/about/maps/'>Mapbox</a> © <a href='http://www.openstreetmap.org/copyright'>OpenStreetMap</a> <strong><a href='https://www.mapbox.com/map-feedback/' target='_blank'>Improve this map</a></strong>",
  tileSize: 512,
  maxZoom: 18,
  zoomOffset: -1,
  id: "mapbox/streets-v11",
  accessToken: API_KEY
}).addTo(myMap);

var lightmap = L.tileLayer("https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}", {
  attribution: "Map data &copy; <a href=\"https://www.openstreetmap.org/\">OpenStreetMap</a> contributors, <a href=\"https://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>, Imagery © <a href=\"https://www.mapbox.com/\">Mapbox</a>",
  maxZoom: 18,
  id: "mapbox/light-v10",
  accessToken: API_KEY
});

var darkmap = L.tileLayer("https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}", {
  attribution: "Map data &copy; <a href=\"https://www.openstreetmap.org/\">OpenStreetMap</a> contributors, <a href=\"https://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>, Imagery © <a href=\"https://www.mapbox.com/\">Mapbox</a>",
  maxZoom: 18,
  id: "mapbox/dark-v10",
  accessToken: API_KEY
});

// Create a baseMaps object
var baseMaps = {
  "Street Map": streetmap,
  "Light Map": lightmap,
  "Dark Map": darkmap
};

// Grab data with d3
let mult_geoJson = "../static/js/outline_mult.geojson";

d3.json("/api/v1.0/multdata").then(multdata => {

  console.log(multdata)

  d3.json(mult_geoJson).then(mult_geoJson => {
    
    // Define features from mult_geoJson
    let features = mult_geoJson.features
    console.log(features)
    
    // Define fips from mult_geoJson
    let fips = []

    for (let i = 0; i < features.length; i++) {
      let fip = features[i].properties.FIPS
      fips.push(fip)
    };

    console.log(fips)

    // Define census_tracts from multdata
    let census_tracts = []

    for (let i = 0; i < multdata.length; i++) {
      let census_tract = multdata[i].census_tract.toString()
      census_tracts.push(census_tract)
    };

    console.log(census_tracts)

    // Define percent_la_half from multdata
    let percent_la_half = [];

    for (let i = 0; i < multdata.length; i++) {
        let perc_la_half = multdata[i].percent_low_access_half
        percent_la_half.push(perc_la_half)
    };

    console.log(percent_la_half)

    // Define percent_renters from mult_geoJson
    let percent_renters = []

    for (let i = 0; i < features.length; i++) {
      let perc_renters = features[i].properties.Perc_renters
      percent_renters.push(perc_renters)
    };

    // Create function for color scale
    function getColor(d) {
      return d >= 89 ? '#a50026' :
             d >= 79 ? '#d73027' :
             d >= 69 ? '#f46d43' :
             d >= 59 ? '#fdae61' :
             d >= 49 ? '#fee08b' :
             d >= 39 ? '#d9ef8b' :
             d >= 29 ? '#a6d96a' :
             d >= 19 ? '#66bd63' :
             d >=  9 ? '#1a9850' :
             d >= -1 ? '#006837' :
                       '#1a1a1a' ;
    };

    function style(feature) {
      return {
          fillColor: getColor(percent_la_half[feature.properties.OBJECTID - 1]),
          fillOpacity: 0.5,
          weight: 1.5,
          opacity: 1,
          color: 'white'          
      };
    }
  
    L.geoJson(mult_geoJson, {

      style: style,

      // Called on each feature
      onEachFeature: function(feature, layer) {
        // Set mouse events to change map styling
        layer.on({
          // When a user's mouse touches a map feature, the mouseover event calls this function, that feature's opacity changes
          mouseover: function(event) {
            layer = event.target;
            layer.setStyle({
              fillOpacity: 0.6
            });
          },
          // When the cursor no longer hovers over a map feature - when the mouseout event occurs - the feature's opacity reverts back
          mouseout: function(event) {
            layer = event.target;
            layer.setStyle({
              fillOpacity: 0.3
            });
          },
          // When a feature (neighborhood) is clicked, it is enlarged to fit the screen
          click: function(event) {
            myMap.fitBounds(event.target.getBounds());
          }
        });
        // Giving each feature a pop-up with information pertinent to it
        layer.bindPopup("<p>Renters: " + Math.round(feature.properties.Perc_renters) + "%</p> <hr> <h2>" + percent_la_half[feature.properties.OBJECTID - 1] + "</h2>");

      }

    }).addTo(myMap);

    L.control.layers(baseMaps).addTo(myMap);

    // Add a legend
    var legend = L.control({position: 'bottomright'});

    legend.onAdd = function (myMap) {

      var div = L.DomUtil.create('div', 'info legend'),
        grades = [-1, 9, 19, 29, 39, 49, 59, 69, 79, 89];

      for (var i = 0; i < grades.length; i++) {
        console.log(getColor(grades[i]))
        div.innerHTML +=
          // '<i style="background:' + getColor(grades[i] + 1) + '"></i> ' +
          (grades[i] + 1) + (grades[i + 1] ? '&ndash;' + grades[i + 1] + '<br>' : '+');
      }

      return div
        
    };

    legend.addTo(myMap);

  });    

});