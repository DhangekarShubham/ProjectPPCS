var app = angular.module('analysisApp', []);

app.controller('AnalysisController', function($scope, $http) {
    
    // Main object to hold all form fields
    $scope.analysis = {};

    $scope.clearForm = function() {
        $scope.analysis = {};
    };

    $scope.saveData = function() {
        if (!$scope.analysis.sampleDate) {
            alert("Please select a Sample Date first.");
            return;
        }

        $http.post('DailyAnalysisServlet?action=save', $scope.analysis)
        .then(function(response) {
            alert(response.data.message);
            if(response.data.status === 'success') {
                // Keep the date but clear the rest, or clear all based on preference
                var currentData = $scope.analysis.sampleDate;
                $scope.clearForm();
                $scope.analysis.sampleDate = currentData; 
            }
        }, function(error) {
            alert("Error communicating with server.");
        });
    };

    $scope.changeData = function() {
        if (!$scope.analysis.sampleDate) {
            alert("Select date to update.");
            return;
        }
        $http.post('DailyAnalysisServlet?action=update', $scope.analysis)
        .then(function(response) {
            alert(response.data.message);
        });
    };
});