var app = angular.module('rt7cApp', []);

app.controller('Rt7cReportController', function($scope, $http, $filter) {
    // Initialization
    $scope.isDataLoaded = false;
    $scope.loading = false;
    
    // Set default month to Current Month
    var d = new Date();
    $scope.inputMonth = new Date(d.getFullYear(), d.getMonth(), 1); 
    $scope.todayDate = new Date();

    $scope.generateReport = function() {
        if (!$scope.inputMonth) {
            alert("Please select a valid report month.");
            return;
        }

        $scope.loading = true;
        
        // Format date to YYYY-MM for the database query
        var formattedMonth = $filter('date')($scope.inputMonth, 'yyyy-MM');
        
        // Format date for display in the UI (e.g., "DECEMBER 2025")
        $scope.displayMonth = $filter('date')($scope.inputMonth, 'MMMM yyyy');

        var params = "action=getRt7cData&reportMonth=" + formattedMonth;

        $http({
            method: 'POST',
            url: 'report_rt7c.jsp',
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
            alert("Failed to fetch data from the server. Status: " + error.status);
        });
    };
});