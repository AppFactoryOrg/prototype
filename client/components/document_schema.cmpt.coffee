angular.module('app-factory').directive 'afDocumentSchema', ($meteor, $modal, $stateParams, ATTRIBUTE_TYPES, CreateAttributeModal) ->
	restrict: 'E'
	templateUrl: 'client/templates/document_schema.template.html'
	scope:
		documentSchema: '='
		onDeleted: '&'
	controller: ($scope) ->
		$scope.blueprintId = $stateParams.blueprint_id
		$scope.attributeTypes = ATTRIBUTE_TYPES
		$scope.documentSchemas = $meteor.collection -> DocumentSchemas.find('blueprint_id': $scope.blueprintId)

		$meteor.subscribe('Attributes', $scope.blueprintId)

		$meteor.autorun $scope, ->
			documentSchema = $scope.getReactively('documentSchema')
			return unless documentSchema?
			$scope.attributes = Attributes.find('document_schema_id': documentSchema._id).fetch()

		$scope.showDocumentSelection = (attribute) ->
			attribute.type is ATTRIBUTE_TYPES['Document']

		$scope.getAttributeName = (documentSchemaId) ->
			documentSchema = DocumentSchemas.findOne(documentSchemaId)
			return documentSchema?.name

		$scope.saveDocumentSchema = ->
			$meteor.collection(DocumentSchemas).save($scope.documentSchema)
			$scope.selectedDocumentSchema = null

		$scope.deleteDocumentSchema = ->
			return unless confirm('Are you sure?')
			$meteor.collection(DocumentSchemas).remove($scope.documentSchema._id)
			$scope.onDeleted()

		$scope.addAttribute = ->
			documentSchema = $scope.documentSchema
			
			modal = $modal.open(new CreateAttributeModal({documentSchema}))
			modal.result.then (attribute) ->
				$meteor.collection(Attributes).save(attribute)

		$scope.saveAttribute = (attribute) ->
			$meteor.collection(Attributes).save(attribute)

		$scope.deleteAttribute = (attribute) ->
			return unless window.confirm('Are you sure?')
			$meteor.collection(Attributes).remove(attribute)

