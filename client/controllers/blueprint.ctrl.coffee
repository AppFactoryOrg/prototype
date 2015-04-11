angular.module('app-factory').controller 'BlueprintCtrl', ($scope, $meteor, $modal, $stateParams, CreateDocumentSchemaModal) ->
	$scope.blueprintId = $stateParams.blueprint_id
	$scope.selectedDocumentSchema = null

	$meteor.subscribe('Blueprints')
	$meteor.subscribe('DocumentSchemas', $scope.blueprintId)

	$scope.blueprint = $meteor.object(Blueprints, $scope.blueprintId)
	$scope.documentSchemas = $meteor.collection -> DocumentSchemas.find('blueprint_id': $scope.blueprintId)

	$scope.selectDocumentSchema = (doc) -> $scope.selectedDocumentSchema = _.clone(doc)
	$scope.deselectDocumentSchema = -> $scope.selectedDocumentSchema = null
	$scope.documentIsSelected = (doc) -> return doc['_id'] is $scope.selectedDocumentSchema?['_id']

	$scope.createDocumentSchema = ->
		blueprint = $scope.blueprint
		modal = $modal.open(new CreateDocumentSchemaModal({blueprint}))
		modal.result.then (documentSchema) ->
			$scope.documentSchemas.save(documentSchema)