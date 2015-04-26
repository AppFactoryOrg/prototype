angular.module('app-factory').factory 'SERVICES', ($meteor) ->
	return [
		#########################################################################################
		# START
		#########################################################################################
		{ 
			serviceId: 'start'
			name: 'Start'
			class: 'start'
			color: '#5cb85c'
			configurable: false
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
		#########################################################################################
		# END
		#########################################################################################
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
		#########################################################################################
		# INPUT
		#########################################################################################
		{ 
			serviceId: 'input'
			name: 'Input'
			class: 'input'
			color: '#70678E'
			configurable: false
			configuration: {}
			nodes: [
				{
					name: 'value'
					type: 'output'
					position: 'Right'
				}
			]
			execute: ({service, routineInputs})-> 
				throw new Error("Input service does not have a configuration") unless service.configuration?
				
				input = service.configuration['input']
				inputData = _.find(routineInputs, {'name': input['name']})
				throw new Error("Input service could not find required input data") unless inputData?

				value = inputData['value']

				return [{node: 'value', value: value}]
		}
		#########################################################################################
		# OUTPUT
		#########################################################################################
		{ 
			serviceId: 'output'
			name: 'Output'
			class: 'output'
			color: '#70678E'
			configurable: false
			configuration: {}
			nodes: [
				{
					name: 'value'
					type: 'input'
					position: 'Left'
				}
			]
			execute: -> 
				return []
		}
		#########################################################################################
		# VALUE
		#########################################################################################
		{
			serviceId: 'value'
			name: 'Value'
			color: '#70678E'
			class: 'value'
			configurable: true
			configuration: 
				value: ''
			nodes: [
				{
					name: 'value'
					type: 'output'
					position: 'Right'
				}
			]
			execute: ({service}) ->
				throw new Error("Value service does not have a configuration") unless service.configuration?
				
				value = service.configuration['value']
				
				return [{node: 'value', value: value}]
		}
		#########################################################################################
		# DISPLAY MESSAGE
		#########################################################################################
		{ 
			serviceId: 'display_message'
			name: 'Display Message'
			color: '#2b3e50'
			configurable: false
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
			execute: ({service}) ->
				throw new Error("Display Message service does not have any inputs") unless service.inputs?
				throw new Error("Display Message service does not have a 'message' input") unless service.inputs.hasOwnProperty('message')
				
				message = service.inputs['message']
				alert(message)
				
				return [{node: 'out'}]
		}
		#########################################################################################
		# UPDATE DOCUMENT
		#########################################################################################
		{ 
			serviceId: 'update_document'
			name: 'Update Document'
			color: '#2b3e50'
			configurable: false
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
					name: 'document'
					type: 'input'
					position: [0, 0.6, -1, 0]
					label: 'Document'
					labelPosition: [2.9, 0.55]
				}
				{
					name: 'updates'
					type: 'input'
					multiple: true
					position: [0, 0.8, -1, 0]
					label: 'Updates'
					labelPosition: [2.5, 0.55]
				}
			]
			execute: ({service}) ->
				throw new Error("Update Document service does not have any inputs") unless service.inputs?
				throw new Error("Update Document service does not have a 'document' input") unless service.inputs.hasOwnProperty('document')
				throw new Error("Update Document service does not have a 'updates' input") unless service.inputs.hasOwnProperty('updates')
				
				document = service.inputs['document']
				
				updates = service.inputs['updates']
				updates.forEach (update) ->
					document['data'][update['attribute_id']] = update['value']

				$meteor.collection(Documents).save(document)
				
				return [{node: 'out'}]
		}
		#########################################################################################
		# SET ATTRIBUTE
		#########################################################################################
		{
			serviceId: 'set_attribute'
			name: 'Set Attribute'
			color: '#70678E'
			class: 'set-attribute'
			configurable: true
			configuration: 
				document_schema_id: ''
				attribute_id: ''
			nodes: [
				{
					name: 'value'
					type: 'input'
					position: 'Left'
				}
				{
					name: 'output'
					type: 'output'
					position: 'Right'
				}
			]
			execute: ({service}) ->
				throw new Error("Set Attribite service does not have any inputs") unless service.inputs?
				throw new Error("Set Attribite service does not have a 'value' input") unless service.inputs.hasOwnProperty('value')
				throw new Error("Set Attribite service does not have a configuration") unless service.configuration?
				
				value = 
					attribute_id: service.configuration['attribute_id']
					value: service.inputs['value']

				return [{node: 'output', value: value}]
		}
	]
