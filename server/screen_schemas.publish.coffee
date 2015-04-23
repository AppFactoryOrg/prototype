Meteor.publish 'ScreenSchemas', (blueprint_id) ->
	return ScreenSchemas.find('blueprint_id': blueprint_id)