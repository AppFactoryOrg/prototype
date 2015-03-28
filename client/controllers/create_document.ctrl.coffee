angular.module('app-factory').factory 'CreateDocumentModal', ->
	return ({documentSchema}) ->
		templateUrl: 'client/templates/edit_document.template.html'
		controller: 'CreateDocumentCtrl'
		resolve:
			'documentSchema': -> documentSchema

angular.module('app-factory').controller 'CreateDocumentCtrl', ($scope, $rootScope, $meteor, $modalInstance, $stateParams, documentSchema) ->
	application_id = $stateParams.application_id
	
	$scope.createMode = true
	$scope.documentSchema = documentSchema
	$scope.attributes = $meteor.collection(Attributes, false)

	$scope.document =
		'application_id': application_id
		'document_schema_id': documentSchema['_id']
		'data': {}

	$meteor.subscribe('Attributes', documentSchema['_id']).then ->
		$scope.attributes.forEach (attribute) ->
			$scope.document.data[attribute['_id']] = null

	$scope.submit = ->
		$modalInstance.close( $scope.document )