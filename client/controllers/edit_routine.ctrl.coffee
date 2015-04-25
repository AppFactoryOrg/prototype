angular.module('app-factory').factory 'EditRoutineModal', ->
	return ({routine}) ->
		templateUrl: 'client/templates/edit_routine.template.html'
		controller: 'EditRoutineCtrl'
		backdrop: 'static'
		keyboard: 'false'
		windowClass: 'fullscreen-modal'
		resolve:
			'routine': -> routine

angular.module('app-factory').controller 'EditRoutineCtrl', ($scope, $meteor, $timeout, $modalInstance, $stateParams, routine, ROUTINE_TYPES, ROUTINE_DATATYPES) ->

	$scope.routine = angular.copy(routine)

	$scope.dismiss = ->
		return unless confirm("Are you sure you want to cancel? Changes will be lost.")
		$modalInstance.dismiss()

	$scope.submit = ->
		$modalInstance.close($scope.routine)

	$scope.buildWorkflow = ->
		jsPlumb.ready ->
			canvas = jsPlumb.getInstance(
				Container: "workflow-canvas" 
			)

			basicType =
				connector: "StateMachine"
				paintStyle: { strokeStyle: "red", lineWidth: 4 }
				hoverPaintStyle: { strokeStyle: "blue" }
				overlays: ["Arrow"]

			canvas.registerConnectionType("basic", basicType)

			canvas.draggable(document.querySelectorAll('#workflow-canvas .service'), grid: [20, 20])

			connectorPaintStyle = 
				lineWidth: 4
				strokeStyle: '#61B7CF'
				joinstyle: 'round'
				outlineColor: 'white'
				outlineWidth: 2

			connectorHoverStyle = 
				lineWidth: 4
				strokeStyle: '#216477'
				outlineWidth: 2
				outlineColor: 'white'

			endpointHoverStyle = 
				fillStyle: '#216477'
				strokeStyle: '#216477'

			sourceEndpoint = 
				endpoint: 'Dot'
				paintStyle:
					strokeStyle: '#7AB02C'
					fillStyle: 'transparent'
					radius: 7
					lineWidth: 3
				isSource: true
				connector: [
					'Flowchart'
					{
						stub: [
							40
							60
						]
						gap: 10
						cornerRadius: 5
						alwaysRespectStubs: true
					}
				]
				connectorStyle: connectorPaintStyle
				hoverPaintStyle: endpointHoverStyle
				connectorHoverStyle: connectorHoverStyle
				dragOptions: {}

			targetEndpoint = 
				endpoint: 'Dot'
				paintStyle:
					fillStyle: '#7AB02C'
					radius: 11
				hoverPaintStyle: endpointHoverStyle
				maxConnections: -1
				dropOptions:
					hoverClass: 'hover'
					activeClass: 'active'
				isTarget: true

			_addEndpoints = (toId, sourceAnchors, targetAnchors) ->
				i = 0
				while i < sourceAnchors.length
					sourceUUID = toId + sourceAnchors[i]
					canvas.addEndpoint toId, sourceEndpoint,
						anchor: sourceAnchors[i]
						uuid: sourceUUID
					i++

				j = 0
				while j < targetAnchors.length
					targetUUID = toId + targetAnchors[j]
					canvas.addEndpoint toId, targetEndpoint,
						anchor: targetAnchors[j]
						uuid: targetUUID
					j++

			_addEndpoints 'service-1', [
				'TopCenter'
				'BottomCenter'
			], [
				'LeftMiddle'
				'RightMiddle'
			]
			_addEndpoints 'service-2', [
				'LeftMiddle'
				'BottomCenter'
			], [
				'TopCenter'
				'RightMiddle'
			]
			_addEndpoints 'service-3', [
				'RightMiddle'
				'BottomCenter'
			], [
				'LeftMiddle'
				'TopCenter'
			]
			_addEndpoints 'service-4', [
				'LeftMiddle'
				'RightMiddle'
			], [
				'TopCenter'
				'BottomCenter'
			]

