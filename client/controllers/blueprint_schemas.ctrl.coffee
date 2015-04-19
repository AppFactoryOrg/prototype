angular.module('app-factory').controller 'BlueprintScreensCtrl', ($scope, $meteor, $modal, $stateParams, CreateScreenSchemaModal) ->
	$meteor.subscribe('ScreenSchemas', $scope.blueprintId)

	$scope.selectedScreenSchema = null
	$scope.screenSchemas = $meteor.collection -> ScreenSchemas.find('blueprint_id': $scope.blueprintId)

	$scope.selectScreenSchema = (screen) -> $scope.selectedScreenSchema = _.clone(screen)
	$scope.deselectScreenSchema = -> $scope.selectedScreenSchema = null
	$scope.screenIsSelected = (screen) -> return screen['_id'] is $scope.selectedScreenSchema?['_id']

	$scope.createScreenSchema = ->
		blueprint = $scope.blueprint
		modal = $modal.open(new CreateScreenSchemaModal({blueprint}))
		modal.result.then (screenSchema) ->
			$scope.screenSchemas.save(screenSchema)
			mixpanel.track('screenSchema_created')