angular.module('app-factory').controller 'BlueprintCtrl', ($scope, $meteor, $stateParams, $timeout) ->
	blueprint_id = $stateParams.blueprint_id

	$scope.blueprint = $meteor.object(Blueprints, blueprint_id).subscribe('Blueprints');
	$scope.documents = $meteor.collection(Documents, false).subscribe('Documents', blueprint_id)
	
	$scope.selectedDocument = null

	$scope.selectDocument = (doc) -> $scope.selectedDocument = _.clone(doc)
	$scope.deselectDocument = -> $scope.selectedDocument = null
	$scope.documentIsSelected = (doc) -> return doc['_id'] is $scope.selectedDocument?['_id']

	$scope.createDocument = ->
		return unless name = prompt('Enter a name:')
		$scope.documents.save
			'name': name
			'attributes': []
			'blueprint_id': blueprint_id

