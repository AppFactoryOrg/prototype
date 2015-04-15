angular.module('app-factory').factory 'CreateBlueprintModal', ->
	return ->
		templateUrl: 'client/templates/create_blueprint.template.html'
		controller: 'CreateBlueprintCtrl'

angular.module('app-factory').controller 'CreateBlueprintCtrl', ($scope, $rootScope, $meteor, $modalInstance) ->
	$scope.name = ''

	$scope.submit = ->
		$modalInstance.close
			'name': $scope.name
			'version': '1.0.0'
			'owner_id': $rootScope.currentUser['_id']