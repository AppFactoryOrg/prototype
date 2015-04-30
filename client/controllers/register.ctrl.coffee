angular.module('app-factory').controller 'RegisterCtrl', ($scope, $meteor, $state, $stateParams) ->
	$scope.loaded = false
	$scope.userAccess = null
	$scope.application = null

	$meteor.subscribe('UserAccessRegistration', $stateParams.code).then ->
		$scope.userAccess = UserAccess.findOne('invite_code': $stateParams.code)
		$meteor.subscribe('Applications', $scope.userAccess['application_id']).then ->
			$scope.application = Applications.findOne('_id': $scope.userAccess['application_id'])
			$scope.loaded = true

	$scope.acceptInvitation = ->
		$meteor.call('UserAccess.confirm', $scope.userAccess).then ->
			$state.go('application.home', application_id: $scope.application['_id'])

