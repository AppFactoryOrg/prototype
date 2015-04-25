angular.module('app-factory').controller 'BlueprintCtrl', ($scope, $meteor, $state, $stateParams) ->
	$meteor.subscribe('Blueprints')
	
	$scope.blueprintId = $stateParams.blueprint_id
	$scope.blueprint = $meteor.object(Blueprints, $scope.blueprintId)

	$scope.showNav = ->
		return false if $state.current.name is 'factory.blueprint.routine'
		return true