var map;
map = window.map = new GMaps({
  div: '#map',
  lat: 40.758,
  lng: -73.9794
});

var locations = JSON.parse(document.querySelector("#map").dataset.locations);

window.locations = locations;

locations.forEach(function(location) {
  if (location.latitude && location.longitude) {
    var marker = map.addMarker({
      lat: location.latitude,
      lng: location.longitude,
      title: location.address,
      infoWindow: {
        content: "<h5>" + location.name + "</h5><p>" + location.street + "<br>" + location.state + ", " + location.zip + "<br>" + location.phone + "<br> email@email.com </p><p><a href='https://maps.google.com/maps?q=" + location.address + "' target='_'>view in google maps</a></p>"
      }
    });
  }
});

var l = document.querySelector("#map").dataset.l;
var d = document.querySelector("#map").dataset.d;
if (l) {
  console.log("1  Default:::: ", default_location);
  var latlngs   = l.split(',');
  var southWest = new google.maps.LatLng(latlngs[0], latlngs[1]);
  var northEast = new google.maps.LatLng(latlngs[2], latlngs[3]);
  var bounds    = new google.maps.LatLngBounds(southWest, northEast);
  map.fitBounds(bounds, 0);
} else {
  if(d){

  }else {
    map.fitZoom();
  }
}

// document.querySelector("#redo-search").addEventListener("click", function(e) {
//   e.preventDefault();

//   var bounds = map.getBounds();
//   var location = bounds.getSouthWest().toUrlValue() + "," + bounds.getNorthEast().toUrlValue();

//   return window.open('/locations?l=' + location);
// });
