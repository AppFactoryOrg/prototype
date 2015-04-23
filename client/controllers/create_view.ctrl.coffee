angular.module('app-factory').factory 'CreateViewModal', ->
	return ({screenSchema}) ->
		templateUrl: 'client/templates/edit_view.template.html'
		controller: 'CreateViewCtrl'
		resolve:
			'screenSchema': -> screenSchema

angular.module('app-factory').controller 'CreateViewCtrl', ($scope, $meteor, $modalInstance, $stateParams, screenSchema, VIEW_TYPES) ->
	blueprint_id = $stateParams.blueprint_id
	
	$scope.documentSchemas = $meteor.collection -> DocumentSchemas.find('blueprint_id': blueprint_id)

	$meteor.subscribe('DocumentSchemas', blueprint_id);
	
	$scope.createMode = true
	$scope.viewTypes = VIEW_TYPES
	$scope.view =
		'name': ''
		'type': VIEW_TYPES['List']
		'document_type': null
		'screen_schema_id': screenSchema['_id']
		'blueprint_id': blueprint_id

	$scope.submit = ->
		$modalInstance.close( $scope.view )