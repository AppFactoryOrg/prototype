Meteor.startup ->
	console.log 'App Factory initialized.'

Accounts.ui.config
	passwordSignupFields: 'USERNAME_ONLY'