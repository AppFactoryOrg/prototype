Meteor.publish 'Routines', (blueprint_id) ->
	return Routines.find('blueprint_id': blueprint_id)