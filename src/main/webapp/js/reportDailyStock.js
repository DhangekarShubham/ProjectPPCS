// स्वतःचे स्वतंत्र Module तयार करणे
var app = angular.module('stockReportApp', []);

// Controller थेट याच Module ला जोडणे (sugarErpApp ला नाही)
app.controller('StockReportController', ['$scope', '$http', '$filter', function($scope, $http, $filter) {
    console.log("Stock Report Controller loaded ✅");
    
    $scope.selectedDate = new Date(); 
    $scope.displayDate = "";
    
    $scope.sugarList = [];
    $scope.byProductList = [];
    $scope.totals = {};
    
    $scope.isDataLoaded = false;
    
    $scope.testClick = function() {
        alert("Angular Working ✅");
    };

    $scope.generateReport = function() {
        if (!$scope.selectedDate) {
            alert("Please select a date to generate the report.");
            return;
        }

        var formattedDate = $filter('date')($scope.selectedDate, 'yyyy-MM-dd');
        $scope.displayDate = $filter('date')($scope.selectedDate, 'dd/MM/yyyy');

        $scope.isDataLoaded = false; // Reset before loading

        $http.get('GenerateDailyStockServlet?reportDate=' + formattedDate)
        .then(function(response) {
            var fullData = response.data;
            
            $scope.sugarList = [];
            $scope.byProductList = [];
            
            $scope.totals = { opening: 0, prod: 0, dispatch: 0, closing: 0 };

            if(fullData && fullData.length > 0) {
                 angular.forEach(fullData, function(row) {
                     if (row.category === 'SUGAR_GRADE') {
                         $scope.sugarList.push(row);
                         $scope.totals.opening += (row.openingBalance || 0);
                         $scope.totals.prod += (row.productionToday || 0);
                         $scope.totals.dispatch += (row.dispatchSale || 0);
                         $scope.totals.closing += (row.closingBalance || 0);
                     } else {
                         $scope.byProductList.push(row);
                     }
                 });
                 $scope.isDataLoaded = true;
            } else {
                 alert("No data found for the selected date.");
            }
        }, function(error) {
            alert("Error fetching report data. Is the backend running?");
        });
    };

    $scope.printReport = function() {
        if(!$scope.isDataLoaded) {
            alert("Please generate the report first.");
            return;
        }
        window.print();
    };

    $scope.clearReport = function() {
        $scope.isDataLoaded = false;
        $scope.sugarList = [];
        $scope.byProductList = [];
    };
}]);