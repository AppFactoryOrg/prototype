Meteor.publish 'Blueprints', () ->
	Blueprints.find('owner_id': @userId)