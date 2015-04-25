angular.module('app-factory').factory 'EditRoutineModal', ->
	return ({routine}) ->
		templateUrl: 'client/templates/edit_routine.template.html'
		controller: 'EditRoutineCtrl'
		backdrop: 'static'
		keyboard: 'false'
		windowClass: 'fullscreen-modal'
		resolve:
			'routine': -> routine

angular.module('app-factory').controller 'EditRoutineCtrl', ($scope, $meteor, $modalInstance, $stateParams, routine, ROUTINE_TYPES, ROUTINE_DATATYPES) ->

	$scope.routine = angular.copy(routine)

	$scope.dismiss = ->
		return unless confirm("Are you sure you want to cancel? Changes will be lost.")
		$modalInstance.dismiss()

	$scope.submit = ->
		$modalInstance.close($scope.routine)