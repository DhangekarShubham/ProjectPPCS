var app = angular.module('analysisAppReport', []);

app.controller('AnalysisController', function($scope, $http, $filter) {
    
    // --- 1. INITIALIZE STATE ---
    $scope.init = function() {
        $scope.searchDate = new Date(); 
        $scope.manualDateText = $filter('date')($scope.searchDate, 'dd/MM/yyyy');
        $scope.displayDate = "";
        
        $scope.analysis = {};
        $scope.isDataLoaded = false; 
    };

    $scope.init();

    // --- 2. FORMATTING HELPERS ---
    $scope.formatNumber = function(val) {
        if (val === null || val === undefined || isNaN(val)) return '0.00';
        return parseFloat(val).toFixed(2);
    };

    $scope.formatInt = function(val) {
        if (val === null || val === undefined || isNaN(val)) return '0';
        return parseInt(val, 10).toString();
    };

    // --- 3. DATE SYNC LOGIC ---
    $scope.syncFromPicker = function() {
        if ($scope.searchDate) {
            $scope.manualDateText = $filter('date')($scope.searchDate, 'dd/MM/yyyy');
        }
    };

    $scope.syncFromText = function() {
        if ($scope.manualDateText && $scope.manualDateText.length === 10) {
            var parts = $scope.manualDateText.split('/');
            if (parts.length === 3) {
                var day = parseInt(parts[0], 10);
                var month = parseInt(parts[1], 10) - 1; 
                var year = parseInt(parts[2], 10);
                var parsedDate = new Date(year, month, day);
                
                if (!isNaN(parsedDate.getTime())) {
                    $scope.searchDate = parsedDate;
                }
            }
        }
    };

    $scope.clearForm = function() {
        $scope.init();
    };

    // --- 4. GENERATE REPORT ---
    $scope.findData = function() {
        if (!$scope.searchDate || isNaN($scope.searchDate.getTime())) {
            alert("Please enter a valid Analysis Date (DD/MM/YYYY).");
            $scope.isDataLoaded = false;
            return;
        }
        
        var dbDate = $filter('date')($scope.searchDate, 'yyyy-MM-dd');
        $scope.displayDate = $filter('date')($scope.searchDate, 'dd-MMM-yyyy').toUpperCase();
        
        // Console log to verify the URL being called
        console.log("Requesting data for URL: ReportDailyAnalysisServlet?action=find&sampleDate=" + dbDate);

        $http.get('ReportDailyAnalysisServlet?action=find&sampleDate=' + dbDate)
        .then(function(response) {
            // SUCCESSFUL HTTP CONNECTION (Status 200)
            if(response.data && response.data.status === 'success') {
                 $scope.analysis = response.data.data;
                 $scope.isDataLoaded = true;
            } else {
                 // The server replied, but with our custom JSON error message
                 alert(response.data.message || "No analytical data found for the selected date.");
                 $scope.isDataLoaded = false;
                 $scope.analysis = {}; 
            }
        }, function(error) {
            // HTTP CONNECTION FAILED (Status 404, 500, etc.)
            console.error("CRITICAL HTTP ERROR:", error);
            
            var errorAlert = "Server Error (" + error.status + "): ";
            if (error.status === 404) {
                errorAlert += "\nServlet not found! Check your @WebServlet mapping.";
            } else if (error.status === 500) {
                errorAlert += "\nJava crashed! Check the Tomcat IDE console for exceptions.";
            } else {
                errorAlert += "\nFailed to connect. Is Tomcat running?";
            }
            
            alert(errorAlert);
            $scope.isDataLoaded = false;
        });
    };

    // --- 5. PRINT REPORT ---
    $scope.printReport = function() {
        if(!$scope.isDataLoaded) {
            alert("Please generate the report first before printing.");
            return;
        }
        window.print();
    };
});