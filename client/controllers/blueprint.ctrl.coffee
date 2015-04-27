angular.module('app-factory').controller 'BlueprintCtrl', ($scope, $meteor, $state, $stateParams) ->
	$scope.blueprintId = $stateParams.blueprint_id
	$scope.blueprint = $meteor.object(Blueprints, $scope.blueprintId)

	$meteor.subscribe('Blueprints')
	$meteor.subscribe('DocumentSchemas', $scope.blueprintId)
	$meteor.subscribe('Routines', $scope.blueprintId)

	$scope.showNav = ->
		return false if $state.current.name is 'factory.blueprint.routine'
		return true