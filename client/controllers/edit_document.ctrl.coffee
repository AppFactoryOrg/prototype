angular.module('app-factory').factory 'EditDocumentModal', ->
	return ({document, documentSchema}) ->
		templateUrl: 'client/templates/edit_document.template.html'
		controller: 'EditDocumentCtrl'
		resolve:
			'document': -> document
			'documentSchema': -> documentSchema

angular.module('app-factory').controller 'EditDocumentCtrl', ($scope, $rootScope, $meteor, $modal, $modalInstance, document, documentSchema, LookupDocumentModal, ATTRIBUTE_TYPES, DocumentHelpers) ->
	$scope.document = angular.copy(document)
	$scope.documentSchema = documentSchema
	$scope.attributes = Attributes.find('document_schema_id': documentSchema._id).fetch()

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