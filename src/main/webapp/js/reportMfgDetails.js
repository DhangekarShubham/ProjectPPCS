var app = angular.module('mfgReportApp', []);

app.controller('MfgReportController', function($scope, $http, $filter) {
    
    // Default to today's date
    $scope.selectedDate = new Date(); 
    $scope.displayDate = "";
    
    $scope.reportDataList = [];
    $scope.isDataLoaded = false;

    $scope.generateReport = function() {
        if (!$scope.selectedDate) {
            alert("Please select a date to generate the report.");
            return;
        }

        // Format date to YYYY-MM-DD for the backend
        var formattedDate = $filter('date')($scope.selectedDate, 'yyyy-MM-dd');
        
        // Format date to DD/MM/YYYY for the printable header
        $scope.displayDate = $filter('date')($scope.selectedDate, 'dd/MM/yyyy');

        $http.get('GenerateMfgDetailsServlet?reportDate=' + formattedDate)
        .then(function(response) {
            $scope.reportDataList = response.data;
            
            if($scope.reportDataList.length > 0) {
                 $scope.isDataLoaded = true;
            } else {
                 alert("No data found for the selected date.");
                 $scope.isDataLoaded = false;
            }
        }, function(error) {
            alert("Error fetching report data.");
            $scope.isDataLoaded = false;
        });
    };

    $scope.printReport = function() {
        if(!$scope.isDataLoaded) {
            alert("Please generate the report first.");
            return;
        }
        window.print();
    };
});