var app = angular.module('stoppageApp', []);

app.controller('StoppageController', function($scope, $http) {
    
    $scope.stoppage = {
        categoryCode: "MECHANICAL"
    };

    $scope.clearForm = function() {
        $scope.stoppage = { categoryCode: "MECHANICAL" };
    };

    $scope.saveData = function(actionType) {
        if (!$scope.stoppage.stoppageDate || !$scope.stoppage.totalTime) {
            alert("Please fill in Date and Total Time.");
            return;
        }

        var formattedDate = $scope.stoppage.stoppageDate;
        if (formattedDate instanceof Date) {
            formattedDate = formattedDate.toISOString().split('T')[0];
        }

        // Create a copy to send with formatted date
        var payload = angular.copy($scope.stoppage);
        payload.stoppageDate = formattedDate;

        $http.post('StoppageServlet?action=' + actionType, payload)
        .then(function(response) {
            alert(response.data.message);
            if(response.data.status === 'success') {
                $scope.stoppage.stoppageId = response.data.data.stoppageId;
            }
        }, function(error) {
            alert("Error communicating with server.");
        });
    };

    $scope.findData = function() {
        var idToSearch = prompt("Enter Stoppage Reference Number to Find:");
        if (!idToSearch) return;

        $http.get('StoppageServlet?action=find&stoppageId=' + idToSearch)
        .then(function(response) {
            if(response.data.status === 'error') {
                 alert(response.data.message);
                 $scope.clearForm();
            } else {
                 // Convert string date back to Date object for the <input type="date">
                 if (response.data.stoppageDate) {
                     response.data.stoppageDate = new Date(response.data.stoppageDate);
                 }
                 $scope.stoppage = response.data;
            }
        });
    };

    $scope.deleteData = function() {
        if (!$scope.stoppage.stoppageId) return;
        
        if (confirm("Permanently delete Stoppage Log #" + $scope.stoppage.stoppageId + "?")) {
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