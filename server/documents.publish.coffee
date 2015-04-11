Meteor.publish 'Documents', (application_id) ->
	return Documents.find
		'application_id': application_id
