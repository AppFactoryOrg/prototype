angular.module('app-factory').controller 'ApplicationScreenCtrl', ($scope, $meteor, $stateParams) ->
	$scope.screenSchemaId = $stateParams.screen_schema_id

	$scope.loadViews = ->
		$scope.views = Views.find('screen_schema_id': $scope.screenSchemaId).fetch()

	# Initialize
	if $scope.applicationIsLoaded
		$scope.loadViews()
	else
		$scope.$on 'APPLICATION_LOADED', -> $scope.loadViews()
