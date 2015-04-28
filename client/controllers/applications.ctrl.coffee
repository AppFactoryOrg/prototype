angular.module('app-factory').controller 'ApplicationsCtrl', ($scope, $rootScope, $meteor, $state, $modal, CreateApplicationModal) ->
	$scope.applications = $meteor.collection(Applications).subscribe('Applications')

	$scope.create = () ->
		$modal.open(new CreateApplicationModal()).result.then (application) ->
			blueprint_id = Blueprints.insert
				'name': application.name
				'version': '1.0.0'
				'owner_id': $rootScope.currentUser['_id']

			application['blueprint_id'] = blueprint_id
			$scope.applications.save(application)

			mixpanel.track('application_created')

	$scope.delete = (application) ->
		return unless confirm('Are you sure?')
		$scope.applications.remove(application)
		mixpanel.track('application_deleted')

	$scope.open = (application) ->
		url = $state.href('application.home', application_id: application['_id'])
		window.open(url, '_blank')

	$scope.edit = (application) ->
		$state.go('factory.blueprint.documents', application_id: application['_id'], blueprint_id: application['blueprint_id'])
