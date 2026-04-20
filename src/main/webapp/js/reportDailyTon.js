var app = angular.module('dailyTonApp', []);

app.controller('DailyTonController', function($scope, $http) {

    $scope.isDataLoaded = false;

    $scope.generateReport = function() {
        if (!$scope.selectedDate) {
            alert("Please select a date");
            return;
        }

        let formattedDate = $scope.selectedDate;

        if (formattedDate instanceof Date) {
            formattedDate = formattedDate.toISOString().split('T')[0];
        }

        $http.get('GenerateDailyTonServlet?reportDate=' + formattedDate)
        .then(function(response) {

            if (!response.data || Object.keys(response.data).length === 0) {
                alert("No data found for selected date");
                return;
            }

            $scope.report = response.data;
            $scope.displayDate = formattedDate;
            $scope.isDataLoaded = true;

            calculateTotals();

        }, function(error) {
            alert("Error fetching report");
        });
    };
	$scope.testClick = function() {
	    alert("Angular is working!");
	    console.log("Button clicked successfully");
	};
    function calculateTotals() {
        let r = $scope.report;

        // Today totals
        r.totalCaneToday = r.shiftACane + r.shiftBCane + r.shiftCCane;
        r.totalHoursToday = r.shiftAHours + r.shiftBHours + r.shiftCHours;
        r.rateTotalToday = r.totalCaneToday / r.totalHoursToday;

        // Shift rates
        r.rateA = r.shiftACane / r.shiftAHours;
        r.rateB = r.shiftBCane / r.shiftBHours;
        r.rateC = r.shiftCCane / r.shiftCHours;

        // To-date rate
        r.rateTotalTodate = r.totalCaneTodate / r.totalHoursTodate;
    }

    $scope.printReport = function() {
        window.print();
    };

});