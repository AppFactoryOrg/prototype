Meteor.publish 'Documents', (application_id, document_schema_id) ->
	return Documents.find
		'application_id': application_id
		'document_schema_id': document_schema_id