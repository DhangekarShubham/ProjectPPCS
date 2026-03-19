<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="sugarErpApp">
<head>
<meta charset="UTF-8">
<title>Sugar ERP</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<link rel="stylesheet" href="css/style.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>

<script src="js/factory_information.js"></script>
<script src="js/dailyCrushing.js"></script>
<script src="js/dailyAnalysis.js"></script>
<script src="js/chemicalConsumption.js"></script>
<script src="js/materialStock.js"></script>
<script src="js/stoppageReason.js"></script>
<script src="js/rt7cStock.js"></script>
<script src="js/rt8c.js"></script>
<script src="js/runStock.js"></script>
<script src="js/reportMfgDetails.js"></script>
 <script src="js/reportMfgShort.js"></script>

<script>
    var app = angular.module('sugarErpApp', [
        'factoryApp', 
        'crushingApp', 
        'analysisApp',
        'chemicalApp',
        'stockApp',
        'stoppageApp',
        'rt7cApp', 
        'rt8cApp',
        'runStockApp',
        'mfgReportApp',
        'mfgShortApp'
    ]);
</script></head>
<body>

	<jsp:include page="includes/header.jsp" />
	<jsp:include page="includes/menu.jsp" />

	<section id="content">
		<div class="mainpanel" id="app-container">
			<div class="contentpanel text-center mt-5">
				<h1 style="color: #bdc3d1; font-size: 80px;">
					<i class="fa fa-industry"></i>
				</h1>
				<h3 style="color: #657390; font-weight: 300;">Welcome to Sugar
					ERP</h3>
			</div>
		</div>
	</section>

	<script>
$(document).ready(function() {
    
    // 1. Sidebar Toggle (Hamburger)
    $('#menuToggle').on('click', function(e) {
        e.preventDefault();
        $('body').toggleClass('sidebar-collapsed');
    });

    // 2. SMOOTH & SLOW Menu Opening Animation
    $('.menu-item-parent > a').on('click', function(e) {
        e.preventDefault();
        e.stopImmediatePropagation();

        var parentLi = $(this).closest('.menu-item-parent');
        var subMenu = parentLi.find('.children');
        var animationSpeed = 400;

        if (!parentLi.hasClass('active')) {
            $('.menu-item-parent.active').find('.children').slideUp(animationSpeed);
            $('.menu-item-parent.active').removeClass('active');
            parentLi.addClass('active');
            subMenu.stop(true, true).slideDown(animationSpeed);
        } else {
            parentLi.removeClass('active');
            subMenu.stop(true, true).slideUp(animationSpeed);
        }
    });

    // 3. SPA AJAX Loader
    $(document).on('click', '.ajax-link', function(e) {
        e.preventDefault();
        var url = $(this).attr('href');

        // Prevent trying to reload the dashboard inside itself
        if(url === "dashboard.jsp" || url === "#" || url === "javascript:void(0);") {
            window.location.href = url; // Do a hard redirect for the home button
            return;
        }

        // Highlight sub-link visually
        $('.nav-sidebar .nav-link').css('color', ''); // Reset all
        $('.children .nav-link').css('color', '#657390');
        $(this).css('color', '#259dab');

        // Show a loading spinner so the user knows something is happening
        $('#app-container').html('<div class="text-center mt-5"><i class="fa fa-spinner fa-spin fa-3x" style="color: #259dab;"></i><h4 class="mt-3" style="color: #657390;">Loading...</h4></div>');

        // Use $.ajax instead of .load() for better error handling
        $.ajax({
            url: url,
            type: 'GET',
            success: function(response) {
                // Try to find .contentpanel in the response.
                var parsedResponse = $(response);
                var newContent = parsedResponse.find('.contentpanel').length ? parsedResponse.find('.contentpanel') : parsedResponse;

                // Inject the HTML
                $('#app-container').html(newContent);

                // Safely re-compile the injected HTML for AngularJS
                var $injector = angular.element(document.body).injector();
                if($injector) {
                    $injector.invoke(['$compile', '$timeout', function($compile, $timeout) {
                        // Use pure DOM element to prevent jQuery wrapper confusion
                        var $appContainer = angular.element(document.getElementById('app-container'));
                        var $scope = $appContainer.scope();
                        
                        // Compile the contents specifically
                        $compile($appContainer.contents())($scope);
                        
                        // Use $timeout to safely trigger a digest cycle without conflicts
                        $timeout(function() {
                            if (!$scope.$$phase) {
                                $scope.$apply();
                            }
                        });
                    }]);
                }
            },
            error: function(xhr, status, error) {
                // Show clear error message if the page fails to load
                $('#app-container').html('<div class="alert alert-danger mt-5 text-center"><i class="fa fa-exclamation-triangle fa-2x"></i><br>Error loading page: <b>' + url + '</b><br>Please check if the file exists and the server is running.</div>');
                console.error("AJAX Load Error:", error);
            }
        });
    });
});
</script>
</body>
</html>