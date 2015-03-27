angular.module('app-factory').controller 'BlueprintsCtrl', ($scope, $rootScope, $meteor, $state) ->
	$scope.blueprints = $meteor.collection(Blueprints).subscribe('Blueprints')

	$scope.create = () ->
		return unless name = prompt('Enter a name:')
		blueprint = 
			'name': name
			'version': '1.0.0'
			'owner_id': $rootScope.currentUser['_id']

		$scope.blueprints.save(blueprint)

	$scope.delete = (blueprint) ->
		return unless confirm('Are you sure?')
		$scope.blueprints.remove(blueprint)

	$scope.edit = (blueprint) ->
		$state.go('blueprint', blueprint_id: blueprint['_id'])
