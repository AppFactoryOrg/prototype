angular.module('app-factory').factory 'EditDocumentModal', ->
	return ({document, documentSchema}) ->
		templateUrl: 'client/templates/edit_document.template.html'
		controller: 'EditDocumentCtrl'
		resolve:
			'document': -> document
			'documentSchema': -> documentSchema

angular.module('app-factory').controller 'EditDocumentCtrl', ($scope, $rootScope, $meteor, $modalInstance, document, documentSchema, ATTRIBUTE_TYPES) ->
	$scope.document = angular.copy(document)
	$scope.documentSchema = documentSchema
	$scope.attributes = $meteor.collection(Attributes, false)

	$meteor.subscribe('Attributes', document.document_schema_id).then ->

	$scope.submit = ->
		$modalInstance.close( $scope.document )