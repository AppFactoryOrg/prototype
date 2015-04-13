angular.module('app-factory').factory 'CreateAttributeModal', ->
	return ({documentSchema}) ->
		templateUrl: 'client/templates/create_attribute.template.html'
		controller: 'CreateAttributeCtrl'
		resolve:
			'documentSchema': -> documentSchema

angular.module('app-factory').controller 'CreateAttributeCtrl', ($scope, $meteor, $modalInstance, $stateParams, documentSchema, ATTRIBUTE_TYPES) ->
	blueprint_id = $stateParams.blueprint_id
	
	$scope.documentSchemas = $meteor.collection -> DocumentSchemas.find('blueprint_id': blueprint_id)
	$scope.attributeTypes = ATTRIBUTE_TYPES
	$scope.attribute =
		'name': ''
		'type': ATTRIBUTE_TYPES['Text']
		'document_schema_id': documentSchema['_id']
		'blueprint_id': blueprint_id

	$meteor.subscribe('DocumentSchemas', blueprint_id).then (handle) ->
		$scope.$on '$destroy', -> handle?.stop()

	$scope.showDocumentSelection = ->
		$scope.attribute.type is ATTRIBUTE_TYPES['Document']

	$scope.submit = ->
		$modalInstance.close( $scope.attribute )