angular.module('app-factory').controller 'BlueprintRoutinesCtrl', ($scope, $meteor, $modal, $stateParams, CreateRoutineModal, EditRoutineModal, ROUTINE_TYPES) ->
	$meteor.subscribe('Routines', $scope.blueprintId)

	$scope.routines = $meteor.collection -> Routines.find('blueprint_id': $scope.blueprintId)
	$scope.routineTypes = ROUTINE_TYPES

	$scope.createRoutine = ->
		modal = $modal.open(new CreateRoutineModal())
		modal.result.then (routine) ->
			$meteor.collection(Routines).save(routine)
			mixpanel.track('routine_created')

	$scope.editRoutine = (routine) ->
		modal = $modal.open(new EditRoutineModal({routine}))
		modal.result.then (routine) ->
			$meteor.collection(Routines).save(routine)
			mixpanel.track('routine_updated')

	$scope.deleteRoutine = (routine) ->
		return unless confirm('Are you sure?')
		$meteor.collection(Routines).remove(routine['_id'])
		mixpanel.track('routine_deleted')

	$scope.formatRoutineInputs = (routine) ->
		return _.pluck(routine.inputs, 'name').join(', ')

	$scope.formatRoutineOutputs = (routine) ->
		return _.pluck(routine.outputs, 'name').join(', ')
