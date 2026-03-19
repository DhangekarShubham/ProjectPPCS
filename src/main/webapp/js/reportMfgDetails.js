var app = angular.module('mfgReportApp', []);

app.controller('MfgReportController', function($scope, $http, $filter) {
    
    // 1. Initialize State
    $scope.init = function() {
        $scope.searchDate = new Date(); 
        
        // Setup the new manual text box to format as DD/MM/YYYY by default
        $scope.manualDateText = $filter('date')($scope.searchDate, 'dd/MM/yyyy');
        
        $scope.displayDate = "";
        $scope.isDataLoaded = false;
        
        // Data Containers
        $scope.reportData = {};     
        $scope.mainList = [];       
        $scope.byproductList = [];  
        $scope.params = {};         
    };

    $scope.init();

    // --- NEW: Sync Logic between Text Box and Date Picker ---
    
    // If user clicks the calendar icon to pick a date, update the text box
    $scope.syncFromPicker = function() {
        if ($scope.searchDate) {
            $scope.manualDateText = $filter('date')($scope.searchDate, 'dd/MM/yyyy');
        }
    };

    // If user types in the text box manually (e.g. 15/10/2025), update the calendar
    $scope.syncFromText = function() {
        if ($scope.manualDateText && $scope.manualDateText.length === 10) {
            var parts = $scope.manualDateText.split('/');
            if (parts.length === 3) {
                var day = parseInt(parts[0], 10);
                var month = parseInt(parts[1], 10) - 1; // JS Months are 0-11
                var year = parseInt(parts[2], 10);
                
                var parsedDate = new Date(year, month, day);
                
                // If it's a valid date, sync it to the hidden picker
                if (!isNaN(parsedDate.getTime())) {
                    $scope.searchDate = parsedDate;
                }
            }
        }
    };

    // ---------------------------------------------------------

    // 2. Generate Report
    $scope.generateReport = function() {
        if (!$scope.searchDate) {
            alert("Please provide a valid date to generate the report.");
            return;
        }

        // Format date for MySQL (YYYY-MM-DD)
        var formattedDate = $filter('date')($scope.searchDate, 'yyyy-MM-dd');
        
        // Format date for PDF Header (DD/MM/YYYY)
        $scope.displayDate = $filter('date')($scope.searchDate, 'dd/MM/yyyy');

        $http.get('GenerateMfgDetailsServlet?reportDate=' + formattedDate)
        .then(function(response) {
            
            if (response.data && response.data.status === 'success') {
                var data = response.data.data;
                
                $scope.reportData = data.metaInfo || {};
                $scope.mainList = data.mainList || [];
                $scope.byproductList = data.byproductList || [];
                $scope.params = data.parameters || {};
                
                if ($scope.mainList.length > 0) {
                    $scope.isDataLoaded = true;
                } else {
                    alert("No laboratory or manufacturing data found for " + $scope.displayDate);
                    $scope.isDataLoaded = false;
                }
                
            } else {
                alert("Error: " + (response.data.message || "Failed to load report data."));
                $scope.isDataLoaded = false;
            }
            
        }, function(error) {
            alert("Critical Error: Could not connect to the server.");
            $scope.isDataLoaded = false;
        });
    };

    // 3. Reset the Screen
    $scope.clearReport = function() {
        $scope.init();
    };

    // 4. Print / PDF
    $scope.printReport = function() {
        if(!$scope.isDataLoaded) {
            alert("Please generate the report first.");
            return;
        }
        window.print();
    };
});