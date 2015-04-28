angular.module('app-factory').controller 'DocumentViewCtrl', ($scope, $meteor, $filter, $modal, CreateDocumentModal, EditDocumentModal, ViewImageModal, ATTRIBUTE_TYPES, ROUTINE_TYPES, DocumentHelpers, RoutineHelper) ->
	$scope.formatDocumentData = (document, attribute) ->
		value = null
		dataType = null
		
		if attribute.type is ATTRIBUTE_TYPES['Routine']
			try
				result = RoutineHelper.execute(attribute['routine_id'], [{name: 'Document', value: document}])
				value = result[0]['value']
				dataType = result[0]['type']
			catch error
				console.error(error)
				return "Error!"
		else
			key = attribute['_id']
			return unless document.data.hasOwnProperty(key)
			value = document.data[key]
			dataType = attribute.type

		return switch dataType
			when ATTRIBUTE_TYPES['Text'] then value
			when ATTRIBUTE_TYPES['Number'] then $filter('number')(value, 2)
			when ATTRIBUTE_TYPES['Date'] then $filter('date')(value, 'shortDate')
			when ATTRIBUTE_TYPES['Currency'] then $filter('currency')(value, '$', 2)
			when ATTRIBUTE_TYPES['Document'] then DocumentHelpers.getDocumentDisplayName(document, attribute)
			else value

	$scope.zoomImage = (imageId) ->
		$modal.open(new ViewImageModal({imageId}))

	$scope.addDocument = ->
		documentSchema = $scope.documentSchema

		modal = $modal.open(new CreateDocumentModal({documentSchema}))
		modal.result.then (document) ->
			$meteor.collection(Documents).save(document)
			mixpanel.track('document_created')

	$scope.editDocument = (document) ->
		documentSchema = $scope.documentSchema
		
		modal = $modal.open(new EditDocumentModal({document, documentSchema}))
		modal.result.then (document) ->
			$meteor.collection(Documents).save(document)
			mixpanel.track('document_updated')

	$scope.deleteDocument = (document) ->
		return unless confirm('Are you sure?')
		$meteor.collection(Documents).remove(document)
		mixpanel.track('document_deleted')

	$scope.executeRoutine = (routine, document) ->
		routineInputs = [
			{name: 'Document', value: document}
		]
		RoutineHelper.execute(routine['_id'], routineInputs)
		mixpanel.track('routine_executed')

	# Initialize
	$meteor.autorun $scope, ->
		$scope.documentSchema = DocumentSchemas.findOne($scope.view.document_type)
		$scope.attributes = Attributes.find('document_schema_id': $scope.documentSchema['_id']).fetch()
		$scope.routines = Routines.find(
			'type': ROUTINE_TYPES['Document Action']
			'document_schema_id': $scope.documentSchema['_id']
		).fetch()
		$scope.documents = Documents.find('document_schema_id': $scope.documentSchema['_id']).fetch()
		$scope.documents.forEach (document) ->
			document.formattedData = {}
			$scope.attributes.forEach (attribute) ->
				document.formattedData[attribute._id] = $scope.formatDocumentData(document, attribute)


