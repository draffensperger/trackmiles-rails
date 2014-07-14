var app = angular.module('trackmilesApp', []);

app.controller('TripsController', ['$scope', '$http', function($scope, $http) {
    $http.get('/trips.json').success(function (data) {
        $scope.trips = data['trips'];
    });
    $scope.trips = [];
}]);