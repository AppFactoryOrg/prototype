angular.module('app-factory').directive 'afDocumentSchema', ($meteor, $modal, ATTRIBUTE_TYPES, CreateAttributeModal) ->
	restrict: 'E'
	templateUrl: 'client/templates/document_schema.template.html'
	scope:
		documentSchema: '='
		onDeleted: '&'
	controller: ($scope) ->
		$scope.attributeTypes = ATTRIBUTE_TYPES
		$scope.documentSchemas = $meteor.collection(DocumentSchemas, false)
		$scope.attributes = $meteor.collection(Attributes, false)
		
		$meteor.autorun $scope, () ->
			documentSchema = $scope.getReactively('documentSchema')
			$meteor.subscribe('Attributes', documentSchema['_id'])

		$scope.showDocumentSelection = (attribute) ->
			attribute.type is ATTRIBUTE_TYPES['Document']

		$scope.getAttributeName = (documentSchemaId) ->
			documentSchema =_.findWhere($scope.documentSchemas, {_id: documentSchemaId})
			return documentSchema?.name

		$scope.saveDocumentSchema = ->
			$scope.documentSchemas.save($scope.documentSchema)
			$scope.selectedDocumentSchema = null

		$scope.deleteDocumentSchema = ->
			return unless confirm('Are you sure?')
			$scope.documentSchemas.remove($scope.documentSchema)
			$scope.onDeleted()

		$scope.addAttribute = ->
			documentSchema = $scope.documentSchema
			
			modal = $modal.open(new CreateAttributeModal({documentSchema}))
			modal.result.then (attribute) ->
				$scope.attributes.save(attribute)

		$scope.saveAttribute = (attribute) ->
			$scope.attributes.save(attribute)

		$scope.deleteAttribute = (attribute) ->
			return unless window.confirm('Are you sure?')
			$scope.attributes.remove(attribute)

