var app = angular.module('batchProcessApp', []);

app.controller('BatchProcessController', function($scope, $http, $timeout) {
    
    // Initialize the model
    $scope.processReq = {
        processModule: "ALL" // Default selection
    };
    
    // UI State variables
    $scope.isProcessing = false;
    $scope.progressPercentage = 0;
    $scope.statusMessage = "";

    // Cancel / Reset Form
    $scope.resetForm = function() {
        $scope.processReq = { processModule: "ALL" };
        $scope.isProcessing = false;
        $scope.progressPercentage = 0;
        $scope.statusMessage = "";
    };

    // Execute Process
    $scope.executeProcess = function() {
        if (!$scope.processReq.fromDate || !$scope.processReq.toDate) {
            alert("Please select both From Date and To Date before executing.");
            return;
        }

        if (new Date($scope.processReq.fromDate) > new Date($scope.processReq.toDate)) {
            alert("From Date cannot be later than To Date.");
            return;
        }

        // Prepare UI for processing
        $scope.isProcessing = true;
        $scope.progressPercentage = 10;
        $scope.statusMessage = "Initializing Batch Process...";

        // Step 1: Simulate initial progress (UI Experience)
        $timeout(function() {
            $scope.progressPercentage = 40;
            $scope.statusMessage = "Recalculating To-Date Totals...";
            
            // Step 2: Make the actual HTTP call to the Servlet
            $http.post('BatchProcessServlet', $scope.processReq)
                .then(function(response) {
                    
                    // Step 3: Handle server response
                    if (response.data.status === 'success') {
                        $scope.progressPercentage = 100;
                        $scope.statusMessage = response.data.message;
                        alert(response.data.message);
                    } else {
                        $scope.isProcessing = false; // Stop loading bar
                        alert("Error: " + response.data.message);
                    }
                    
                }, function(error) {
                    $scope.isProcessing = false;
                    alert("Error communicating with server.");
                });
                
        }, 1000); // 1 second simulated delay before sending request
    };
});