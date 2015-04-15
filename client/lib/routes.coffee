angular.module('app-factory').config ($urlRouterProvider, $stateProvider) ->

	$stateProvider

		.state 'factory',
			url: '/factory'
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

		.state 'factory.applications',
			url: '/applications'
			templateUrl: 'client/templates/applications.template.html'

		.state 'application',
			url: '/application/:application_id'
			templateUrl: 'client/templates/application.template.html'
	
	$urlRouterProvider.otherwise '/factory/home'
