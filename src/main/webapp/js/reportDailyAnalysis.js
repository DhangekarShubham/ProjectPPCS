var app = angular.module('analysisAppReport', []);

app.controller('AnalysisController', function($scope, $http, $filter) {

    // ==============================
    // 1. INITIALIZE
    // ==============================
    $scope.init = function() {
        $scope.searchDate = new Date();
        $scope.manualDateText = $filter('date')($scope.searchDate, 'dd/MM/yyyy');
        $scope.displayDate = "";

        $scope.analysis = {};
        $scope.isDataLoaded = false;
        $scope.loading = false;
    };

    $scope.init();

    // ==============================
    // 2. SAFE VALUE HANDLER
    // ==============================
    function safe(val) {
        return (val === null || val === undefined || isNaN(val)) ? 0 : parseFloat(val);
    }

    // ==============================
    // 3. FORMATTERS
    // ==============================
    $scope.formatNumber = function(val) {
        return safe(val).toFixed(2);
    };

    $scope.formatInt = function(val) {
        return parseInt(safe(val), 10).toString();
    };

    // ==============================
    // 4. DATE SYNC
    // ==============================
    $scope.syncFromPicker = function() {
        if ($scope.searchDate) {
            $scope.manualDateText = $filter('date')($scope.searchDate, 'dd/MM/yyyy');
        }
    };

    $scope.syncFromText = function() {
        if ($scope.manualDateText && $scope.manualDateText.length === 10) {
            var parts = $scope.manualDateText.split('/');
            if (parts.length === 3) {
                var day = parseInt(parts[0], 10);
                var month = parseInt(parts[1], 10) - 1;
                var year = parseInt(parts[2], 10);

                var parsedDate = new Date(year, month, day);

                if (!isNaN(parsedDate.getTime())) {
                    $scope.searchDate = parsedDate;
                }
            }
        }
    };

    // ==============================
    // 5. CLEAR FORM
    // ==============================
    $scope.clearForm = function() {
        $scope.init();
    };

    // ==============================
    // 6. CALCULATIONS
    // ==============================
    function calcPurity(brix, pol) {
        if (!brix || brix === 0) return 0;
        return (pol / brix) * 100;
    }

    function applyCalculations() {

        var a = $scope.analysis;

        // Total Crushed
        a.totalCrushed = safe(a.memberCane) + safe(a.nonMemberCane);

        // Lost Hours
        a.lostHours =
            safe(a.mechanicalStop) +
            safe(a.electricalStop) +
            safe(a.rainStop) +
            safe(a.caneShortage);

        // Total Sugar Bags
        a.totalBags = safe(a.sugarM30) + safe(a.sugarS130);

        // Purity auto calculation (if missing)
        a.pjPurity = safe(a.pjPurity) || calcPurity(a.pjBrix, a.pjPole);
        a.mjPurity = safe(a.mjPurity) || calcPurity(a.mjBrix, a.mjPole);
        a.cjPurity = safe(a.cjPurity) || calcPurity(a.cjBrix, a.cjPole);
        a.fmPurity = safe(a.fmPurity) || calcPurity(a.fmBrix, a.fmPole);

        // Recovery % (if sugar + cane exists)
        if (a.totalCrushed > 0 && a.totalBags > 0) {
            var sugarMT = (a.totalBags * 50) / 1000; // convert bags → MT
            a.recovery = (sugarMT / a.totalCrushed) * 100;
        } else {
            a.recovery = 0;
        }
    }

    // ==============================
    // 7. GENERATE REPORT
    // ==============================
    $scope.findData = function() {

        if (!$scope.searchDate || isNaN($scope.searchDate.getTime())) {
            alert("Please enter a valid Analysis Date (DD/MM/YYYY).");
            return;
        }

        // FIXED DATE FORMAT (NO TIMEZONE ISSUE)
        var d = new Date($scope.searchDate);
        var dbDate = d.getFullYear() + '-' +
            String(d.getMonth() + 1).padStart(2, '0') + '-' +
            String(d.getDate()).padStart(2, '0');

        $scope.displayDate = $filter('date')(d, 'dd-MMM-yyyy').toUpperCase();

        console.log("Calling API:", dbDate);

        $scope.loading = true;
        $scope.isDataLoaded = false;

        $http.get('ReportDailyAnalysisServlet?action=find&sampleDate=' + dbDate)
        .then(function(response) {

            console.log("API Response:", response.data);

            if (response.data && response.data.status === 'success') {

                $scope.analysis = response.data.data || {};

                // APPLY CALCULATIONS
                applyCalculations();

                $scope.isDataLoaded = true;

            } else {
                alert(response.data.message || "No data found.");
                $scope.analysis = {};
            }

        }, function(error) {

            console.error("HTTP ERROR:", error);

            var msg = "Server Error (" + error.status + "): ";

            if (error.status === 404) {
                msg += "Servlet not found!";
            } else if (error.status === 500) {
                msg += "Check Tomcat console!";
            } else {
                msg += "Connection failed!";
            }

            alert(msg);

        }).finally(function() {
            $scope.loading = false;
        });
    };

    // ==============================
    // 8. PRINT
    // ==============================
    $scope.printReport = function() {
        if (!$scope.isDataLoaded) {
            alert("Generate report first.");
            return;
        }
        window.print();
    };

});