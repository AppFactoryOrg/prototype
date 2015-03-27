angular.module('app-factory').controller 'ApplicationsCtrl', ($scope, $meteor, $state, $modal, CreateApplicationModal) ->
	$scope.applications = $meteor.collection(Applications).subscribe('Applications')

	$scope.create = () ->
		$modal.open(CreateApplicationModal).result.then (application) ->
			$scope.applications.save(application)
			
	$scope.delete = (application) ->
		return unless confirm('Are you sure?')
		$scope.applications.remove(application)

	$scope.edit = (application) ->
		$state.go('application', application_id: application['_id'])
