var app = angular.module('analysisApp', []);

app.controller('AnalysisController', function($scope, $http) {
    
    $scope.showFindBar = false; 

    $scope.clearForm = function() {
        $scope.analysis = {
            sampleDate: ''
        };
    };

    $scope.clearForm();

    // --- 1. FIND DATA (Fixed for Date Inputs) ---
    $scope.findData = function() {
        var searchDate = $scope.analysis.sampleDate;
        
        // Ensure date is in YYYY-MM-DD format for the Servlet
        if (searchDate instanceof Date) {
            searchDate = searchDate.toISOString().split('T')[0];
        }

        if (!searchDate) {
            alert("Please enter or select an Analysis Date.");
            return;
        }
        
        $http.get('DailyAnalysisServlet?action=find&sampleDate=' + searchDate)
        .then(function(response) {
            if(response.data.status === 'error') {
                 alert(response.data.message);
                 $scope.clearForm();
            } else {
                 // CRITICAL FIX: Convert String date from DB to JS Date Object for the UI
                 if(response.data.sampleDate) {
                     response.data.sampleDate = new Date(response.data.sampleDate);
                 }
                 
                 $scope.analysis = response.data;
                 $scope.showFindBar = false; 
            }
        }, function(error) {
            alert("Error communicating with server.");
        });
    };

    // --- 2. AUTO-CALCULATE PURITY ---
    // This watcher monitors Brix and Pol to update Purity automatically
    $scope.$watchGroup(['analysis.pjBrix', 'analysis.pjPole'], function(newValues) {
        if (newValues[0] && newValues[1] && newValues[0] > 0) {
            var pur = (newValues[1] / newValues[0]) * 100;
            $scope.analysis.pjPurity = parseFloat(pur.toFixed(2));
        }
    });

    // --- 3. SAVE OR UPDATE DATA ---
    $scope.saveData = function(actionType) {
        if (!$scope.analysis.sampleDate) {
            alert("Please select a Sample Date first.");
            return;
        }

        $http.post('DailyAnalysisServlet?action=' + actionType, $scope.analysis)
        .then(function(response) {
            alert(response.data.message);
            if(response.data.status === 'success') {
                $scope.findData(); 
            }
        }, function(error) {
            alert("Error communicating with server.");
        });
    };

    // --- 4. DELETE DATA ---
    $scope.deleteData = function() {
        if (!$scope.analysis.sampleDate) {
            alert("Select a date to delete.");
            return;
        }

        var formattedDate = $scope.analysis.sampleDate;
        if (formattedDate instanceof Date) {
            formattedDate = formattedDate.toISOString().split('T')[0];
        }

        if (confirm("Are you sure you want to delete lab analysis data for " + formattedDate + "?")) {
            $http.post('DailyAnalysisServlet?action=delete&sampleDate=' + formattedDate)
            .then(function(response) {
                alert(response.data.message);
                if(response.data.status === 'success') {
                    $scope.clearForm();
                }
            });
        }
    };
});