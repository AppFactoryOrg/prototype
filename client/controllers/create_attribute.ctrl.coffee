angular.module('app-factory').factory 'CreateAttributeModal', ->
	return ({documentSchema}) ->
		templateUrl: 'client/templates/create_attribute.template.html'
		controller: 'CreateAttributeCtrl'
		resolve:
			'documentSchema': -> documentSchema

angular.module('app-factory').controller 'CreateAttributeCtrl', ($scope, $meteor, $modalInstance, $stateParams, documentSchema, ATTRIBUTE_TYPES) ->
	application_id = $stateParams.application_id
	
	$scope.attributeTypes = ATTRIBUTE_TYPES
	$scope.attribute =
		'name': ''
		'type': ATTRIBUTE_TYPES['Text']
		'document_id': documentSchema['_id']

	$scope.submit = ->
		$modalInstance.close( $scope.attribute )