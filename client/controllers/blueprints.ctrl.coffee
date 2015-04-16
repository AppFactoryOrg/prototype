angular.module('app-factory').controller 'BlueprintsCtrl', ($scope, $modal, $meteor, $state, CreateBlueprintModal) ->
	$scope.blueprints = $meteor.collection(Blueprints).subscribe('Blueprints')

	$scope.create = () ->
		$modal.open(new CreateBlueprintModal()).result.then (blueprint) ->
			$scope.blueprints.save(blueprint)
			mixpanel.track('blueprint_created')

	$scope.delete = (blueprint) ->
		return unless confirm('Are you sure?')
		$scope.blueprints.remove(blueprint)
		mixpanel.track('blueprint_deleted')

	$scope.edit = (blueprint) ->
		$state.go('factory.blueprint', blueprint_id: blueprint['_id'])
