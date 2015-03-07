angular.module('app-factory').controller 'BlueprintsCtrl', ($scope, $meteor) ->
	$scope.blueprints = $meteor.collection(Blueprints)

	$scope.create = () ->
		return unless name = window.prompt('Name:')
		Blueprints.insert({name})

	$scope.delete = (blueprint) ->
		return unless confirm('Are you sure?')
		Blueprints.remove(_id: blueprint['_id'])

	$scope.edit = (blueprint) ->
		Router.go('blueprint', id: blueprint['_id'])
