var app = angular.module('rt7cStockTransaction', []);

app.controller('Rt7cStockEntryController', ['$scope', '$http', '$filter', function($scope, $http, $filter) {
    
    // 1. Initialize the form object
    $scope.initForm = function() {
        $scope.rt7cEntry = {
            rt7cNumber: "",
            seasonYear: "2025-2026",
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

        screen1Mats.forEach(mat => $scope.rt7cEntry.screen1[mat] = { volume: null, brixPercent: null, polPercent: null, purityPercent: null, materialId: null });
        screen2Mats.forEach(mat => $scope.rt7cEntry.screen2[mat] = { volume: null, brixPercent: null, polPercent: null, purityPercent: null, materialId: null });
        screen3Mats.forEach(mat => $scope.rt7cEntry.screen3[mat] = { volume: null, materialId: null });
        screen4Mats.forEach(mat => $scope.rt7cEntry.screen4[mat] = { volume: null, brixPercent: null, polPercent: null, purityPercent: null, materialId: null });

        if($scope.rt7EntryForm) {
            $scope.rt7EntryForm.$setPristine();
            $scope.rt7EntryForm.$setUntouched();
        }
    };

    $scope.initForm();
    
    $scope.clearForm = function() { 
        $scope.initForm(); 
    };

    $scope.calculatePurity = function(rowItem) {
        if (!rowItem) return;
        if (rowItem.brixPercent > 0 && rowItem.polPercent != null) {
            rowItem.purityPercent = parseFloat(((rowItem.polPercent / rowItem.brixPercent) * 100).toFixed(3));
        } else {
            rowItem.purityPercent = null;
        }
    };

    $scope.findData = function() {
        var searchDate = prompt("Enter Stock Date to Find (YYYY-MM-DD):");
        if (!searchDate) return;

        $http.get('RT7CStockServlet?action=load&stockDate=' + searchDate)
        .then(function(response) {
            var dbList = response.data;
            if(!dbList || dbList.length === 0) {
                 alert("No data found for this Date.");
                 $scope.clearForm();
                 return;
            }
            
            $scope.initForm();
            $scope.rt7cEntry.stockDate = new Date(searchDate); 
            
            var headersPopulated = false; 

            angular.forEach(dbList, function(item) {
                if(!headersPopulated && item.rt7cNumber) {
                    $scope.rt7cEntry.rt7cNumber = item.rt7cNumber || "";
                    $scope.rt7cEntry.seasonYear = item.seasonYear || "2025-2026";
                    if(item.startDate) $scope.rt7cEntry.startDate = new Date(item.startDate);
                    if(item.endDate) $scope.rt7cEntry.endDate = new Date(item.endDate);
                    if(item.actualDate) $scope.rt7cEntry.actualDate = new Date(item.actualDate);
                    headersPopulated = true; 
                }

                var mat = item.materialName;
                if ($scope.rt7cEntry.screen1.hasOwnProperty(mat)) {
                    $scope.rt7cEntry.screen1[mat] = item;
                } else if ($scope.rt7cEntry.screen2.hasOwnProperty(mat)) {
                    $scope.rt7cEntry.screen2[mat] = item;
                } else if ($scope.rt7cEntry.screen3.hasOwnProperty(mat)) {
                    $scope.rt7cEntry.screen3[mat] = item;
                } else if ($scope.rt7cEntry.screen4.hasOwnProperty(mat)) {
                    $scope.rt7cEntry.screen4[mat] = item;
                }
            });
        }, function(error) {
            alert("Error communicating with server.");
        });
    };

    $scope.saveData = function(actionType) {
        if (!$scope.rt7cEntry.stockDate) {
            alert("Please fill out the Stock Date before saving.");
            return;
        }

        var flatPayload = [];

        var addToList = function(screenObj) {
            for (var mat in screenObj) {
                if(screenObj[mat].volume !== null && screenObj[mat].volume !== "") {
                    flatPayload.push({
                        materialId: screenObj[mat].materialId, 
                        materialName: mat,
                        volume: screenObj[mat].volume,
                        brixPercent: screenObj[mat].brixPercent || 0,
                        polPercent: screenObj[mat].polPercent || 0,
                        purityPercent: screenObj[mat].purityPercent || 0,
                        
                        rt7cNumber: $scope.rt7cEntry.rt7cNumber,
                        seasonYear: $scope.rt7cEntry.seasonYear,
                        startDate: $filter('date')($scope.rt7cEntry.startDate, 'yyyy-MM-dd'),
                        endDate: $filter('date')($scope.rt7cEntry.endDate, 'yyyy-MM-dd'),
                        stockDate: $filter('date')($scope.rt7cEntry.stockDate, 'yyyy-MM-dd'),
                        actualDate: $filter('date')($scope.rt7cEntry.actualDate, 'yyyy-MM-dd')
                    });
                }
            }
        };

        addToList($scope.rt7cEntry.screen1);
        addToList($scope.rt7cEntry.screen2);
        addToList($scope.rt7cEntry.screen3);
        addToList($scope.rt7cEntry.screen4);

        if(flatPayload.length === 0) {
             alert("Please enter at least one material value before saving.");
             return;
        }

        $http.post('RT7CStockServlet?action=' + actionType, flatPayload)
        .then(function(response) {
            alert(response.data.message);
            if(response.data.status === 'success') {
                $scope.clearForm();
            }
        }, function(error) {
            alert("Error communicating with server.");
        });
    };

    $scope.deleteData = function() {
        if (!$scope.rt7cEntry.stockDate) {
            alert("Please find a record to delete first.");
            return;
        }
        
        var dateString = $filter('date')($scope.rt7cEntry.stockDate, 'yyyy-MM-dd');
        
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
}]);