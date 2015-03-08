angular.module('app-factory').controller 'BlueprintsCtrl', ($scope, $meteor, $state) ->
	$scope.blueprints = $meteor.collection(Blueprints).subscribe('Blueprints')

	$scope.create = () ->
		return unless name = prompt('Enter a name:')
		id = Blueprints.insert('name': name, 'version': '1.0.0')
		Router.go('blueprint', id: id)

	$scope.delete = (blueprint) ->
		return unless confirm('Are you sure?')
		Blueprints.remove(_id: blueprint['_id'])

	$scope.edit = (blueprint) ->
		$state.go('blueprint', blueprint_id: blueprint['_id'])
