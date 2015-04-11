Meteor.publish 'Attributes', (blueprint_id) ->
	return Attributes.find('blueprint_id': blueprint_id)