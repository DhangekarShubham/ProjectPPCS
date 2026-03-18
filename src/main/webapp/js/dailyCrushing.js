var app = angular.module('crushingApp', []);

app.controller('CrushingController', function($scope, $http) {
    
    // UI state variable for the hidden find bar
    $scope.showFindBar = false; 

    // Clear Form (New / Cancel) and explicitly set all new fields to null/empty
    $scope.clearForm = function() {
        $scope.crushing = {
            crushDate: '',
            cropDay: null,
            caneOnDate: null,
            caneToDate: null,
            sugarOnDate: null,
            sugarToDate: null,
            percentOnDate: null,
            percentToDate: null,
            millExtOnDate: null,
            millExtToDate: null,
            reducedExtOnDate: null,
            reducedExtToDate: null,
            millStartOnDate: '',
            millStartToDate: '',
            cogenOnDate: null,
            cogenToDate: null
        };
    };

    // Run clearForm on initial load to set up the two-way binding perfectly
    $scope.clearForm();

    // Find Data (Can be triggered by the side button or the bottom search bar)
    $scope.findData = function() {
        if (!$scope.crushing.crushDate) {
            alert("Please enter a Crushing Date to find data.");
            return;
        }
        
        $http.get('CrushingServlet?action=find&crushDate=' + $scope.crushing.crushDate)
        .then(function(response) {
            if(response.data.status === 'error') {
                 alert(response.data.message);
                 var keptDate = $scope.crushing.crushDate;
                 $scope.clearForm();
                 $scope.crushing.crushDate = keptDate;
            } else {
                 $scope.crushing = response.data;
                 $scope.showFindBar = false; // Close the find bar upon success
            }
        }, function(error) {
            alert("Error communicating with server.");
        });
    };

    // Save or Update Data
    $scope.saveData = function(actionType) {
        if (!$scope.crushing.crushDate || !$scope.crushing.cropDay) {
            alert("Please fill out the Crushing Date and Crop Day.");
            return;
        }

        $http.post('CrushingServlet?action=' + actionType, $scope.crushing)
        .then(function(response) {
            alert(response.data.message);
            if(response.data.status === 'success') {
                // Fetch the data again to populate the newly calculated "To Date" totals from the DB
                $scope.findData(); 
            }
        }, function(error) {
            alert("Error communicating with server.");
        });
    };

    // Delete Data
    $scope.deleteData = function() {
        if (!$scope.crushing.crushDate) {
            alert("Select a date to delete.");
            return;
        }
        if (confirm("Are you sure you want to delete crushing data for " + $scope.crushing.crushDate + "?")) {
            $http.post('CrushingServlet?action=delete&crushDate=' + $scope.crushing.crushDate)
            .then(function(response) {
                alert(response.data.message);
                if(response.data.status === 'success') {
                    $scope.clearForm();
                }
            });
        }
    };
});