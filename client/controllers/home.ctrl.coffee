angular.module('app-factory').controller 'HomeCtrl', ($scope, $meteor, $rootScope) ->
	$scope.hideTutorials = ->
		$rootScope.currentUser.hideTutorials = true