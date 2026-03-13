var app = angular.module('stoppageApp', []);

app.controller('StoppageController', function($scope, $http) {
    
    $scope.stoppage = {
        categoryCode: "MECHANICAL" // Default selection
    };
    
    $scope.searchStoppageId = "";

    $scope.clearForm = function() {
        $scope.stoppage = { categoryCode: "MECHANICAL" };
        $scope.searchStoppageId = "";
    };

    $scope.saveData = function(actionType) {
        if (!$scope.stoppage.stoppageDate || !$scope.stoppage.totalTime) {
            alert("Please fill in Date and Total Time.");
            return;
        }

        $http.post('StoppageServlet?action=' + actionType, $scope.stoppage)
        .then(function(response) {
            alert(response.data.message);
            if(response.data.status === 'success') {
                // Update UI with the auto-generated ID from the server
                $scope.stoppage.stoppageId = response.data.data.stoppageId;
            }
        }, function(error) {
            alert("Error communicating with server.");
        });
    };

    $scope.findData = function() {
        var idToSearch = prompt("Enter Stoppage Number to Find:");
        if (!idToSearch) return;

        $http.get('StoppageServlet?action=find&stoppageId=' + idToSearch)
        .then(function(response) {
            if(response.data.status === 'error') {
                 alert(response.data.message);
                 $scope.clearForm();
            } else {
                 $scope.stoppage = response.data;
            }
        });
    };

    $scope.deleteData = function() {
        if (!$scope.stoppage.stoppageId) {
            alert("Find a record to delete first.");
            return;
        }
        
        if (confirm("Are you sure you want to delete Stoppage #" + $scope.stoppage.stoppageId + "?")) {
            $http.post('StoppageServlet?action=delete&stoppageId=' + $scope.stoppage.stoppageId)
            .then(function(response) {
                alert(response.data.message);
                if(response.data.status === 'success') {
                    $scope.clearForm();
                }
            });
        }
    };
});