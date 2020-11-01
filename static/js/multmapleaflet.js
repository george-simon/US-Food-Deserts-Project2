// Create map object
var myMap = L.map("map", {
    center: [45.5245, -122.6550],
    zoom: 11.5
  });

// Add tile layer to the map
L.tileLayer("https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}", {
  attribution: "© <a href='https://www.mapbox.com/about/maps/'>Mapbox</a> © <a href='http://www.openstreetmap.org/copyright'>OpenStreetMap</a> <strong><a href='https://www.mapbox.com/map-feedback/' target='_blank'>Improve this map</a></strong>",
  tileSize: 512,
  maxZoom: 18,
  zoomOffset: -1,
  id: "mapbox/light-v10",
  accessToken: API_KEY
}).addTo(myMap);

// Grab data with d3
let mult_geoJson = "../static/js/outline_mult.geojson";

d3.json("/api/v1.0/multdata").then(data => {

  // console.log(data)

  d3.json(mult_geoJson).then(data => {

    L.geoJson(data, {

      style: function(feature) {
        return {
          color: "white",
          // ENTER DATA HERE
          fillColor: "black",
          fillOpacity: 0.3,
          weight: 1.5
        };
      },

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
        layer.bindPopup("<p>Renters: " + Math.round(feature.properties.Perc_renters) + "%</p> <hr> <h2>" + "(variable here)" + "</h2>");

      }

    }).addTo(myMap)
  });

});
