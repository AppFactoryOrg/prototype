angular.module('app-factory').factory 'CreateRoutineModal', ->
	return ->
		templateUrl: 'client/templates/create_routine.template.html'
		controller: 'CreateRoutineCtrl'

angular.module('app-factory').controller 'CreateRoutineCtrl', ($scope, $meteor, $modalInstance, $stateParams, ROUTINE_TYPES, ROUTINE_DATATYPES) ->
	
	$meteor.subscribe('DocumentSchemas', $stateParams.blueprint_id).then (handle) ->
		$scope.$on '$destroy', -> handle?.stop()

	$scope.documentSchemas = $meteor.collection -> DocumentSchemas.find('blueprint_id': $stateParams.blueprint_id)
	$scope.selectedDocumentSchemaId = null
	$scope.routineTypes = ROUTINE_TYPES
	$scope.routine =
		'blueprint_id': $stateParams.blueprint_id
		'name': ''
		'description': ''
		'type': ROUTINE_TYPES['General']
		'document_schema_id': null
		'inputs': []
		'outputs': []
		'services': []
		'connections': []

	$scope.showDocumentSelection = ->
		return true if $scope.routine['type'] is ROUTINE_TYPES['Document Action']
		return true if $scope.routine['type'] is ROUTINE_TYPES['Document Attribute']
		return false

	$scope.submit = ->
		# Setup inputs and outputs
		switch $scope.routine['type']
			when ROUTINE_TYPES['Document Action']
				$scope.routine['document_schema_id'] = $scope.selectedDocumentSchemaId
			when ROUTINE_TYPES['Document Attribute']
				$scope.routine['document_schema_id'] = $scope.selectedDocumentSchemaId

		$modalInstance.close($scope.routine)