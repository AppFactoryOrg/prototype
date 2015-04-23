angular.module('app-factory').controller 'ApplicationsCtrl', ($scope, $meteor, $state, $modal, CreateApplicationModal) ->
	$scope.applications = $meteor.collection(Applications).subscribe('Applications')

	$scope.create = () ->
		$modal.open(new CreateApplicationModal()).result.then (application) ->
			$scope.applications.save(application)
			mixpanel.track('application_created')

	$scope.delete = (application) ->
		return unless confirm('Are you sure?')
		$scope.applications.remove(application)
		mixpanel.track('application_deleted')

	$scope.edit = (application) ->
		url = $state.href('application.home', application_id: application['_id'])
		window.open(url, '_blank')