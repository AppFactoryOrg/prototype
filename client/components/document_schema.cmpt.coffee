angular.module('app-factory').directive 'afDocumentSchema', ($meteor) ->
	restrict: 'E'
	templateUrl: 'client/templates/document_schema.template.html'
	scope:
		documentSchema: '='
		onDeleted: '&'
	controller: ($scope) ->
		$scope.documentSchemas = $meteor.collection(DocumentSchemas, false)
		$scope.attributes = $meteor.collection(Attributes, false)
		
		$meteor.autorun $scope, () ->
			documentSchema = $scope.getReactively('documentSchema')
			$meteor.subscribe('Attributes', documentSchema['_id'])
		
		$scope.attributeTypes = {
			'Text': 		'0'
			'Number': 		'1'
			'Date': 	    '2'
		}

		$scope.saveDocumentSchema = ->
			$scope.documentSchemas.save($scope.documentSchema)
			$scope.selectedDocumentSchema = null

		$scope.deleteDocumentSchema = ->
			return unless confirm('Are you sure?')
			$scope.documentSchemas.remove($scope.documentSchema)
			$scope.onDeleted()

		$scope.addAttribute = ->
			return unless name = window.prompt('Enter a name:')
			$scope.attributes.save
				'name': name
				'type': $scope.attributeTypes['Text']
				'document_id': $scope.documentSchema['_id']

		$scope.saveAttribute = (attribute) ->
			$scope.attributes.save(attribute)

		$scope.deleteAttribute = (attribute) ->
			return unless window.confirm('Are you sure?')
			$scope.attributes.remove(attribute)

