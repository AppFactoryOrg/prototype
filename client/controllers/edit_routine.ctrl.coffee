angular.module('app-factory').controller 'EditRoutineCtrl', ($scope, $meteor, $timeout, $state, $stateParams, ROUTINE_TYPES, ROUTINE_DATATYPES, SERVICES) ->

	$scope.canvas = null
	$scope.loaded = false
	$scope.saving = false
	$scope.routineDataTypes = ROUTINE_DATATYPES
	$scope.mode = {'delete': false}
	$scope.services = SERVICES
	$scope.selectedService = null

	# Setup canvas styles
	$scope.outflowEndpointStyle = 
		endpoint: 'Dot'
		isSource: true
		paintStyle:
			fillStyle: '#75c375'
			strokeStyle: '#a3d7a3'
			lineWidth: 2
			radius: 7
		connector: [
			'Flowchart'
			{
				stub: [
					10
					10
				]
				gap: 11
				cornerRadius: 5
				alwaysRespectStubs: true
			}
		]
		connectorStyle: 
			lineWidth: 2
			strokeStyle: '#5bc0de'
			joinstyle: 'round'
		hoverPaintStyle: 
			fillStyle: '#5bc0de'
			strokeStyle: '#5bc0de'
		connectorHoverStyle: 
			lineWidth: 4
			strokeStyle: '#5bc0de'
		dragOptions: {}

	$scope.inflowEndpointStyle = 
		endpoint: 'Dot'
		isTarget: true
		paintStyle:
			fillStyle: '#df706c'
			strokeStyle: '#eba5a3'
			radius: 7
			lineWidth: 2
		hoverPaintStyle: 
			fillStyle: '#5bc0de'
			strokeStyle: '#5bc0de'
		maxConnections: 1
		dropOptions:
			hoverClass: 'hover'
			activeClass: 'active'

	$scope.outputEndpointStyle = 
		endpoint: 'Dot'
		isSource: true
		paintStyle:
			fillStyle: '#837a9f'
			strokeStyle: '#a7a1ba'
			lineWidth: 2
			radius: 5
		connector: [
			'Flowchart'
			{
				stub: [
					10
					10
				]
				gap: 8
				cornerRadius: 5
				alwaysRespectStubs: true
			}
		]
		connectorStyle: 
			lineWidth: 2
			strokeStyle: '#a7a1ba'
			joinstyle: 'round'
		hoverPaintStyle: 
			fillStyle: '#5bc0de'
			strokeStyle: '#5bc0de'
		connectorHoverStyle: 
			lineWidth: 4
			strokeStyle: '#a7a1ba'
		dragOptions: {}

	$scope.inputEndpointStyle = 
		endpoint: 'Dot'
		isTarget: true
		paintStyle:
			fillStyle: '#837a9f'
			strokeStyle: '#a7a1ba'
			radius: 5
			lineWidth: 2
		hoverPaintStyle: 
			fillStyle: '#5bc0de'
			strokeStyle: '#5bc0de'
		maxConnections: 1
		dropOptions:
			hoverClass: 'hover'
			activeClass: 'active'

	$scope.buildWorkflow = -> $timeout ->
		jsPlumb.ready ->
			$scope.canvas = jsPlumb.getInstance(
				Container: "workflow-canvas" 
			)

			$scope.routine.services.forEach (service) -> $scope.setupService(service)
			$scope.routine.connections.forEach (connection) -> $scope.setupConnection(connection)
	, 500

	$scope.addService = (service) ->
		service = angular.copy(service)
		service['id'] = Meteor.uuid()
		service['position'] = {x: 100, y: 50}
		$scope.routine.services.push(service)
		$timeout -> $scope.setupService(service)

	$scope.removeService = (service) ->
		$scope.routine.services.splice($scope.routine.services.indexOf(service), 1)
		service.nodes.forEach (node) ->
			$scope.canvas.deleteEndpoint("#{service.id}_#{node.name}");

	$scope.setupService = (service) ->
		if service.position?
			serviceElement = document.getElementById(service['id'])
			serviceElement.style.left = service.position.x
			serviceElement.style.top = service.position.y

		$scope.canvas.draggable(document.getElementById(service['id']), grid: [20, 20])

		service.nodes.forEach (node) ->
			endpointStyle = $scope.inflowEndpointStyle if node.type is 'inflow'
			endpointStyle = $scope.outflowEndpointStyle if node.type is 'outflow'
			endpointStyle = $scope.inputEndpointStyle if node.type is 'input'
			endpointStyle = $scope.outputEndpointStyle if node.type is 'output'
			additionalStyles = {
				anchor: node.position
				uuid: "#{service.id}_#{node.name}"
			}
			if node.label?
				additionalStyles['overlays'] = [
					[ "Label", { 
						id: "#{service.id}_#{node.name}_label" 
						label: node.label
						location: node.labelPosition
						cssClass: 'service-node-label'
					}]
				]
			$scope.canvas.addEndpoint(service['id'], endpointStyle, additionalStyles)

	$scope.setupConnection = (connection) ->
		$scope.canvas.connect({uuids: [connection.fromNode, connection.toNode], editable: true})

	$scope.serviceClicked = (service, event) ->
		$scope.removeService(service) if $scope.mode.delete
		event.stopPropagation()

	$scope.openServiceConfig = (service) ->
		$scope.selectedService = service

	$scope.closeServiceConfig = ->
		$scope.selectedService = null

	$scope.goBack = ->
		return unless confirm("Are you sure? Changes may be lost.")
		$state.go('factory.blueprint.routines', {blueprint_id: $scope.blueprintId})

	$scope.save = ->
		$scope.routine.services.forEach (service) ->
			serviceElement = document.getElementById(service['id'])
			service.position =
				x: serviceElement.style.left
				y: serviceElement.style.top

		$scope.routine.connections = []
		connections = $scope.canvas.getConnections()
		connections.forEach (connection) ->
			ids = connection.getUuids()
			$scope.routine.connections.push
				fromNode: ids[0]
				toNode: ids[1]

		$meteor.collection(Routines).save($scope.routine)
		mixpanel.track('routine_updated')

		$scope.saving = true
		$timeout( -> 
			$scope.saving = false
		, 1000)

	# Initialize
	$meteor.subscribe('Routines', $scope.blueprintId).then ->
		$scope.routine = Routines.findOne($stateParams['routine_id'])
		$scope.loaded = true
		$scope.buildWorkflow()

	# Prevent back navigation
	$timeout -> $scope.$on '$locationChangeStart', (event) -> event.preventDefault()

