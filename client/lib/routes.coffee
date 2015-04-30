angular.module('app-factory').config ($urlRouterProvider, $stateProvider) ->

	$stateProvider

		.state 'register',
			url: '/register?code'
			templateUrl: 'client/templates/register.template.html'

		.state 'factory',
			url: '/factory'
			abstract: true
			templateUrl: 'client/templates/factory.template.html'

		.state 'factory.home',
			url: '/home'
			templateUrl: 'client/templates/home.template.html'

		.state 'factory.applications',
			url: '/applications'
			templateUrl: 'client/templates/applications.template.html'

		.state 'factory.blueprint',
			url: '/blueprint/:application_id/:blueprint_id'
			templateUrl: 'client/templates/blueprint.template.html'

		.state 'factory.blueprint.documents',
			url: '/documents'
			templateUrl: 'client/templates/blueprint_documents.template.html'

		.state 'factory.blueprint.screens',
			url: '/screens'
			templateUrl: 'client/templates/blueprint_screens.template.html'

		.state 'factory.blueprint.routines',
			url: '/routines'
			templateUrl: 'client/templates/blueprint_routines.template.html'

		.state 'factory.blueprint.routine',
			url: '/routine/:routine_id'
			templateUrl: 'client/templates/edit_routine.template.html'

		.state 'factory.blueprint.users',
			url: '/users'
			templateUrl: 'client/templates/blueprint_users.template.html'

		.state 'application',
			url: '/application/:application_id'
			abstract: true
			templateUrl: 'client/templates/application.template.html'

		.state 'application.home',
			url: '/home'
			templateUrl: 'client/templates/application_home.template.html'

		.state 'application.screen',
			url: '/screen/:screen_schema_id'
			templateUrl: 'client/templates/application_screen.template.html'
	
	$urlRouterProvider.otherwise '/factory/home'
