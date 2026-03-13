var app = angular.module('crushingApp', []);

app.controller('CrushingController', function($scope, $http) {
    
    $scope.crushing = {};

    $scope.clearForm = function() {
        $scope.crushing = {};
    };

    $scope.findData = function() {
        if (!$scope.crushing.crushDate) {
            alert("Please select a Crushing Date to find data.");
            return;
        }
        
        $http.get('CrushingServlet?action=find&crushDate=' + $scope.crushing.crushDate)
        .then(function(response) {
            if(response.data.status === 'error') {
                 alert(response.data.message);
                 var keptDate = $scope.crushing.crushDate;
                 $scope.clearForm();
                 $scope.crushing.crushDate = keptDate;
            } else {
                 $scope.crushing = response.data;
            }
        }, function(error) {
            alert("Error communicating with server.");
        });
    };

    $scope.saveData = function(actionType) {
        if (!$scope.crushing.crushDate || !$scope.crushing.cropDay) {
            alert("Please fill out the Crushing Date and Crop Day.");
            return;
        }

        $http.post('CrushingServlet?action=' + actionType, $scope.crushing)
        .then(function(response) {
            alert(response.data.message);
            if(response.data.status === 'success') {
                // Fetch the data again to populate the newly calculated "To Date" totals from the DB
                $scope.findData(); 
            }
        }, function(error) {
            alert("Error communicating with server.");
        });
    };

    $scope.deleteData = function() {
        if (!$scope.crushing.crushDate) {
            alert("Select a date to delete.");
            return;
        }
        if (confirm("Are you sure you want to delete crushing data for " + $scope.crushing.crushDate + "?")) {
            $http.post('CrushingServlet?action=delete&crushDate=' + $scope.crushing.crushDate)
            .then(function(response) {
                alert(response.data.message);
                if(response.data.status === 'success') {
                    $scope.clearForm();
                }
            });
        }
    };
});