angular.module('app-factory').factory 'RoutineHandler', (SERVICES) ->
	execute: (routine, inputs) ->
		console.log("Starting execution of routine '#{routine.name}'", routine)

		services = angular.copy(routine.services)
		throw new Error('Routine has no services.') unless services.length

		connections = angular.copy(routine.connections)
		throw new Error('Routine has no connections.') unless connections.length

		stackCounter = 0
		processService = (service) ->
			console.log("Starting processing of service '#{service.name}'", service)

			# Prevent infinite loops
			stackCounter++
			throw new Error('Routine got stuck in an infinite loop.') if stackCounter > 1000
			
			# Check for inputs and execute them first
			inputNodes = _.filter(service.nodes, {'type': 'input'})
			inputNodes.forEach (inputNode) ->
				inputConnection = _.find(connections, {'toNode': "#{service.id}_#{inputNode.name}"})
				throw new Error('Routine cannot find input connection.') unless inputConnection?

				inputService = _.find(services, {'id': inputConnection['fromNode'].split('_')[0]})
				throw new Error('Routine cannot find input service.') unless inputService?

				processService(inputService)

			# Lookup the service template, which contains the execute function
			serviceTemplate = _.find(SERVICES, {'serviceId': service['serviceId']})
			throw new Error('Routine cannot find matching service template.') unless serviceTemplate?

			# Execute the service
			inputs = service.inputs
			configuration = service.configuration
			results = serviceTemplate.execute({inputs, configuration})
			throw new Error('Routine service execution results were empty.') if _.isEmpty(results)

			results.forEach (result) ->
				# Exit early if the result calls for termination
				if result['terminate']?
					# routine.terminate()
					console.log("Ending processing of service '#{service.name}'")
					console.log("Ending execution of routine '#{routine.name}'")
					return

				# Process result node
				if result['node']?
					resultNode = _.find(service.nodes, {'name': result['node']})
					throw new Error('Routine cannot result node of service execution.') unless resultNode?

					outputConnection = _.find(connections, {'fromNode': "#{service.id}_#{resultNode.name}"})
					throw new Error('Routine cannot find output connection.') unless outputConnection?

					outputService = _.find(services, {'id': outputConnection['toNode'].split('_')[0]})
					throw new Error('Routine cannot find output service.') unless outputService?

					
					if resultNode.type is 'output'
						# Pass output value to next service
						inputNode = _.find(outputService.nodes, {name: outputConnection['toNode'].split('_')[1]})
						throw new Error('Routine cannot find input node of output service.') unless inputNode?
						
						outputService.inputs = [] unless outputService.inputs?
						outputService.inputs[inputNode.name] = result['value']
						console.log("Ending processing of service '#{service.name}'")

					else if resultNode.type is 'outflow'
						# Pass flow to next service
						console.log("Ending processing of service '#{service.name}'")
						processService(outputService)


		# Kick it off
		start = _.findWhere(services, serviceId: 'start')
		throw new Error('Routine has no Start service.') unless start?

		processService(start)