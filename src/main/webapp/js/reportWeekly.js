var app = angular.module('weeklyReportApp', []);

app.controller('WeeklyReportController', function($scope, $http, $filter) {
    
    // Default values
    $scope.weekNo = 12;
    $scope.fromDate = new Date("2025-12-08");
    $scope.toDate = new Date("2025-12-14");
    
    $scope.displayFromDate = "";
    $scope.displayToDate = "";
    
    $scope.report = {};
    $scope.isDataLoaded = false;

    $scope.generateReport = function() {
        if (!$scope.fromDate || !$scope.toDate || !$scope.weekNo) {
            alert("Please fill in all search parameters.");
            return;
        }
        
        if ($scope.fromDate > $scope.toDate) {
            alert("From Date cannot be after To Date.");
            return;
        }

        var formattedFrom = $filter('date')($scope.fromDate, 'yyyy-MM-dd');
        var formattedTo = $filter('date')($scope.toDate, 'yyyy-MM-dd');
        
        $scope.displayFromDate = $filter('date')($scope.fromDate, 'dd/MM/yyyy');
        $scope.displayToDate = $filter('date')($scope.toDate, 'dd/MM/yyyy');

        var url = 'GenerateWeeklyReportServlet?weekNo=' + $scope.weekNo + 
                  '&fromDate=' + formattedFrom + '&toDate=' + formattedTo;

        $http.get(url).then(function(response) {
            if(response.data && response.data.weekNo) {
                 $scope.report = response.data;
                 $scope.isDataLoaded = true;
            } else {
                 alert("No data found for the selected period.");
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