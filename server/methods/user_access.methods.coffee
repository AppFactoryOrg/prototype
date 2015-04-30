Meteor.methods
	'UserAccess.invite': (user_access) ->
		user_access['invite_code'] = Meteor.uuid()

		application = Applications.findOne(user_access['application_id'])

		Email.send
			from: "no-reply@app-factory.io"
			to: user_access['email']
			subject: "Invitation to Collaborate on #{application.name}"
			text: " 
				You have been invited to collaborate on the #{application.name} application. \n
				Use the link below to complete your registration: \n\n
				http://appfactory-proto.meteor.com/#/register?code=#{user_access.invite_code}
			"

		UserAccess.insert(user_access)

	'UserAccess.confirm': (user_access) ->
		UserAccess.update(user_access['_id'], 
			$set: 
				'confirmed': true
		)
