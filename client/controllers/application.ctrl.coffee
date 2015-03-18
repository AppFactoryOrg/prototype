angular.module('app-factory').controller 'ApplicationCtrl', ($scope, $meteor, $stateParams) ->
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

	$scope.getDocumentAttribute = (document, attribute) ->
		attribute_name = attribute.name.toLowerCase()
		if document.hasOwnProperty(attribute_name)
			return document[attribute_name]
		else
			return ''
