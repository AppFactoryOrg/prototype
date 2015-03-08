angular.module('app-factory').directive 'afDocument', ($meteor) ->
	restrict: 'E'
	templateUrl: 'client/templates/document.template.html'
	scope:
		document: '='
	controller: ($scope) ->
		$scope.documents = $meteor.collection(Documents, false)

		$scope.saveDocument = ->
			$scope.documents.save($scope.document)
			$scope.selectedDocument = null

		$scope.deleteDocument = ->
			return unless confirm('Are you sure?')
			$scope.documents.remove($scope.document)
