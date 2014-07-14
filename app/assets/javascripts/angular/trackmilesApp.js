var app = angular.module('trackmilesApp', []);

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
        $scope.trip_dates = trip_dates;
        $scope.places = data.places;
        $scope.trips_by_date = trips_by_date;
    });
    $scope.trip_dates = [];
    $scope.trips_by_date = {};
    $scope.places = {};
}]);