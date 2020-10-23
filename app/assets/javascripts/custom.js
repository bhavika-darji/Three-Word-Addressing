function initMap(lat,lng)
{	
	var words;
	mapboxgl.accessToken = 'pk.eyJ1IjoiYmhhdmlrYWQxNiIsImEiOiJjazJtZTljM20wNW5oM2NveTR5NjY1aG85In0.bItsLCirSaGhj37-chIK7g';
	var map = new mapboxgl.Map({
	container: 'map',
	style: 'mapbox://styles/mapbox/streets-v11',
	center: [lng,lat],
	zoom: 12
	});
	 
	var coordinatesGeocoder = function (query) {
	var matches = query.match(/\s*(?:(?:\b[a-zA-Z]+\b)[.]*){3}/);
	if (!matches) {
	return null;
	}
	words = matches.toString();
	$.getJSON('https://api.what3words.com/v3/convert-to-coordinates?words='+words+'&key=EXV04VUN', function(data) {
  	lat = `${data.coordinates.lat}`;
  	lng = `${data.coordinates.lng}`;
  });

	function coordinateFeature(lng, lat) {
	return {
	center: [lng, lat],
	geometry: {
	type: "Point",
	coordinates: [lng, lat]
	},
	place_name: words,
	place_type: ['coordinate'],
	properties: {},
	type: 'Feature'
	};
	}
	
	var geocodes = [];
	geocodes.push(coordinateFeature(lng,lat));
	return geocodes;
	};
	 
	map.addControl(new MapboxGeocoder({
	accessToken: mapboxgl.accessToken,
	localGeocoder: coordinatesGeocoder,
	zoom: 14,
	placeholder: "Search Address / 3 Words",
	mapboxgl: mapboxgl
	}));

	map.addControl(new mapboxgl.NavigationControl(), 'bottom-right');
	
	map.on('click', function (e) {
		var coord = e.lngLat;
		var threeword;
		var address;
		document.getElementById('lat').value = coord.lat;
		document.getElementById('lng').value = coord.lng;

		$.getJSON('https://api.what3words.com/v3/convert-to-3wa?coordinates='+coord.lat+'%2C'+coord.lng+'&key=EXV04VUN', function(data) {
			threeword = `${data.words}`;
			document.getElementById('3words').innerHTML = "Words: "+threeword;
			document.getElementById('wordshidden').value = threeword;
		});
		$.getJSON('https://api.mapbox.com/geocoding/v5/mapbox.places/'+coord.lng+','+coord.lat+'.json?access_token=pk.eyJ1IjoiYmhhdmlrYWQxNiIsImEiOiJjazJtZTljM20wNW5oM2NveTR5NjY1aG85In0.bItsLCirSaGhj37-chIK7g', function(data) {
			address = `${data.features[0].place_name}`;
			document.getElementById('address').innerHTML = "Address: "+address;
			document.getElementById('addresshidden').value = address;
		});
		$('#label').show();
		$('#3words').attr('data-original-title', 'Copy');
	});
}

function labelClose()
{
	$('#label').hide()
			   .tooltip('hide');
}

function CopyText() { 
  var element = document.getElementById('3words');
  var range, selection, worked;
  selection = window.getSelection();        
  range = document.createRange();
  range.selectNodeContents(element);
  selection.removeAllRanges();
  selection.addRange(range);

  document.execCommand('copy');
	$("#3words").attr('data-original-title', 'Copied').tooltip('show');
}

function initeditMap(lat,lng)
{	
	var words;
	mapboxgl.accessToken = 'pk.eyJ1IjoiYmhhdmlrYWQxNiIsImEiOiJjazJtZTljM20wNW5oM2NveTR5NjY1aG85In0.bItsLCirSaGhj37-chIK7g';
	var map = new mapboxgl.Map({
	container: 'editMap',
	style: 'mapbox://styles/mapbox/streets-v11',
	center: [lng,lat],
	zoom: 14
	});
	new mapboxgl.Marker().setLngLat([lng,lat]).addTo(map);
}