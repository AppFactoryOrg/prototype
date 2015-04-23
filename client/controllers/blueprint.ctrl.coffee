angular.module('app-factory').controller 'BlueprintCtrl', ($scope, $meteor, $stateParams) ->
	$meteor.subscribe('Blueprints')
	
	$scope.blueprintId = $stateParams.blueprint_id
	$scope.blueprint = $meteor.object(Blueprints, $scope.blueprintId)