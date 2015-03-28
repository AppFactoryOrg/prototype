angular.module('app-factory').factory 'CreateDocumentSchemaModal', ->
	return ({blueprint}) ->
		templateUrl: 'client/templates/create_document_schema.template.html'
		controller: 'CreateDocumentSchemaCtrl'
		resolve:
			'blueprint': -> blueprint

angular.module('app-factory').controller 'CreateDocumentSchemaCtrl', ($scope, $meteor, $modalInstance, blueprint) ->
	$scope.documentSchema =
		'name': ''
		'blueprint_id': blueprint['_id']

	$scope.submit = ->
		$modalInstance.close( $scope.documentSchema )