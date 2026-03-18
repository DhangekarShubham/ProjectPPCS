var app = angular.module('chemicalApp', []);

app.controller('ChemicalController', function($scope, $http) {
    alert("alert");
    $scope.sampleDate = "";
    $scope.chemicalList = [];

    // 1. LOAD BLANK GRID (Fetches Chemical names from Master)
    $scope.loadBlankGrid = function() {
        $http.get('ChemicalServlet?action=load')
        .then(function(response) {
            $scope.chemicalList = response.data;
        }, function(error) {
            console.error("Master load failed", error);
        });
    };
    
    // Initial Load
    $scope.loadBlankGrid();

    // 2. CLEAR FORM
    $scope.clearForm = function() {
        $scope.sampleDate = "";
        // Keep the master list but reset volumes
        angular.forEach($scope.chemicalList, function(chem) {
            chem.volumeConsumed = null;
        });
    };

    // 3. FIND RECORD
    $scope.findData = function() {
        if (!$scope.sampleDate) {
            alert("Please select a Consumption Date to search.");
            return;
        }

        // Format date to YYYY-MM-DD
        var formattedDate = $scope.sampleDate;
        if (formattedDate instanceof Date) {
            formattedDate = formattedDate.toISOString().split('T')[0];
        }

        $http.get('ChemicalServlet?action=find&sampleDate=' + formattedDate)
        .then(function(response) {
            if(response.data && response.data.length > 0) {
                 $scope.chemicalList = response.data;
            } else {
                 alert("No data found for the selected date.");
                 $scope.clearForm();
                 $scope.sampleDate = new Date(formattedDate);
            }
        }, function(error) {
            alert("Server error while searching.");
        });
    };

    // 4. SAVE / UPDATE
    $scope.saveData = function(actionType) {
        if (!$scope.sampleDate) {
            alert("Date is mandatory.");
            return;
        }

        var formattedDate = $scope.sampleDate;
        if (formattedDate instanceof Date) {
            formattedDate = formattedDate.toISOString().split('T')[0];
        }

        // Prepare data for backend
        var payload = {
            sampleDate: formattedDate,
            consumptions: $scope.chemicalList
        };

        $http.post('ChemicalServlet?action=' + actionType, payload)
        .then(function(response) {
            alert(response.data.message);
            if(response.data.status === 'success') {
                $scope.findData(); // Refresh to show saved state
            }
        }, function(error) {
            alert("Error communicating with server.");
        });
    };

    // 5. DELETE
    $scope.deleteData = function() {
        if (!$scope.sampleDate) {
            alert("Select a date to delete.");
            return;
        }
        
        var formattedDate = $scope.sampleDate;
        if (formattedDate instanceof Date) {
            formattedDate = formattedDate.toISOString().split('T')[0];
        }

        if (confirm("Permanently delete chemical logs for " + formattedDate + "?")) {
            $http.post('ChemicalServlet?action=delete&sampleDate=' + formattedDate)
            .then(function(response) {
                alert(response.data.message);
                if(response.data.status === 'success') {
                    $scope.clearForm();
                }
            });
        }
    };
});