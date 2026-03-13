var app = angular.module('stockApp', []);

app.controller('StockController', function($scope, $http) {
    
    $scope.sampleDate = "";
    $scope.stockList = []; 

    // Loads empty grid with material names from the DB
    $scope.loadBlankGrid = function() {
        $http.get('MaterialStockServlet?action=load')
        .then(function(response) {
            $scope.stockList = response.data;
        });
    };
    
    $scope.loadBlankGrid();

    $scope.clearForm = function() {
        $scope.sampleDate = "";
        $scope.loadBlankGrid(); 
    };

    $scope.findData = function() {
        if (!$scope.sampleDate) {
            alert("Please select a Sample Date to find data.");
            return;
        }
        $http.get('MaterialStockServlet?action=load&sampleDate=' + $scope.sampleDate)
        .then(function(response) {
            if(response.data && response.data.length > 0) {
                 $scope.stockList = response.data;
            } else {
                 alert("No data found for this date.");
                 $scope.loadBlankGrid();
            }
        });
    };

    $scope.saveData = function(actionType) {
        if (!$scope.sampleDate) {
            alert("Please select a Sample Date before saving.");
            return;
        }

        // Assign the selected date to each array element
        angular.forEach($scope.stockList, function(item) {
            item.sampleDate = $scope.sampleDate;
        });

        $http.post('MaterialStockServlet?action=' + actionType, $scope.stockList)
        .then(function(response) {
            alert(response.data.message);
        }, function(error) {
            alert("Error communicating with server.");
        });
    };

    $scope.deleteData = function() {
        if (!$scope.sampleDate) {
            alert("Select a date to delete.");
            return;
        }
        
        if (confirm("Are you sure you want to delete all stock data for " + $scope.sampleDate + "?")) {
            $http.post('MaterialStockServlet?action=delete&sampleDate=' + $scope.sampleDate)
            .then(function(response) {
                alert(response.data.message);
                if(response.data.status === 'success') {
                    $scope.clearForm();
                }
            });
        }
    };
});