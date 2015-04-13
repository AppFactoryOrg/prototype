angular.module('app-factory').controller 'ApplicationCtrl', ($scope, $meteor, $filter, $modal, $stateParams, CreateDocumentModal, EditDocumentModal, ATTRIBUTE_TYPES, DocumentHelpers) ->
	$scope.applicationId = $stateParams.application_id
	$scope.blueprintId = null
	$scope.selectedDocumentSchema = null

	$meteor.subscribe('Documents', $scope.applicationId)
	$meteor.subscribe('Applications').then ->
		$scope.application = Applications.findOne($scope.applicationId)
		$scope.blueprintId = $scope.application.blueprint._id

		$meteor.subscribe('DocumentSchemas', $scope.blueprintId).then ->
			$scope.documentSchemas = DocumentSchemas.find('blueprint_id': $scope.blueprintId).fetch()

		$meteor.subscribe('Attributes', $scope.blueprintId)

	$meteor.autorun $scope, ->
		documentSchema = $scope.getReactively('selectedDocumentSchema')
		return unless documentSchema?
		$scope.documents = Documents.find('document_schema_id': documentSchema._id).fetch()
		$scope.attributes = Attributes.find('document_schema_id': documentSchema._id).fetch()

	$scope.selectDocumentSchema = (documentSchema) -> 
		$scope.selectedDocumentSchema = documentSchema

	$scope.formatDocumentData = (document, attribute) ->
		key = attribute['_id']
		return unless document.data.hasOwnProperty(key)
		value = document.data[key]
		return switch attribute.type
			when ATTRIBUTE_TYPES['Text'] then value
			when ATTRIBUTE_TYPES['Number'] then $filter('number')(value, 2)
			when ATTRIBUTE_TYPES['Date'] then $filter('date')(value, 'shortDate')
			when ATTRIBUTE_TYPES['Currency'] then $filter('currency')(value, '$', 2)
			when ATTRIBUTE_TYPES['Document'] then DocumentHelpers.getDocumentDisplayName(document, attribute)
			else value

	$scope.addDocument = ->
		documentSchema = $scope.selectedDocumentSchema

		modal = $modal.open(new CreateDocumentModal({documentSchema}))
		modal.result.then (document) ->
			$meteor.collection(Documents).save(document)

	$scope.editDocument = (document) ->
		documentSchema = $scope.selectedDocumentSchema
		
		modal = $modal.open(new EditDocumentModal({document, documentSchema}))
		modal.result.then (document) ->
			$meteor.collection(Documents).save(document)

	$scope.deleteDocument = (document) ->
		return unless confirm('Are you sure?')
		$meteor.collection(Documents).remove(document)