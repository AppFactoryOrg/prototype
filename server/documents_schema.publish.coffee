Meteor.publish 'DocumentSchemas', (application_id) ->
	return DocumentSchemas.find('blueprint_id': blueprint_id)