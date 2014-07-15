var app = angular.module('trackmilesApp', ['trackmilesFilters']);

app.controller('TripsController', ['$scope', '$http', '$filter', function($scope, $http, $filter) {
    $http.get('/trips.json').success(function (data) {
        trips = data.trips;
        var trips_by_date = {};
        var trip_dates = [];
        for (var i = 0; i < trips.length; i++) {
            var date = $filter('date')(trips[i]['start_time'], 'fullDate');
            if (date in trips_by_date) {
                trips_by_date[date].push(trips[i]);
            } else {
                trips_by_date[date] = [trips[i]];
                trip_dates.push(date);
            }
        }
        trip_dates = trip_dates.sort(function(a,b) {return new Date(b) - new Date(a)});
        $scope.trip_dates = trip_dates;
        $scope.trips_by_date = trips_by_date;

        var places_by_id = {};
        var places = data.places;
        for (var i = 0; i < places.length; i++) {
            places_by_id[places[i].id] = places[i];
        }
        $scope.places_by_id = places_by_id;
    });

    this.formatTripTimes = function(trip) {
        var startTime = $filter('date')(trip.start_time, 'h:mm');
        var startTimeMeridian = $filter('date')(trip.start_time, 'a').toLowerCase().substring(0,1);
        var endTime = $filter('date')(trip.end_time, 'h:mm');
        var endTimeMeridian = $filter('date')(trip.end_time, 'a').toLowerCase().substring(0,1);

        var sep = '\u2009-\u2009';
        if (startTimeMeridian === endTimeMeridian) {
            return startTime + sep + endTime + endTimeMeridian;
        } else {
            return startTime + startTimeMeridian + sep + endTime + endTimeMeridian;
        }

    };

    $scope.showMapStart = function(trip) {
        $scope.showTrip(trip, true);
    };
    $scope.showMapEnd = function(trip) {
        $scope.showTrip(trip, false);
    };

    $scope.showTrip = function(trip, focusOnStart) {
        var start = $scope.places_by_id[trip.start_place_id];
        var end = $scope.places_by_id[trip.end_place_id];

        /*
        if ($scope.startMarker) {
            $scope.map.removeLayer($scope.startMarker);
        }
        $scope.startMarker = L.marker([start.latitude, start.longitude], {title: start.summary});
        $scope.startMarker.addTo($scope.map);
        */

        if ($scope.endMarker) {
            $scope.map.removeLayer($scope.endMarker);
        }
        $scope.endMarker = L.marker([end.latitude, end.longitude], {title: end.summary});
        $scope.endMarker.addTo($scope.map);

        if ($scope.line) {
            $scope.map.removeLayer($scope.line);
        }
        $scope.line = L.polyline([new L.LatLng(start.latitude, start.longitude),
             new L.LatLng(end.latitude, end.longitude)]);
        $scope.line.addTo($scope.map);

        $scope.map.fitBounds([[start.latitude, start.longitude],
            [end.latitude, end.longitude]]);
    };

    $scope.map = new L.Map('map');
    var osmUrl='http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
    var osmAttrib='Map data © <a href="http://openstreetmap.org">OpenStreetMap</a> contributors';
    var osm = new L.TileLayer(osmUrl, {minZoom: 4, maxZoom: 16, attribution: osmAttrib});
    $scope.map.setView(new L.LatLng(51.3, 0.7),9);
    $scope.map.addLayer(osm);

    $scope.trip_dates = [];
    $scope.trips_by_date = {};
    $scope.places_by_id = {};
}]);

angular.module('trackmilesFilters', []).filter('cutright', function() {
    return function(input, len) {
        return input.substring(0, input.length - len);
    };
});