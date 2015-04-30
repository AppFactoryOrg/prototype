Meteor.publish 'Views', (blueprint_id) ->
	return Views.find('blueprint_id': blueprint_id)