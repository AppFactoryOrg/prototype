Meteor.publish 'Applications', (application_id) ->
	if application_id
		return Applications.find('_id': application_id, 'owner_id': @userId)
	else
		return Applications.find('owner_id': @userId)