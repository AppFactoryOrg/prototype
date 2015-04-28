angular.module('app-factory').controller 'BlueprintCtrl', ($scope, $meteor, $state, $stateParams) ->
	$scope.blueprintId = $stateParams.blueprint_id
	$scope.blueprint = $meteor.object(Blueprints, $scope.blueprintId)

	$scope.applicationId = $stateParams.application_id
	$scope.application = $meteor.object(Applications, $scope.applicationId)

	$meteor.subscribe('Blueprints')
	$meteor.subscribe('DocumentSchemas', $scope.blueprintId)
	$meteor.subscribe('Routines', $scope.blueprintId)

	$scope.showNav = ->
		return false if $state.current.name is 'factory.blueprint.routine'
		return true

	$scope.openApplication = ->
		url = $state.href('application.home', application_id: $scope.applicationId )
		window.open(url, '_blank')