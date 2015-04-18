angular.module('app-factory').controller 'ApplicationCtrl', ($scope, $meteor, $filter, $modal, $stateParams, CreateDocumentModal, EditDocumentModal, ViewImageModal, ATTRIBUTE_TYPES, DocumentHelpers) ->
	$scope.applicationId = $stateParams.application_id
	$scope.blueprintId = null
	$scope.selectedDocumentSchema = null
	$scope.theme = null

	$meteor.subscribe('Documents', $scope.applicationId)
	$meteor.subscribe('Applications').then ->
		$scope.application = Applications.findOne($scope.applicationId)
		$scope.theme = $scope.application.theme || 'paper'
		$scope.blueprintId = $scope.application.blueprint._id

		document.title = $scope.application.name

		$meteor.subscribe('DocumentSchemas', $scope.blueprintId).then ->
			$scope.documentSchemas = DocumentSchemas.find('blueprint_id': $scope.blueprintId).fetch()

		$meteor.subscribe('Attributes', $scope.blueprintId)

	$meteor.autorun $scope, ->
		documentSchema = $scope.getReactively('selectedDocumentSchema')
		return unless documentSchema?
		$scope.attributes = Attributes.find('document_schema_id': documentSchema._id).fetch()
		$scope.documents = Documents.find('document_schema_id': documentSchema._id).fetch()
		$scope.documents.forEach (document) ->
			document.formattedData = {}
			$scope.attributes.forEach (attribute) ->
				document.formattedData[attribute._id] = $scope.formatDocumentData(document, attribute)

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

	$scope.zoomImage = (imageId) ->
		$modal.open(new ViewImageModal({imageId}))

	$scope.addDocument = ->
		documentSchema = $scope.selectedDocumentSchema

		modal = $modal.open(new CreateDocumentModal({documentSchema}))
		modal.result.then (document) ->
			$meteor.collection(Documents).save(document)
			mixpanel.track('document_created')

	$scope.editDocument = (document) ->
		documentSchema = $scope.selectedDocumentSchema
		
		modal = $modal.open(new EditDocumentModal({document, documentSchema}))
		modal.result.then (document) ->
			$meteor.collection(Documents).save(document)
			mixpanel.track('document_updated')

	$scope.deleteDocument = (document) ->
		return unless confirm('Are you sure?')
		$meteor.collection(Documents).remove(document)
		mixpanel.track('document_deleted')