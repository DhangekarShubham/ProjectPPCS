var app = angular.module('chemicalApp', []);

app.controller('ChemicalController', function($scope, $http) {
    
    $scope.sampleDate = "";
    $scope.chemicalList = []; // This array will hold the grid data

    // Initialize the grid with empty chemical names on page load
    $scope.loadBlankGrid = function() {
        $http.get('ChemicalServlet?action=load')
        .then(function(response) {
            $scope.chemicalList = response.data;
        });
    };
    
    // Call on page load
    $scope.loadBlankGrid();

    // Clear Form (New / Cancel)
    $scope.clearForm = function() {
        $scope.sampleDate = "";
        $scope.loadBlankGrid(); // Reset grid volumes to blank
    };

    // Find saved data for a specific date
    $scope.findData = function() {
        if (!$scope.sampleDate) {
            alert("Please select a Sample Date to find data.");
            return;
        }
        $http.get('ChemicalServlet?action=load&sampleDate=' + $scope.sampleDate)
        .then(function(response) {
            if(response.data && response.data.length > 0) {
                 $scope.chemicalList = response.data;
            } else {
                 alert("No data found for this date.");
            }
        });
    };

    // Save or Update Data
    $scope.saveData = function(actionType) {
        if (!$scope.sampleDate) {
            alert("Please select a Sample Date before saving.");
            return;
        }

        // Attach the selected date to every object in the list before sending to backend
        angular.forEach($scope.chemicalList, function(chem) {
            chem.sampleDate = $scope.sampleDate;
        });

        $http.post('ChemicalServlet?action=' + actionType, $scope.chemicalList)
        .then(function(response) {
            alert(response.data.message);
        }, function(error) {
            alert("Error communicating with server.");
        });
    };

    // Delete Data
    $scope.deleteData = function() {
        if (!$scope.sampleDate) {
            alert("Select a date to delete.");
            return;
        }
        
        if (confirm("Are you sure you want to delete all chemical consumption data for " + $scope.sampleDate + "?")) {
            $http.post('ChemicalServlet?action=delete&sampleDate=' + $scope.sampleDate)
            .then(function(response) {
                alert(response.data.message);
                if(response.data.status === 'success') {
                    $scope.clearForm();
                }
            });
        }
    };
});