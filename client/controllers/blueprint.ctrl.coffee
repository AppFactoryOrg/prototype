angular.module('app-factory').controller 'BlueprintCtrl', ($scope, $meteor) ->
	blueprint_id = Router.current().params.id

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

	$scope.saveDocument = (doc) ->
		$scope.documents.save(doc)
		$scope.selectedDocument = null

	$scope.deleteDocument = (doc) ->
		return unless confirm('Are you sure?')
		$scope.documents.remove(doc)
		$scope.selectedDocument = null if $scope.selectedDocument is doc
