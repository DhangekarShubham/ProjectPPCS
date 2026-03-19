var app = angular.module('runStockApp', []);

app.controller('RunStockController', function($scope, $http, $filter) {
    
    // 1. Initialize Form State
    $scope.initForm = function() {
        // Global Headers matching the top section
        $scope.header = {
            runNumber: "",
            seasonYear: null, // Default season
            startDate: null,
            endDate: null,
            stockDate: null,
            actualDate: null
        };
        
        // Search parameters for the bottom ribbon
        $scope.search = {
            seasonYear:null,
            runNumber: ""
        };

        $scope.stockList = [];
        
        // Reset form validation state if it exists
        if($scope.runStockForm) {
            $scope.runStockForm.$setPristine();
            $scope.runStockForm.$setUntouched();
        }
    };

    // Load empty grid on first boot
    $scope.initForm();

    // 2. Fetch Grid Data (Blank template or Existing Data)
    $scope.loadDataGrid = function(seasonParam, runParam) {
        var url = 'RunStockServlet?action=load';
        if (seasonParam && runParam) {
            url += '&seasonYear=' + encodeURIComponent(seasonParam) + '&runNumber=' + encodeURIComponent(runParam);
        }

        $http.get(url).then(function(response) {
            if (response.data.status === 'error') {
                alert(response.data.message);
                return;
            }
            
            // If data is found, populate the stock list
            $scope.stockList = response.data;
            
            // If the backend sent existing data, auto-fill the headers from the first record
            if ($scope.stockList.length > 0 && seasonParam && runParam) {
                var firstRecord = $scope.stockList[0];
                
                $scope.header.runNumber = firstRecord.runNumber || runParam;
                $scope.header.seasonYear = firstRecord.seasonYear || seasonParam;
                
                // Safely convert string dates from DB to JS Date objects for the HTML <input type="date">
                if (firstRecord.startDate) $scope.header.startDate = new Date(firstRecord.startDate);
                if (firstRecord.endDate) $scope.header.endDate = new Date(firstRecord.endDate);
                if (firstRecord.stockDate) $scope.header.stockDate = new Date(firstRecord.stockDate);
                if (firstRecord.actualDate) $scope.header.actualDate = new Date(firstRecord.actualDate);
            }
        }, function(error) {
            alert("Error communicating with server.");
        });
    };

    // Initialize blank grid on load
    $scope.loadDataGrid(null, null);

    // 3. UI Action: Clear Form
    $scope.clearForm = function() {
        $scope.initForm();
        $scope.loadDataGrid(null, null); 
    };

    // 4. UI Action: Find Data (From Top Sidebar)
    $scope.findData = function() {
        var searchSeason = prompt("Enter Season Year (e.g. 2018-2019):", $scope.header.seasonYear);
        if (!searchSeason) return;
        
        var searchRun = prompt("Enter Run Number:");
        if (!searchRun) return;

        $scope.loadDataGrid(searchSeason, searchRun);
    };

    // 5. UI Action: Find Data (From Bottom Search Ribbon)
    $scope.findDataBySearch = function() {
        if (!$scope.search.seasonYear || !$scope.search.runNumber) {
            alert("Please enter both Season Year and Run Number to search.");
            return;
        }
        $scope.loadDataGrid($scope.search.seasonYear, $scope.search.runNumber);
    };

    // 6. Auto-calculate Purity = (Pol / Brix) * 100
    $scope.calculatePurity = function(item) {
        if (item.brixPercent > 0 && item.polPercent != null) {
            var purity = (item.polPercent / item.brixPercent) * 100;
            item.purityPercent = parseFloat(purity.toFixed(3));
        } else {
            item.purityPercent = null;
        }
    };

    // 7. Save / Update Data
    $scope.saveData = function(actionType) {
        if (!$scope.header.runNumber || !$scope.header.seasonYear || !$scope.header.stockDate) {
            alert("Please fill in the Run Number, Season Year, and Stock Date before saving.");
            return;
        }

        // Format the global header dates to YYYY-MM-DD for MySQL
        var formattedStartDate = $filter('date')($scope.header.startDate, 'yyyy-MM-dd');
        var formattedEndDate = $filter('date')($scope.header.endDate, 'yyyy-MM-dd');
        var formattedStockDate = $filter('date')($scope.header.stockDate, 'yyyy-MM-dd');
        var formattedActualDate = $filter('date')($scope.header.actualDate, 'yyyy-MM-dd');

        // Create a copy of the stock list so we don't mess up the UI while formatting
        var payload = angular.copy($scope.stockList);

        // Attach the global header fields to EVERY row before sending to the backend
        // (This makes it super easy for your Java DAO to insert)
        angular.forEach(payload, function(item) {
            item.runNumber = $scope.header.runNumber;
            item.seasonYear = $scope.header.seasonYear;
            item.startDate = formattedStartDate;
            item.endDate = formattedEndDate;
            item.stockDate = formattedStockDate;
            item.actualDate = formattedActualDate;
        });

        // Send the flattened array to the Servlet
        $http.post('RunStockServlet?action=' + actionType, payload)
        .then(function(response) {
            alert(response.data.message);
        }, function(error) {
            alert("Error communicating with server.");
        });
    };

    // 8. Delete Data
    $scope.deleteData = function() {
        if (!$scope.header.seasonYear || !$scope.header.runNumber) {
            alert("Please find a specific Season Year and Run Number to delete.");
            return;
        }
        
        var confirmMsg = "Permanently delete Run Stock #" + $scope.header.runNumber + " for Season " + $scope.header.seasonYear + "?";
        
        if (confirm(confirmMsg)) {
            // Pass both identifiers so the backend deletes the correct batch
            var deleteUrl = 'RunStockServlet?action=delete&seasonYear=' + encodeURIComponent($scope.header.seasonYear) + '&runNumber=' + encodeURIComponent($scope.header.runNumber);
            
            $http.post(deleteUrl)
            .then(function(response) {
                alert(response.data.message);
                if(response.data.status === 'success') {
                    $scope.clearForm();
                }
            });
        }
    };
});