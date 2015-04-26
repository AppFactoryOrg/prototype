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
			execute: -> 
				throw new Error("Input service does not have a configuration") unless configuration?
				
				input = configuration['input']

				return [{node: 'value', value: input}]
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
			execute: ({configuration}) ->
				throw new Error("Value service does not have a configuration") unless configuration?
				
				value = configuration['value']
				
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
			execute: ({inputs}) ->
				throw new Error("Display Message service does not have any inputs") unless inputs?
				throw new Error("Display Message service does not have a 'message' input") unless inputs.hasOwnProperty('message')
				
				message = inputs['message']
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
					position: [0, 0.8, -1, 0]
					label: 'Updates'
					labelPosition: [2.5, 0.55]
				}
			]
			execute: ({inputs, configuration}) ->
				throw new Error("Update Document service does not have any inputs") unless inputs?
				throw new Error("Update Document service does not have a 'document' input") unless inputs.hasOwnProperty('document')
				throw new Error("Update Document service does not have a 'updates' input") unless inputs.hasOwnProperty('updates')
				
				document = inputs['document']
				updates = inputs['updates']
				# Do updates
				$meteor.collection(Documents).save(document)
				
				return [{node: 'out'}]
		}
		#########################################################################################
		# MODIFY ATTRIBUTE
		#########################################################################################
		{
			serviceId: 'modify_attribute'
			name: 'Modify Attribute'
			color: '#70678E'
			class: 'modify-attribute'
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
					name: 'update'
					type: 'output'
					position: 'Right'
				}
			]
			execute: ({inputs, configuration}) ->
				throw new Error("Modify Attribites service does not have any inputs") unless inputs?
				throw new Error("Update Document service does not have a 'value' input") unless inputs.hasOwnProperty('value')
				throw new Error("Modify Attribites service does not have a configuration") unless configuration?
				
				update = 
					attribute_id: configuration['attribute_id']
					value: inputs['value']

				return [{node: 'value', value: update}]
		}
	]
