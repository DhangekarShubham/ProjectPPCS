var app = angular.module('mfgShortApp', []);

app.controller('MfgShortController', function($scope, $http, $filter) {
    
    $scope.selectedDate = new Date(); 
    $scope.displayDate = "";
    
    $scope.reportData = {};
    $scope.isDataLoaded = false;

    $scope.generateReport = function() {
        if (!$scope.selectedDate) {
            alert("Please select a date to generate the report.");
            return;
        }

        var formattedDate = $filter('date')($scope.selectedDate, 'yyyy-MM-dd');
        $scope.displayDate = $filter('date')($scope.selectedDate, 'dd/MM/yyyy');

        $http.get('GenerateMfgShortServlet?reportDate=' + formattedDate)
        .then(function(response) {
            if(response.data && response.data.reportDate) {
                 $scope.reportData = response.data;
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