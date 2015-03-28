angular.module('app-factory').controller 'ApplicationCtrl', ($scope, $meteor, $filter, $modal, $stateParams, CreateDocumentModal, EditDocumentModal, ATTRIBUTE_TYPES) ->
	application_id = $stateParams.application_id
	blueprint_id = null

	$scope.selectedDocumentSchema = null
	
	$scope.application     = $meteor.object(Applications, application_id, false)
	$scope.documentSchemas = $meteor.collection(DocumentSchemas, false)
	$scope.attributes      = $meteor.collection(Attributes, false)
	$scope.documents       = $meteor.collection(Documents, false)

	$meteor.subscribe('Applications', application_id).then ->
		application = Applications.findOne('_id': application_id)
		blueprint_id = application['blueprint']['_id']
		$meteor.subscribe('DocumentSchemas', blueprint_id)

	$meteor.autorun $scope, () ->
		documentSchema = $scope.getReactively('selectedDocumentSchema')
		return unless documentSchema
		$meteor.subscribe('Attributes', documentSchema['_id'])
		$meteor.subscribe('Documents', application_id, documentSchema['_id'])

	$scope.selectDocumentSchema = (documentSchema) -> $scope.selectedDocumentSchema = documentSchema

	$scope.formatDocumentData = (document, attribute) ->
		value = document.data[attribute['_id']]
		return switch attribute.type
			when ATTRIBUTE_TYPES['Text'] then value
			when ATTRIBUTE_TYPES['Number'] then $filter('number')(value, 2)
			when ATTRIBUTE_TYPES['Date'] then $filter('date')(value, 'shortDate')
			when ATTRIBUTE_TYPES['Currency'] then $filter('currency')(value, '$', 2)
			else value

	$scope.addDocument = ->
		documentSchema = $scope.selectedDocumentSchema

		modal = $modal.open(new CreateDocumentModal({documentSchema}))
		modal.result.then (document) ->
			$scope.documents.save(document)

	$scope.editDocument = (document) ->
		documentSchema = $scope.selectedDocumentSchema
		
		modal = $modal.open(new EditDocumentModal({document, documentSchema}))
		modal.result.then (document) ->
			$scope.documents.save(document)

	$scope.deleteDocument = (document) ->
		return unless confirm('Are you sure?')
		$scope.documents.remove(document)