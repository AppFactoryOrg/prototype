angular.module('app-factory').controller 'ApplicationCtrl', ($scope, $meteor, $q, $filter, $stateParams) ->
	$scope.applicationId = $stateParams.application_id
	$scope.blueprintId = null
	$scope.theme = null
	$scope.application = null
	$scope.documentSchemas = null
	$scope.screenSchemas = null
	$scope.applicationIsLoaded = false

	$meteor.subscribe('Applications').then ->
		$scope.application = Applications.findOne($scope.applicationId)
		$scope.theme = $scope.application.theme || 'paper'
		$scope.blueprintId = $scope.application.blueprint._id

		document.title = $scope.application.name

		$q.all([
			$meteor.subscribe('DocumentSchemas', $scope.blueprintId)
			$meteor.subscribe('ScreenSchemas', $scope.blueprintId)
			$meteor.subscribe('Views', $scope.blueprintId)
			$meteor.subscribe('Attributes', $scope.blueprintId)
			$meteor.subscribe('Documents', $scope.applicationId)
		]).then ->
			$scope.documentSchemas = DocumentSchemas.find('blueprint_id': $scope.blueprintId).fetch()
			$scope.screenSchemas = ScreenSchemas.find('blueprint_id': $scope.blueprintId).fetch()
			$scope.applicationIsLoaded = true
			$scope.$broadcast('APPLICATION_LOADED')
