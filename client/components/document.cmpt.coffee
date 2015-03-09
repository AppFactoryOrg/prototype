angular.module('app-factory').directive 'afDocument', ($meteor) ->
	restrict: 'E'
	templateUrl: 'client/templates/document.template.html'
	scope:
		document: '='
		onDeleted: '&'
	controller: ($scope) ->
		$scope.documents = $meteor.collection(Documents, false)
		
		$meteor.autorun $scope, () ->
			$scope.attributes = $meteor.collection(Attributes, false).subscribe('Attributes', $scope.getReactively('document'))

		$scope.attributeTypes = {
			'Text': 		'0'
			'Number': 		'1'
			'Document': 	'2'
		}

		$scope.saveDocument = ->
			$scope.documents.save($scope.document)
			$scope.selectedDocument = null

		$scope.deleteDocument = ->
			return unless confirm('Are you sure?')
			$scope.documents.remove($scope.document)
			$scope.onDeleted()

		$scope.addAttribute = ->
			return unless name = window.prompt('Enter a name:')
			$scope.attributes.save
				'name': name
				'type': $scope.attributeTypes['Text']
				'document_id': $scope.document['_id']

		$scope.saveAttribute = (attribute) ->
			$scope.attributes.save(attribute)

		$scope.deleteAttribute = (attribute) ->
			return unless window.confirm('Are you sure?')
			$scope.attributes.remove(attribute)

