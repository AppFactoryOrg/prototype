angular.module('app-factory').config ($urlRouterProvider, $stateProvider) ->

	$stateProvider

		.state 'factory',
			url: '/factory'
			abstract: true
			templateUrl: 'client/templates/factory.template.html'

		.state 'factory.home',
			url: '/home'
			templateUrl: 'client/templates/home.template.html'

		.state 'factory.blueprints',
			url: '/blueprints'
			templateUrl: 'client/templates/blueprints.template.html'

		.state 'factory.blueprint',
			url: '/blueprint/:blueprint_id'
			templateUrl: 'client/templates/blueprint.template.html'

		.state 'factory.blueprint.documents',
			url: '/documents'
			templateUrl: 'client/templates/blueprint_documents.template.html'

		.state 'factory.blueprint.screens',
			url: '/screens'
			templateUrl: 'client/templates/blueprint_screens.template.html'

		.state 'factory.applications',
			url: '/applications'
			templateUrl: 'client/templates/applications.template.html'

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
