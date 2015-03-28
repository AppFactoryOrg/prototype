angular.module('app-factory').controller 'BlueprintCtrl', ($scope, $meteor, $modal, $stateParams, CreateDocumentSchemaModal) ->
	blueprint_id = $stateParams.blueprint_id

	$scope.blueprint = $meteor.object(Blueprints, blueprint_id).subscribe('Blueprints')
	$scope.documentSchemas = $meteor.collection(DocumentSchemas, false)

	$meteor.subscribe('DocumentSchemas', blueprint_id).then (handle) ->
		$scope.$on '$destroy', -> handle?.stop()
	
	$scope.selectedDocumentSchema = null

	$scope.selectDocumentSchema = (doc) -> $scope.selectedDocumentSchema = _.clone(doc)
	$scope.deselectDocumentSchema = -> $scope.selectedDocumentSchema = null
	$scope.documentIsSelected = (doc) -> return doc['_id'] is $scope.selectedDocumentSchema?['_id']

	$scope.createDocumentSchema = ->
		blueprint = $scope.blueprint

		modal = $modal.open(new CreateDocumentSchemaModal({blueprint}))
		modal.result.then (documentSchema) ->
			$scope.documentSchemas.save(documentSchema)