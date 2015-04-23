angular.module('app-factory').factory 'EditViewModal', ->
	return ({view, screenSchema}) ->
		templateUrl: 'client/templates/edit_view.template.html'
		controller: 'EditViewCtrl'
		resolve:
			'view': -> view
			'screenSchema': -> screenSchema

angular.module('app-factory').controller 'EditViewCtrl', ($scope, $meteor, $modalInstance, $stateParams, screenSchema, view, VIEW_TYPES) ->
	blueprint_id = $stateParams.blueprint_id
	
	$scope.documentSchemas = $meteor.collection -> DocumentSchemas.find('blueprint_id': blueprint_id)

	$meteor.subscribe('DocumentSchemas', blueprint_id);
		
	$scope.viewTypes = VIEW_TYPES
	$scope.view = angular.copy(view)

	$scope.submit = ->
		$modalInstance.close( $scope.view )