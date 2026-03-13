var app = angular.module('factoryApp', []);

app.controller('FactoryInfoController', function($scope, $http) {
    
    // The main data model object holding the form data
    $scope.factory = {}; 
    $scope.searchSeasonYear = "";

    // Clear Form (New / Cancel)
    $scope.clearForm = function() {
        $scope.factory = {};
    };

    // Save Data
    $scope.saveFactory = function() {
        $http.post('FactoryInfoServlet?action=save', $scope.factory)
        .then(function(response) {
            alert(response.data.message);
            if(response.data.status === 'success') {
                $scope.clearForm();
            }
        }, function(error) {
            alert("Error communicating with server.");
        });
    };

    // Find Data (Can be triggered by the side button or the bottom search bar)
    $scope.findFactory = function(seasonYearToSearch) {
        if(!seasonYearToSearch) {
            alert("Please enter a Season Year to search.");
            return;
        }
        $http.get('FactoryInfoServlet?action=find&seasonYear=' + seasonYearToSearch)
        .then(function(response) {
            if(response.data.status === 'error') {
                alert(response.data.message);
                $scope.clearForm();
            } else {
                $scope.factory = response.data; // Bind DB data to UI
            }
        });
    };

    // Update (Change) Data
    $scope.updateFactory = function() {
        if(!$scope.factory.seasonYear) {
            alert("Please find a record to change first.");
            return;
        }
        $http.post('FactoryInfoServlet?action=update', $scope.factory)
        .then(function(response) {
            alert(response.data.message);
        });
    };

    // Delete Data
    $scope.deleteFactory = function() {
        if(!$scope.factory.seasonYear) {
            alert("Please load a record to delete.");
            return;
        }
        if(confirm("Are you sure you want to delete data for Season: " + $scope.factory.seasonYear + "?")) {
            $http.post('FactoryInfoServlet?action=delete&seasonYear=' + $scope.factory.seasonYear)
            .then(function(response) {
                alert(response.data.message);
                if(response.data.status === 'success') {
                    $scope.clearForm();
                }
            });
        }
    };
});