Meteor.publish 'DocumentsByBlueprint', (blueprint_id) ->
	return Documents.find('blueprint_id': blueprint_id)