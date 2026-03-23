$scope.findshiftList = function() {
        $('#loading-image').show();
        $http({
                method: 'post',
                url: 'punchesreport',
                params: {
                        "action":"shiftList"
                }
        }).then(function successCallback(response) {
                var result = response.data;
                if (result.success) {
                        $scope.shiftList = result.shiftList;
                        $scope.selectLoader("crotaCode");
                }
                else {
                        if (result.sessionExpried)
                                $('#reLigin').modal('show');
                }
        }, function errorCallback(response) {
                $('#loading-image').hide();
                messageAlert("Invalid Request Please Contact System Administrator!", false, "")
        });
}