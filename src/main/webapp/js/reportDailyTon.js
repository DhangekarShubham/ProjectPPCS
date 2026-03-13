var app = angular.module('dailyTonApp', []);

app.controller('DailyTonController', function($scope, $http, $filter) {
    
    $scope.selectedDate = new Date(); 
    $scope.displayDate = "";
    
    $scope.report = {};
    $scope.isDataLoaded = false;

    $scope.generateReport = function() {
        if (!$scope.selectedDate) {
            alert("Please select a date to generate the report.");
            return;
        }

        var formattedDate = $filter('date')($scope.selectedDate, 'yyyy-MM-dd');
        $scope.displayDate = $filter('date')($scope.selectedDate, 'dd/MM/yyyy');

        $http.get('GenerateDailyTonServlet?reportDate=' + formattedDate)
        .then(function(response) {
            if(response.data && response.data.reportDate) {
                 $scope.report = response.data;
                 
                 // --- Client-Side Calculations ---
                 
                 // Shift Today Totals
                 $scope.report.totalCaneToday = ($scope.report.shiftACane || 0) + ($scope.report.shiftBCane || 0) + ($scope.report.shiftCCane || 0);
                 $scope.report.totalHoursToday = ($scope.report.shiftAHours || 0) + ($scope.report.shiftBHours || 0) + ($scope.report.shiftCHours || 0);
                 
                 // To-Date Cane Total (From Source logic)
                 $scope.report.totalCaneTodate = ($scope.report.memberCaneTodate || 0) + ($scope.report.nonMemberCaneTodate || 0);
                 
                 // Crushing Rates (MT / Hr)
                 $scope.report.rateA = $scope.report.shiftAHours > 0 ? ($scope.report.shiftACane / $scope.report.shiftAHours) : 0;
                 $scope.report.rateB = $scope.report.shiftBHours > 0 ? ($scope.report.shiftBCane / $scope.report.shiftBHours) : 0;
                 $scope.report.rateC = $scope.report.shiftCHours > 0 ? ($scope.report.shiftCCane / $scope.report.shiftCHours) : 0;
                 
                 $scope.report.rateTotalToday = $scope.report.totalHoursToday > 0 ? ($scope.report.totalCaneToday / $scope.report.totalHoursToday) : 0;
                 $scope.report.rateTotalTodate = $scope.report.totalHoursTodate > 0 ? ($scope.report.totalCaneTodate / $scope.report.totalHoursTodate) : 0;

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