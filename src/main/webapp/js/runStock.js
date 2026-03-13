var app = angular.module('runStockApp', []);

app.controller('RunStockController', function($scope, $http) {
    
    $scope.sampleDate = "";
    $scope.stockList = []; 

    // Fetches the grid. If no date is passed, it returns the empty template from DB
    $scope.loadDataGrid = function(dateParam) {
        var url = 'RunStockServlet?action=load';
        if(dateParam) url += '&sampleDate=' + dateParam;

        $http.get(url).then(function(response) {
            $scope.stockList = response.data;
        });
    };
    
    // Initialize blank grid on load
    $scope.loadDataGrid(null);

    $scope.clearForm = function() {
        $scope.sampleDate = "";
        $scope.loadDataGrid(null); 
    };

    $scope.findData = function() {
        if (!$scope.sampleDate) {
            alert("Please select a Sample Date to find data.");
            return;
        }
        $scope.loadDataGrid($scope.sampleDate);
    };

    // Auto-calculate Purity = (Pol / Brix) * 100
    $scope.calculatePurity = function(item) {
        if (item.brixPercent > 0 && item.polPercent != null) {
            var purity = (item.polPercent / item.brixPercent) * 100;
            item.purityPercent = parseFloat(purity.toFixed(2));
        } else {
            item.purityPercent = null;
        }
    };

    $scope.saveData = function(actionType) {
        if (!$scope.sampleDate) {
            alert("Please select a Sample Date before saving.");
            return;
        }

        // Apply the selected date to every object in the array
        angular.forEach($scope.stockList, function(item) {
            item.sampleDate = $scope.sampleDate;
        });

        $http.post('RunStockServlet?action=' + actionType, $scope.stockList)
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
        if (confirm("Are you sure you want to delete all Run Stock data for " + $scope.sampleDate + "?")) {
            $http.post('RunStockServlet?action=delete&sampleDate=' + $scope.sampleDate)
            .then(function(response) {
                alert(response.data.message);
                if(response.data.status === 'success') {
                    $scope.clearForm();
                }
            });
        }
    };
});