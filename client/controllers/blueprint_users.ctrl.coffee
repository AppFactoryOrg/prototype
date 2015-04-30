angular.module('app-factory').controller 'BlueprintUsersCtrl', ($scope, $modal, $meteor, CreateUserModal) ->

	$scope.users = $meteor.collection -> UserAccess.find('application_id': $scope.applicationId)

	$scope.createUser = ->
		modal = $modal.open(new CreateUserModal())
		modal.result.then (user) ->
			$meteor.call('UserAccess.invite', user).then ->
				mixpanel.track('user_access_created')

	$scope.deleteUser = (user) ->
		return unless confirm('Are you sure?')
		$meteor.collection(UserAccess).remove(user['_id'])
		mixpanel.track('user_access_deleted')
