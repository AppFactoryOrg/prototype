angular.module('app-factory').controller 'HomeCtrl', ($scope, $rootScope) ->
	$scope.hideTutorials = ->
		$rootScope.currentUser.hideTutorials = true