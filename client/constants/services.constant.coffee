angular.module('app-factory').factory 'SERVICES', ->
	return [
		{ 
			serviceId: 'start'
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
				return [{node: 'out'}]
		}
		{ 
			serviceId: 'end'
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
			execute: ->
				return [{terminate: true}]
		}
		{ 
			serviceId: 'display_message'
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
				throw new Error("Display Message service does not have any inputs") unless inputs?
				throw new Error("Display Message service does not have a 'message' input") unless inputs.hasOwnProperty('message')
				
				message = inputs['message']
				alert(message)
				
				return [{node: 'out'}]
		}
		{
			serviceId: 'value'
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
				throw new Error("Display Message service does not have a configuration") unless configuration?
				
				value = configuration['value']
				
				return [{node: 'value', value: value}]
		}
	]
