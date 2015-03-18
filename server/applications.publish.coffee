Meteor.publish 'Applications', (application_id) ->
	if application_id
		return Applications.find('_id': application_id)
	else
		return Applications.find()