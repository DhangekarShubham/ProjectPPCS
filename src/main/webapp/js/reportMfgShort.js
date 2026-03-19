var app = angular.module('mfgShortApp', []);

app.controller('MfgShortController', function($scope, $http, $filter) {
    alert("alet")
    // Initialize State
    $scope.init = function() {
        $scope.searchDate = new Date(); 
        // Set manual text box to default date format
        $scope.manualDateText = $filter('date')($scope.searchDate, 'dd/MM/yyyy');
        $scope.displayDate = "";
        $scope.reportData = {};
        // Hide report by default
        $scope.isDataLoaded = false;
    };

    $scope.init();

    // Sync from date picker to text box
    $scope.syncFromPicker = function() {
        if ($scope.searchDate) {
            $scope.manualDateText = $filter('date')($scope.searchDate, 'dd/MM/yyyy');
        }
    };

    // Sync from text box to date picker
    $scope.syncFromText = function() {
        if ($scope.manualDateText && $scope.manualDateText.length === 10) {
            var parts = $scope.manualDateText.split('/');
            if (parts.length === 3) {
                var day = parseInt(parts[0], 10);
                var month = parseInt(parts[1], 10) - 1; // Months are 0-11
                var year = parseInt(parts[2], 10);
                var parsedDate = new Date(year, month, day);
                
                if (!isNaN(parsedDate.getTime())) {
                    $scope.searchDate = parsedDate;
                }
            }
        }
    };

    $scope.generateReport = function() {
        // Validation: Check if searchDate exists and is a valid Date object
        if (!$scope.searchDate || isNaN($scope.searchDate.getTime())) {
            alert("कृपया योग्य तारीख निवडा (DD/MM/YYYY).");
            $scope.isDataLoaded = false; // Ensure report stays hidden
            return;
        }

        // Prepare parameters
        var formattedDate = $filter('date')($scope.searchDate, 'yyyy-MM-dd');
        $scope.displayDate = $filter('date')($scope.searchDate, 'dd/MM/yyyy');

        // Fetch data
        $http.get('GenerateMfgShortServlet?reportDate=' + formattedDate)
        .then(function(response) {
            // Logic to check if valid report data was returned
            // Usually check for a status property or if specific data exists
            if(response.data && response.data.status === 'success') {
                 $scope.reportData = response.data.data;
                 $scope.isDataLoaded = true; // Show the report
            } else {
                 alert("निवडलेल्या तारखेसाठी अहवाल उपलब्ध नाही.");
                 $scope.isDataLoaded = false; // Keep hidden
            }
        }, function(error) {
            alert("डेटा लोड करताना त्रुटी आली. कृपया पुन्हा प्रयत्न करा.");
            $scope.isDataLoaded = false; // Keep hidden
        });
    };

    $scope.clearReport = function() {
        $scope.init();
    };

    $scope.printReport = function() {
        if(!$scope.isDataLoaded) {
            alert("कृपया आधी अहवाल तयार करा.");
            return;
        }
        window.print();
    };
});