angular.module('app-factory').factory 'CreateDocumentModal', ->
	return ({documentSchema}) ->
		templateUrl: 'client/templates/edit_document.template.html'
		controller: 'CreateDocumentCtrl'
		resolve:
			'documentSchema': -> documentSchema

angular.module('app-factory').controller 'CreateDocumentCtrl', ($scope, $modal, $rootScope, $meteor, $modalInstance, $stateParams, documentSchema, LookupDocumentModal, DocumentHelpers) ->
	application_id = $stateParams.application_id
	
	$scope.createMode = true
	$scope.documentSchema = documentSchema
	$scope.attributes = $meteor.collection -> Attributes.find('document_schema_id': documentSchema['_id'])

	$scope.document =
		'application_id': application_id
		'document_schema_id': documentSchema['_id']
		'data': {}

	$scope.selectDocument = (attribute) ->
		documentSchemaId = attribute.document_type
		modal = $modal.open(new LookupDocumentModal({documentSchemaId}))
		modal.result.then (document) ->
			$scope.document.data[attribute._id] = document._id

	$scope.clearDocument = (attribute) ->
		$scope.document.data[attribute._id] = null

	$scope.getDocumentDisplayName = (attribute) ->
		DocumentHelpers.getDocumentDisplayName($scope.document, attribute)

	$scope.submit = ->
		$modalInstance.close( $scope.document )