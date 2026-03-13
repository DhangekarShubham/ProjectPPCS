var app = angular.module('rt8cApp', []);

app.controller('RT8CController', function($scope, $http) {
    
    // Initialize main data object
    $scope.rt8c = {
        seasonYear: "2025-2026"
    };

    $scope.clearForm = function() {
        $scope.rt8c = { seasonYear: "2025-2026" };
    };

    $scope.findData = function() {
        if (!$scope.rt8c.reportDate) {
            alert("Please select a Report Date to find data.");
            return;
        }
        $http.get('RT8CServlet?action=find&reportDate=' + $scope.rt8c.reportDate)
        .then(function(response) {
            if(response.data.status === 'error') {
                 alert(response.data.message);
                 var keptDate = $scope.rt8c.reportDate;
                 $scope.clearForm();
                 $scope.rt8c.reportDate = keptDate;
            } else {
                 $scope.rt8c = response.data;
            }
        });
    };

    $scope.saveData = function(actionType) {
        if (!$scope.rt8c.reportDate) {
            alert("Please select a Report Date before saving.");
            return;
        }

        $http.post('RT8CServlet?action=' + actionType, $scope.rt8c)
        .then(function(response) {
            alert(response.data.message);
        }, function(error) {
            alert("Error communicating with server.");
        });
    };

    $scope.deleteData = function() {
        if (!$scope.rt8c.reportDate) {
            alert("Select a date to delete.");
            return;
        }
        if (confirm("Are you sure you want to delete RT-8(C) data for " + $scope.rt8c.reportDate + "?")) {
            $http.post('RT8CServlet?action=delete&reportDate=' + $scope.rt8c.reportDate)
            .then(function(response) {
                alert(response.data.message);
                if(response.data.status === 'success') {
                    $scope.clearForm();
                }
            });
        }
    };

    // Calculate Average Yield
    $scope.getTotalYield = function() {
        var adsali = $scope.rt8c.yieldAdsali || 0;
        var plant = $scope.rt8c.yieldPlant || 0;
        var ratoon = $scope.rt8c.yieldRatoon || 0;
        
        var count = 0;
        if(adsali > 0) count++;
        if(plant > 0) count++;
        if(ratoon > 0) count++;

        if(count === 0) return null;
        return parseFloat(((adsali + plant + ratoon) / count).toFixed(2));
    };

    // Calculate Bagasse Saved (Total Available - Total Used)
    $scope.getBagasseSaved = function() {
        var opening = $scope.rt8c.bagasseOpening || 0;
        var prod = $scope.rt8c.bagasseProduction || 0;
        var boiler = $scope.rt8c.bagasseBoiler || 0;
        var cogen = $scope.rt8c.bagasseCogen || 0;
        var sold = $scope.rt8c.bagasseSold || 0;

        var available = opening + prod;
        var used = boiler + cogen + sold;
        
        // Prevent showing 0 when form is completely empty
        if (available === 0 && used === 0) return null;

        return parseFloat((available - used).toFixed(2));
    };
});