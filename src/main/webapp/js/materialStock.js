var app = angular.module('stockApp', []);

app.controller('StockController', function($scope, $http) {
    $scope.sampleDate = "";
    $scope.stockList = []; 

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
            alert("Please select a valuation date.");
            return;
        }

        var formattedDate = $scope.sampleDate;
        if (formattedDate instanceof Date) {
            formattedDate = formattedDate.toISOString().split('T')[0];
        }

        $http.get('MaterialStockServlet?action=find&sampleDate=' + formattedDate)
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
            alert("Select a date before saving.");
            return;
        }

        var formattedDate = $scope.sampleDate;
        if (formattedDate instanceof Date) {
            formattedDate = formattedDate.toISOString().split('T')[0];
        }

        // Apply date to all items in the grid
        angular.forEach($scope.stockList, function(item) {
            item.sampleDate = formattedDate;
        });

        $http.post('MaterialStockServlet?action=' + actionType, $scope.stockList)
        .then(function(response) {
            alert(response.data.message);
            if(response.data.status === 'success') {
                $scope.findData();
            }
        }, function(error) {
            alert("Error communicating with server.");
        });
    };

    $scope.deleteData = function() {
        if (!$scope.sampleDate) return;
        
        var formattedDate = $scope.sampleDate;
        if (formattedDate instanceof Date) {
            formattedDate = formattedDate.toISOString().split('T')[0];
        }

        if (confirm("Delete all stock data for " + formattedDate + "?")) {
            $http.post('MaterialStockServlet?action=delete&sampleDate=' + formattedDate)
            .then(function(response) {
                alert(response.data.message);
                if(response.data.status === 'success') {
                    $scope.clearForm();
                }
            });
        }
    };
});