angular.module 'app-factory', [
	'angular-meteor'
	'ui.router'
	'ui.bootstrap'
	'xeditable'
	'cloudinary'
	'angularFileUpload'
]

angular.module('app-factory').run (editableOptions, $rootScope) ->
	editableOptions.theme = 'bs3'

	$rootScope.$watch 'currentUser', (newValue, oldValue) ->
		if newValue?
			id = newValue['_id']
			email = newValue['emails'][0]['address']
			mixpanel.people.set('$email': email)
			mixpanel.identify(id)
		else
			mixpanel.identify(null)

	$rootScope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
		mixpanel.track('navigated', {'route': toState.name})

	$.cloudinary.config().cloud_name = 'appfactoryprototype'
	$.cloudinary.config().upload_preset = 'vz1klqpv'