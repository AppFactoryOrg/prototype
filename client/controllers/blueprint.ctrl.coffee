angular.module('app-factory').controller 'BlueprintCtrl', ($scope, $meteor) ->
	id = Router.current().params.id
	$scope.blueprint = $meteor.object(Blueprints, id)