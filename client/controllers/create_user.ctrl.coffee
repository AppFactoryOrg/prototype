angular.module('app-factory').factory 'CreateUserModal', ->
	return ->
		templateUrl: 'client/templates/create_user.template.html'
		controller: 'CreateUserCtrl'

angular.module('app-factory').controller 'CreateUserCtrl', ($scope, $stateParams, $modalInstance) ->
	$scope.email = ''

	$scope.submit = ->
		return alert('An email address is required') if _.isEmpty($scope.email)
		$modalInstance.close
			'email': $scope.email
			'role': 'default'
			'application_id': $stateParams.application_id
			'invite_code': null
			'confirmed': false
