Meteor.publish 'Blueprints', () ->
	return Blueprints.find('owner_id': @userId)