var app = angular.module('rt8cStockTransaction', []);

app.controller('Rt8cStockEntryController', ['$scope', '$http', '$filter', function($scope, $http, $filter) {
    
    // Define the Left Column Fields
    $scope.leftColumnFields = [
        {label: 'Own Estate Cane', model: 'ownEstateCane'},
        {label: 'Gate Cane', model: 'gateCane'},
        {label: 'Out Station Cane', model: 'outStationCane'},
        {label: 'Area Harvested', model: 'areaHarvested'},
        {label: 'Other than Rail Cane', model: 'otherThanRailCane'},
        {label: 'Cane Provided By Members', model: 'caneMembers'},
        {label: 'Cane Provided By Non Members', model: 'caneNonMembers'},
        {label: 'Area Under Farm', model: 'areaUnderFarm'},
        {label: 'Area Under Cane', model: 'areaUnderCane'},
        {label: 'Rori Sugar Bags', model: 'roriSugarBags'},
        {label: 'Extra Fuel Inte of Std Bag % cane', model: 'extraFuelStdBagPct'},
        {label: 'Process Steam % Cane', model: 'processSteamPct'}
    ];

    // Define the Right Column Fields
    $scope.rightColumnFields = [
        {label: 'Average Yield Per Hectare', model: 'avgYieldPerHectare'},
        {label: 'Average Yield Per Hectare Adsali', model: 'avgYieldAdsali'},
        {label: 'Average Yield Per Hectare Plant', model: 'avgYieldPlant'},
        {label: 'Average Yield Per Hectare Ratoon', model: 'avgYieldRatoon'},
        {label: 'Average Preparatory Index', model: 'avgPrepIndex'},
        {label: 'Average Temperature of Added Water', model: 'avgTempAddedWater'},
        {label: 'Bagasse used as Fuel', model: 'bagasseUsedFuel'},
        {label: 'Bagasse used for Sugar Plant', model: 'bagasseUsedSugarPlant'},
        {label: 'Bagasse used for By-Products', model: 'bagasseUsedByProducts'},
        {label: 'Bagasse used for Co-Generation', model: 'bagasseUsedCogen'},
        {label: 'Bagasse used for Oliver', model: 'bagasseUsedOliver'},
        {label: 'Bagasse Sold', model: 'bagasseSold'}
    ];

    $scope.initForm = function() {
        $scope.rt8cEntry = {
            seasonYear: "2025-2026", 
            seasonStartDate: null,
            crushingEndDate: null,
            crushingEndTime: null,
            processEndDate: null,
            processEndTime: null,
            
            data: {
                ownEstateCane: null, gateCane: null, outStationCane: null,
                areaHarvested: null, otherThanRailCane: null, caneMembers: null,
                caneNonMembers: null, areaUnderFarm: null, areaUnderCane: null,
                roriSugarBags: null, extraFuelStdBagPct: null, processSteamPct: null,
                avgYieldPerHectare: null, avgYieldAdsali: null, avgYieldPlant: null,
                avgYieldRatoon: null, avgPrepIndex: null, avgTempAddedWater: null,
                bagasseUsedFuel: null, bagasseUsedSugarPlant: null, bagasseUsedByProducts: null,
                bagasseUsedCogen: null, bagasseUsedOliver: null, bagasseSold: null
            }
        };

        if($scope.rt8cEntryForm) {
            $scope.rt8cEntryForm.$setPristine();
            $scope.rt8cEntryForm.$setUntouched();
        }
    };

    $scope.initForm();

    $scope.clearForm = function() {
        $scope.initForm();
    };

    function parseTime(timeString) {
        if (!timeString) return null;
        var d = new Date();
        var time = timeString.match(/(\d+)(?::(\d\d))?\s*(p?)/);
        if(!time) return null;
        d.setHours(parseInt(time[1]) + (time[3] ? 12 : 0));
        d.setMinutes(parseInt(time[2]) || 0);
        d.setSeconds(0, 0);
        return d;
    }

    $scope.findData = function() {
        var searchSeason = prompt("Enter Season Year to Find (e.g., 2025-2026):", $scope.rt8cEntry.seasonYear);
        if (!searchSeason) return;

        $http.get('RT8CServlet?action=find&seasonYear=' + searchSeason)
        .then(function(response) {
            if(response.data.status === 'error') {
                 alert(response.data.message);
                 $scope.clearForm();
                 $scope.rt8cEntry.seasonYear = searchSeason;
            } else {
                 $scope.rt8cEntry = response.data;
                 if(!$scope.rt8cEntry.data) $scope.rt8cEntry.data = {};
                 
                 if($scope.rt8cEntry.seasonStartDate) $scope.rt8cEntry.seasonStartDate = new Date($scope.rt8cEntry.seasonStartDate);
                 if($scope.rt8cEntry.crushingEndDate) $scope.rt8cEntry.crushingEndDate = new Date($scope.rt8cEntry.crushingEndDate);
                 if($scope.rt8cEntry.processEndDate) $scope.rt8cEntry.processEndDate = new Date($scope.rt8cEntry.processEndDate);
                 
                 if($scope.rt8cEntry.crushingEndTime) $scope.rt8cEntry.crushingEndTime = parseTime($scope.rt8cEntry.crushingEndTime);
                 if($scope.rt8cEntry.processEndTime) $scope.rt8cEntry.processEndTime = parseTime($scope.rt8cEntry.processEndTime);
            }
        }, function(error) {
            alert("Error communicating with server.");
        });
    };

    $scope.saveData = function(actionType) {
        if (!$scope.rt8cEntry.seasonYear) {
            alert("Please enter the Season Year before saving.");
            return;
        }

        var payload = angular.copy($scope.rt8cEntry);
        
        payload.seasonStartDate = $filter('date')($scope.rt8cEntry.seasonStartDate, 'yyyy-MM-dd');
        payload.crushingEndDate = $filter('date')($scope.rt8cEntry.crushingEndDate, 'yyyy-MM-dd');
        payload.processEndDate = $filter('date')($scope.rt8cEntry.processEndDate, 'yyyy-MM-dd');
        
        payload.crushingEndTime = $filter('date')($scope.rt8cEntry.crushingEndTime, 'HH:mm:ss');
        payload.processEndTime = $filter('date')($scope.rt8cEntry.processEndTime, 'HH:mm:ss');

        $http.post('RT8CServlet?action=' + actionType, payload)
        .then(function(response) {
            alert(response.data.message);
        }, function(error) {
            alert("Error communicating with server.");
        }); 
    };

    $scope.deleteData = function() {
        if (!$scope.rt8cEntry.seasonYear) {
            alert("Please specify a Season Year to delete.");
            return;
        }
        
        if (confirm("Are you sure you want to delete RT-8(C) Technical Performance data for " + $scope.rt8cEntry.seasonYear + "?")) {
            $http.post('RT8CServlet?action=delete&seasonYear=' + $scope.rt8cEntry.seasonYear)
            .then(function(response) {
                alert(response.data.message);
                if(response.data.status === 'success') {
                    $scope.clearForm();
                }
            });
        }
    };
}]);