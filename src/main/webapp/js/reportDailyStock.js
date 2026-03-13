var app = angular.module('stockReportApp', []);

app.controller('StockReportController', function($scope, $http, $filter) {
    
    $scope.selectedDate = new Date(); 
    $scope.displayDate = "";
    
    $scope.sugarList = [];
    $scope.byProductList = [];
    $scope.totals = {};
    
    $scope.isDataLoaded = false;

    $scope.generateReport = function() {
        if (!$scope.selectedDate) {
            alert("Please select a date to generate the report.");
            return;
        }

        var formattedDate = $filter('date')($scope.selectedDate, 'yyyy-MM-dd');
        $scope.displayDate = $filter('date')($scope.selectedDate, 'dd/MM/yyyy');

        $http.get('GenerateDailyStockServlet?reportDate=' + formattedDate)
        .then(function(response) {
            var fullData = response.data;
            
            $scope.sugarList = [];
            $scope.byProductList = [];
            
            // Reset Totals
            $scope.totals = {
                opening: 0,
                prod: 0,
                dispatch: 0,
                closing: 0
            };

            if(fullData && fullData.length > 0) {
                 
                 angular.forEach(fullData, function(row) {
                     if (row.category === 'SUGAR_GRADE') {
                         $scope.sugarList.push(row);
                         // Accumulate sugar totals
                         $scope.totals.opening += row.openingBalance;
                         $scope.totals.prod += row.productionToday;
                         $scope.totals.dispatch += row.dispatchSale;
                         $scope.totals.closing += row.closingBalance;
                     } else {
                         $scope.byProductList.push(row);
                     }
                 });
                 
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