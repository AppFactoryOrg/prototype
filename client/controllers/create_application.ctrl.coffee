angular.module('app-factory').value 'CreateApplicationModal',
	templateUrl: 'client/templates/create_application.template.html'
	controller: 'CreateApplicationCtrl'
	size: 'sm'

angular.module('app-factory').controller 'CreateApplicationCtrl', ($scope, $rootScope, $meteor, $state, $modalInstance) ->
	$scope.name = ''
	$scope.selectedBlueprint = null

	$scope.blueprints = $meteor.collection(Blueprints).subscribe('Blueprints')

	$scope.submit = ->
		$modalInstance.close
			'name': $scope.name
			'blueprint': $scope.selectedBlueprint
			'owner_id': $rootScope.currentUser['_id']