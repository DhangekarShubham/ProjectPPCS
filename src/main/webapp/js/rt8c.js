// Initialize the module for the SPA architecture
var app = angular.module('rt8cApp', []);

app.controller('RT8CController', function($scope, $http, $filter) {
    
    // 1. Initialize the Form Data Structure
    $scope.initForm = function() {
        $scope.rt8c = {
            // Header Fields
            seasonYear: null, // Default matching the legacy UI
            seasonStartDate: null,
            crushingEndDate: null,
            crushingEndTime: null,
            processEndDate: null,
            processEndTime: null,
            
            // The 24 Specific Technical Fields
            data: {
                ownEstateCane: null,
                gateCane: null,
                outStationCane: null,
                areaHarvested: null,
                otherThanRailCane: null,
                caneMembers: null,
                caneNonMembers: null,
                areaUnderFarm: null,
                areaUnderCane: null,
                roriSugarBags: null,
                extraFuelStdBagPct: null,
                processSteamPct: null,
                
                avgYieldPerHectare: null,
                avgYieldAdsali: null,
                avgYieldPlant: null,
                avgYieldRatoon: null,
                avgPrepIndex: null,
                avgTempAddedWater: null,
                
                bagasseUsedFuel: null,
                bagasseUsedSugarPlant: null,
                bagasseUsedByProducts: null,
                bagasseUsedCogen: null,
                bagasseUsedOliver: null,
                bagasseSold: null
            }
        };

        // Reset form validation states if the form object exists
        if($scope.rt8cForm) {
            $scope.rt8cForm.$setPristine();
            $scope.rt8cForm.$setUntouched();
        }
    };

    // Run initialization immediately on load
    $scope.initForm();

    $scope.clearForm = function() {
        $scope.initForm();
    };

    // Helper function to safely parse time strings (HH:mm:ss) back to JS Date objects for HTML5 Time Inputs
    function parseTime(timeString) {
        if (!timeString) return null;
        var d = new Date();
        var time = timeString.match(/(\d+)(?::(\d\d))?\s*(p?)/);
        d.setHours(parseInt(time[1]) + (time[3] ? 12 : 0));
        d.setMinutes(parseInt(time[2]) || 0);
        d.setSeconds(0, 0);
        return d;
    }

    // 2. Find Data (Based on Season Year)
    $scope.findData = function() {
        var searchSeason = prompt("Enter Season Year to Find (e.g., 2018-2019):", $scope.rt8c.seasonYear);
        if (!searchSeason) return;

        $http.get('RT8CServlet?action=find&seasonYear=' + searchSeason)
        .then(function(response) {
            if(response.data.status === 'error') {
                 alert(response.data.message);
                 $scope.clearForm();
                 $scope.rt8c.seasonYear = searchSeason;
            } else {
                 // Load data from backend
                 $scope.rt8c = response.data;
                 
                 // Ensure nested data object exists
                 if(!$scope.rt8c.data) $scope.rt8c.data = {};
                 
                 // Re-format date and time strings to Date objects for HTML5 inputs
                 if($scope.rt8c.seasonStartDate) $scope.rt8c.seasonStartDate = new Date($scope.rt8c.seasonStartDate);
                 if($scope.rt8c.crushingEndDate) $scope.rt8c.crushingEndDate = new Date($scope.rt8c.crushingEndDate);
                 if($scope.rt8c.processEndDate) $scope.rt8c.processEndDate = new Date($scope.rt8c.processEndDate);
                 
                 // Parse Times
                 if($scope.rt8c.crushingEndTime) $scope.rt8c.crushingEndTime = parseTime($scope.rt8c.crushingEndTime);
                 if($scope.rt8c.processEndTime) $scope.rt8c.processEndTime = parseTime($scope.rt8c.processEndTime);
            }
        }, function(error) {
            alert("Error communicating with server.");
        });
    };

    // 3. Save or Update Data
    $scope.saveData = function(actionType) {
        if (!$scope.rt8c.seasonYear) {
            alert("Please enter the Season Year before saving.");
            return;
        }

        // Create a copy of the payload to format dates and times properly before sending to the backend
        var payload = angular.copy($scope.rt8c);
        
        payload.seasonStartDate = $filter('date')($scope.rt8c.seasonStartDate, 'yyyy-MM-dd');
        payload.crushingEndDate = $filter('date')($scope.rt8c.crushingEndDate, 'yyyy-MM-dd');
        payload.processEndDate = $filter('date')($scope.rt8c.processEndDate, 'yyyy-MM-dd');
        
        payload.crushingEndTime = $filter('date')($scope.rt8c.crushingEndTime, 'HH:mm:ss');
        payload.processEndTime = $filter('date')($scope.rt8c.processEndTime, 'HH:mm:ss');

        $http.post('RT8CServlet?action=' + actionType, payload)
        .then(function(response) {
            alert(response.data.message);
        }, function(error) {
            alert("Error communicating with server.");
        });
    };

    // 4. Delete Data
    $scope.deleteData = function() {
        if (!$scope.rt8c.seasonYear) {
            alert("Please specify a Season Year to delete.");
            return;
        }
        
        if (confirm("Are you sure you want to delete RT-8(C) Technical Performance data for " + $scope.rt8c.seasonYear + "?")) {
            // Using POST to delete by Season Year
            $http.post('RT8CServlet?action=delete&seasonYear=' + $scope.rt8c.seasonYear)
            .then(function(response) {
                alert(response.data.message);
                if(response.data.status === 'success') {
                    $scope.clearForm();
                }
            });
        }
    };
});