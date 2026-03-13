var app = angular.module('rt7cApp', []);

app.controller('RT7CController', function($scope, $http) {
    
    $scope.stockDate = "";
    $scope.reportMonth = "";
    
    // Arrays for different tabs
    $scope.processList = []; 
    $scope.sugarList = [];
    $scope.oldStockList = [];

    // Load initial empty grid from database master
    $scope.loadDataGrid = function(dateParam) {
        var url = 'RT7CStockServlet?action=load';
        if(dateParam) url += '&stockDate=' + dateParam;

        $http.get(url)
        .then(function(response) {
            var allData = response.data;
            // Clear existing
            $scope.processList = []; $scope.sugarList = []; $scope.oldStockList = [];
            
            // Categorize data based on the tabCategory property from the backend
            angular.forEach(allData, function(item) {
                if (item.tabCategory === 'PROCESS') $scope.processList.push(item);
                else if (item.tabCategory === 'SUGAR') $scope.sugarList.push(item);
                else if (item.tabCategory === 'OLD') $scope.oldStockList.push(item);
            });
        });
    };
    
    $scope.loadDataGrid(null); // Load blank template on init

    $scope.clearForm = function() {
        $scope.stockDate = "";
        $scope.reportMonth = "";
        $scope.loadDataGrid(null); 
    };

    $scope.findData = function() {
        if (!$scope.stockDate) {
            alert("Please select a Stock Date to find data.");
            return;
        }
        $scope.loadDataGrid($scope.stockDate);
    };

    // Auto-calculate Purity = (Pol / Brix) * 100
    $scope.calculatePurity = function(item) {
        if (item.brixPercent > 0 && item.polPercent != null) {
            item.purityPercent = parseFloat(((item.polPercent / item.brixPercent) * 100).toFixed(2));
        } else {
            item.purityPercent = null;
        }
    };
    
    // Auto-calculate Total Sugar for Old Stock
    $scope.calculateOldSugar = function(item) {
        if(item.quantity > 0 && item.polPercent > 0) {
            item.volume = parseFloat(((item.quantity * item.polPercent) / 100).toFixed(3)); // Reusing 'volume' field to hold total calculated sugar to save db space
        } else {
            item.volume = null;
        }
    };

    $scope.saveData = function(actionType) {
        if (!$scope.stockDate || !$scope.reportMonth) {
            alert("Please select a Stock Date and Report Month before saving.");
            return;
        }

        // Combine all arrays into one payload
        var payload = $scope.processList.concat($scope.sugarList).concat($scope.oldStockList);
        
        angular.forEach(payload, function(item) {
            item.stockDate = $scope.stockDate;
            item.reportMonth = $scope.reportMonth;
        });

        $http.post('RT7CStockServlet?action=' + actionType, payload)
        .then(function(response) {
            alert(response.data.message);
        }, function(error) {
            alert("Error communicating with server.");
        });
    };

    $scope.deleteData = function() {
        if (!$scope.stockDate) {
            alert("Select a date to delete.");
            return;
        }
        if (confirm("Are you sure you want to delete all RT-7(C) stock data for " + $scope.stockDate + "?")) {
            $http.post('RT7CStockServlet?action=delete&stockDate=' + $scope.stockDate)
            .then(function(response) {
                alert(response.data.message);
                if(response.data.status === 'success') {
                    $scope.clearForm();
                }
            });
        }
    };
});