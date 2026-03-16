var app = angular.module('loginApp', []);

app.controller('LoginController', function($scope) {
    $scope.user = {
        username: '',
        password: '',
        yearCode: ''
    };
    $scope.clientError = '';

    // Automatically set the Sugar Season Year (e.g., "2025-2026")
    $scope.initYearCode = function() {
        var date = new Date();
        var currentYear = date.getFullYear();
        var currentMonth = date.getMonth(); // 0 is Jan, 9 is Oct
         
        // Sugar season typically starts in October
        if(currentMonth >= 9) {
            $scope.user.yearCode = currentYear + "-" + (currentYear + 1);
        } else {
            $scope.user.yearCode = (currentYear - 1) + "-" + currentYear;
        }
    };

    // Initialize the year code when controller loads
    $scope.initYearCode();

    // Validate before letting the form submit to the Servlet
    $scope.validateForm = function(event) {
        if(!$scope.user.username || !$scope.user.password) {
            event.preventDefault(); // Stop form submission
            $scope.clientError = "Username and Password are required!";
        } else {
            $scope.clientError = ''; // Clear error, let it submit to backend
        }
    };
});