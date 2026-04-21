var app = angular.module('rt8cApp', []);

app.controller('Rt8cReportController', function($scope, $http, $filter) {
    $scope.isDataLoaded = false;
    $scope.loading = false;
    $scope.seasonYear = "2025-2026"; 
    $scope.todayDate = new Date();

    $scope.generateReport = function() {
        if (!$scope.seasonYear) {
            alert("Please select a valid crushing season.");
            return;
        }

        $scope.loading = true;
        var params = "action=getRt8cData&seasonYear=" + encodeURIComponent($scope.seasonYear);

        $http({
            method: 'POST',
            url: 'report_rt8c.jsp',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            data: params
        }).then(function(response) {
            $scope.loading = false;
            
            if (response.data.error) {
                alert(response.data.error);
                $scope.isDataLoaded = false;
            } else {
                $scope.reportData = response.data;
                $scope.isDataLoaded = true;
            }
        }, function(error) {
            $scope.loading = false;
            console.error("AJAX Error:", error);
            alert("Failed to fetch data from the server.");
        });
    };
});