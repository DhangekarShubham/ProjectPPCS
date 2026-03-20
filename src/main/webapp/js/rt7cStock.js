var app = angular.module('rt7cApp', []);

app.controller('RT7CController', function($scope, $http, $filter) {
    
    // 1. Initialize the massive form object
    $scope.initForm = function() {
        $scope.rt7c = {
            rt7cNumber: "",
            seasonYear: "2018-2019",
            startDate: null,
            endDate: null,
            stockDate: null,
            actualDate: null,
            screen1: {},
            screen2: {},
            screen3: {},
            screen4: {}
        };

        const screen1Mats = ['Clear Juice', 'Syrup', 'Unsulphited Syrup', 'A - Massecuite', 'B - Massecuite', 'C - Massecuite', 'Other - Massecuite', 'A - Light - Molasses', 'B - Light - Molasses', 'C - Light - Molasses', 'Other - Light - Molasses'];
        const screen2Mats = ['A - Heavy - Molasses', 'B - Heavy - Molasses', 'Other - Heavy - Molasses', 'C - seed', 'B - seed', 'Dry seed', 'C - Grain', 'B - Grain', 'Other - Molasses', 'B - After - Worker', 'C - Fore - Worker', 'Final - Molasses', 'C - After - Worker', 'Unbagged - Sugar'];
        const screen3Mats = ['Prev - Season - Material - Quantity', 'Prev - Season - Material - Brix', 'Prev - Season - Material - Pol', 'Prev - Season - Mat - FM - Brix', 'Prev - Season - Mat - FM - Pol', 'Prev - Season - Sugar - Quantity', 'Prev - Season - Sugar - Brix', 'Prev - Season - Sugar - Pol', 'Prev - Season - Sugar - FM - Brix', 'Prev - Season - Sugar - FM - Pol', 'Rs - Prc of - Material', 'Ash - Prc of - Material', 'Rs - Prc of - Sugar', 'Ash - Prc of - Sugar', 'Rori - Sugar - Quantity', 'Rori - Sugar - Pol', 'Bagasse - Saved', 'Lime - Kiln - Gas - CO2 %', 'Feed - Water - Temp', 'Feed - Water - PH', 'Clear - Juice - Temp', 'Clear - Juice - PH', 'Rs - Prc of - Raw - Sugar', 'Ash - Prc of - Raw - Sugar', 'Reducement - Sugar', 'Reducement - Material', 'Tons of - Pol in - Rori Sugar'];
        const screen4Mats = ['Prev - Brown - Sugar - Quantity', 'Prev - BISS - Sugar - Quantity', 'PSeason - Sugar - Quantity (4)', 'PSeason - Sugar - Quantity (5)', 'Prev - Season - FM of - Brow', 'Prev - Season - FM of - BISS', 'Prev - Season - FM of - (4)', 'Prev - Season - FM of - (5)', 'PAN - A', 'PAN - B', 'PAN - C', 'PAN - D'];

        // Pre-populate so Angular bounds successfully
        screen1Mats.forEach(mat => $scope.rt7c.screen1[mat] = { volume: null, brixPercent: null, polPercent: null, purityPercent: null, materialId: null });
        screen2Mats.forEach(mat => $scope.rt7c.screen2[mat] = { volume: null, brixPercent: null, polPercent: null, purityPercent: null, materialId: null });
        screen3Mats.forEach(mat => $scope.rt7c.screen3[mat] = { volume: null, materialId: null });
        screen4Mats.forEach(mat => $scope.rt7c.screen4[mat] = { volume: null, brixPercent: null, polPercent: null, purityPercent: null, materialId: null });

        if($scope.rt7Form) {
            $scope.rt7Form.$setPristine();
            $scope.rt7Form.$setUntouched();
        }
    };

    $scope.initForm();
    
    $scope.clearForm = function() { 
        $scope.initForm(); 
    };

    // 2. Auto-calculate Purity
    $scope.calculatePurity = function(rowItem) {
        if (!rowItem) return;
        if (rowItem.brixPercent > 0 && rowItem.polPercent != null) {
            rowItem.purityPercent = parseFloat(((rowItem.polPercent / rowItem.brixPercent) * 100).toFixed(3));
        } else {
            rowItem.purityPercent = null;
        }
    };

    // 3. Find Data (Un-flattens the List received from Servlet)
    $scope.findData = function() {
        var searchDate = prompt("Enter Stock Date to Find (YYYY-MM-DD):");
        if (!searchDate) return;

        // Uses your existing "load" action which returns List<RT7CStock>
        $http.get('RT7CStockServlet?action=load&stockDate=' + searchDate)
        .then(function(response) {
            var dbList = response.data;
            if(!dbList || dbList.length === 0) {
                 alert("No data found for this Date.");
                 $scope.clearForm();
                 return;
            }
            
            $scope.initForm();
            
            // FIX: Force the Stock Date UI field to display the date we just searched for.
            // This guarantees the date picker populates even if the DB returns null for the left join.
            $scope.rt7c.stockDate = new Date(searchDate); 
            
            var headersPopulated = false; // Flag to prevent overwriting headers in the loop

            // Distribute flat DB records back into the 4 screens
            angular.forEach(dbList, function(item) {
                
                // Populate global header from the first item that actually has data
                if(!headersPopulated && item.rt7cNumber) {
                    $scope.rt7c.rt7cNumber = item.rt7cNumber || "";
                    $scope.rt7c.seasonYear = item.seasonYear || "2018-2019";
                    if(item.startDate) $scope.rt7c.startDate = new Date(item.startDate);
                    if(item.endDate) $scope.rt7c.endDate = new Date(item.endDate);
                    if(item.actualDate) $scope.rt7c.actualDate = new Date(item.actualDate);
                    
                    headersPopulated = true; 
                }

                // Push data to correct tab based on material name
                var mat = item.materialName;
                if ($scope.rt7c.screen1.hasOwnProperty(mat)) {
                    $scope.rt7c.screen1[mat] = item;
                } else if ($scope.rt7c.screen2.hasOwnProperty(mat)) {
                    $scope.rt7c.screen2[mat] = item;
                } else if ($scope.rt7c.screen3.hasOwnProperty(mat)) {
                    $scope.rt7c.screen3[mat] = item;
                } else if ($scope.rt7c.screen4.hasOwnProperty(mat)) {
                    $scope.rt7c.screen4[mat] = item;
                }
            });
        }, function(error) {
            alert("Error communicating with server.");
        });
    };

    // 4. Save Data (Flattens the 4 screens into List<RT7CStock> before sending)
    $scope.saveData = function(actionType) {
        if (!$scope.rt7c.stockDate) {
            alert("Please fill out the Stock Date before saving.");
            return;
        }

        var flatPayload = [];

        // Helper to extract data from UI and attach headers + Material ID
        var addToList = function(screenObj) {
            for (var mat in screenObj) {
                flatPayload.push({
                    materialId: screenObj[mat].materialId, // Required by Java DAO
                    materialName: mat,
                    volume: screenObj[mat].volume,
                    brixPercent: screenObj[mat].brixPercent,
                    polPercent: screenObj[mat].polPercent,
                    purityPercent: screenObj[mat].purityPercent,
                    
                    // Attach global headers to every row
                    rt7cNumber: $scope.rt7c.rt7cNumber,
                    seasonYear: $scope.rt7c.seasonYear,
                    startDate: $filter('date')($scope.rt7c.startDate, 'yyyy-MM-dd'),
                    endDate: $filter('date')($scope.rt7c.endDate, 'yyyy-MM-dd'),
                    stockDate: $filter('date')($scope.rt7c.stockDate, 'yyyy-MM-dd'),
                    actualDate: $filter('date')($scope.rt7c.actualDate, 'yyyy-MM-dd')
                });
            }
        };

        // Flatten all 4 screens into the single array
        addToList($scope.rt7c.screen1);
        addToList($scope.rt7c.screen2);
        addToList($scope.rt7c.screen3);
        addToList($scope.rt7c.screen4);

        // Send standard List JSON to your Servlet
        $http.post('RT7CStockServlet?action=' + actionType, flatPayload)
        .then(function(response) {
            alert(response.data.message);
        }, function(error) {
            alert("Error communicating with server.");
        });
    };

    // 5. Delete Data (Uses stockDate)
    $scope.deleteData = function() {
        if (!$scope.rt7c.stockDate) {
            alert("Please find a record to delete first.");
            return;
        }
        
        var dateString = $filter('date')($scope.rt7c.stockDate, 'yyyy-MM-dd');
        
        if (confirm("Are you sure you want to delete RT-7(C) Data for " + dateString + "?")) {
            $http.post('RT7CStockServlet?action=delete&stockDate=' + dateString)
            .then(function(response) {
                alert(response.data.message);
                if(response.data.status === 'success') {
                    $scope.clearForm();
                }
            });
        }
    };
});