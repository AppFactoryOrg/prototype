angular.module('app-factory').factory 'SERVICES', (SERVICE_TYPES) ->
	return [
		{ 
			serviceId: 'start'
			type: SERVICE_TYPES['Start']
			name: 'Start'
			class: 'start'
			color: '#5cb85c'
			configuration: {}
			nodes: [
				{
					name: 'out'
					type: 'outflow'
					position: 'Right'
				}
			]
			execute: -> 
				return {node: 'out'}
		}
		{ 
			serviceId: 'end'
			type: SERVICE_TYPES['End']
			name: 'End'
			class: 'end'
			color: '#d9534f'
			configuration: {}
			nodes: [
				{
					name: 'in'
					type: 'inflow'
					position: 'Left'
				}
			]
			execute: ({routine}) ->
				routine.terminate()
				return null
		}
		{ 
			serviceId: 'display_message'
			type: SERVICE_TYPES['General']
			name: 'Display Message'
			color: '#2b3e50'
			configuration: {}
			nodes: [
				{
					name: 'in'
					type: 'inflow'
					position: [0, 0.25, -1, 0]
				}
				{
					name: 'out'
					type: 'outflow'
					position: [1, 0.25, 1, 0]
				}
				{
					name: 'message'
					type: 'input'
					position: [0, 0.75, -1, 0]
					label: 'Message'
					labelPosition: [2.7, 0.55]
				}
			]
			execute: ({inputs}) ->
				message = inputs['message']
				alert(message)
				return {node: 'out'}
		}
		{
			serviceId: 'value'
			type: SERVICE_TYPES['Value']
			name: 'Value'
			color: '#70678E'
			class: 'value'
			configuration: 
				value: ''
			nodes: [
				{
					name: 'value'
					type: 'output'
					position: 'Right'
				}
			]
			execute: ({configuration}) ->
				return {node: 'value', value: configuration['value']}
		}
	]
