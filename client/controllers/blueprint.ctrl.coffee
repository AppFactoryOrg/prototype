angular.module('app-factory').controller 'BlueprintCtrl', ($scope, $meteor, $stateParams) ->
	blueprint_id = $stateParams.blueprint_id

	$scope.blueprint = $meteor.object(Blueprints, blueprint_id)
	$scope.documents = $meteor.collection(Documents, false).subscribe('DocumentsByBlueprint', blueprint_id)
	
	$scope.selectedDocument = null

	$scope.selectDocument = (doc) -> $scope.selectedDocument = _.clone(doc)
	$scope.documentIsSelected = (doc) -> return doc['_id'] is $scope.selectedDocument?['_id']

	$scope.createDocument = ->
		return unless name = prompt('Enter a name:')
		$scope.documents.save
			'name': name
			'attributes': []
			'blueprint_id': blueprint_id

