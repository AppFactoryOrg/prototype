Meteor.publish 'DocumentSchemas', (blueprint_id) ->
	return DocumentSchemas.find('blueprint_id': blueprint_id)