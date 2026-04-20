
app.controller('WeeklyReportController', function($scope, $http, $filter) {
    $scope.isDataLoaded = false;
    $scope.weekNo = 1;
    $scope.fromDate = new Date("2025-10-15");
    $scope.toDate = new Date("2025-10-21");

    $scope.generateReport = function() {
        $scope.loading = true;
        $scope.displayFromDate = $filter('date')($scope.fromDate, 'dd/MM/yyyy');
        $scope.displayToDate = $filter('date')($scope.toDate, 'dd/MM/yyyy');

        var params = "action=getWeeklyReport" +
            "&weekNo=" + $scope.weekNo +
            "&fromDate=" + $filter('date')($scope.fromDate, 'yyyy-MM-dd') +
            "&toDate=" + $filter('date')($scope.toDate, 'yyyy-MM-dd');

        $http({
            method: 'POST',
            url: 'report_weekly.jsp',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            data: params
        }).then(function(res) {
            $scope.loading = false;
            if (res.data.error) {
                alert(res.data.error);
            } else {
                $scope.report = res.data;
                $scope.isDataLoaded = true;
            }
        }, function(err) {
            $scope.loading = false;
            alert("Request Failed. Status: " + err.status);
        });
    };
    $scope.printReport = function() { window.print(); };
});	var app = angular.module('weeklyReportApp', []);
	app.controller('WeeklyReportController', function($scope, $http, $filter) {
	    $scope.isDataLoaded = false;
	    $scope.weekNo = 1;
	    $scope.fromDate = new Date("2025-10-15");
	    $scope.toDate = new Date("2025-10-21");

	    $scope.generateReport = function() {
	        $scope.loading = true;
	        $scope.displayFromDate = $filter('date')($scope.fromDate, 'dd/MM/yyyy');
	        $scope.displayToDate = $filter('date')($scope.toDate, 'dd/MM/yyyy');

	        var params = "action=getWeeklyReport" +
	            "&weekNo=" + $scope.weekNo +
	            "&fromDate=" + $filter('date')($scope.fromDate, 'yyyy-MM-dd') +
	            "&toDate=" + $filter('date')($scope.toDate, 'yyyy-MM-dd');

	        $http({
	            method: 'POST',
	            url: 'report_weekly.jsp',
	            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
	            data: params
	        }).then(function(res) {
	            $scope.loading = false;
	            if (res.data.error) {
	                alert(res.data.error);
	            } else {
	                $scope.report = res.data;
	                $scope.isDataLoaded = true;
	            }
	        }, function(err) {
	            $scope.loading = false;
	            alert("Request Failed. Status: " + err.status);
	        });
	    };
	    $scope.printReport = function() { window.print(); };
	});