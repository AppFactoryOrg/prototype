Meteor.publish 'UserAccess', (application_id, user_id) ->
	if user_id
		return UserAccess.find('application_id': application_id, 'user_id': user_id)
	else
		return UserAccess.find('application_id': application_id)

Meteor.publish 'UserAccessRegistration', (invite_code) ->
	return UserAccess.find('invite_code': invite_code)
