angular.module('app-factory').controller 'BlueprintCtrl', ($scope, $meteor, $stateParams, $timeout) ->
	blueprint_id = $stateParams.blueprint_id

	$scope.blueprint = $meteor.object(Blueprints, blueprint_id).subscribe('Blueprints');
	$scope.documentSchemas = $meteor.collection(DocumentSchemas, false).subscribe('DocumentSchemas', blueprint_id)
	
	$scope.selectedDocumentSchema = null

	$scope.selectDocumentSchema = (doc) -> $scope.selectedDocumentSchema = _.clone(doc)
	$scope.deselectDocumentSchema = -> $scope.selectedDocumentSchema = null
	$scope.documentIsSelected = (doc) -> return doc['_id'] is $scope.selectedDocumentSchema?['_id']

	$scope.createDocumentSchema = ->
		return unless name = prompt('Enter a name:')
		$scope.documentSchemas.save
			'name': name
			'attributes': []
			'blueprint_id': blueprint_id

